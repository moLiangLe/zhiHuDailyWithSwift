//
//  UIImageExtension.swift
//  Addition
//
//  Created by kugou on 16/2/23.
//  Copyright © 2016年 kugou. All rights reserved.
//

import UIKit

public struct UIImageColors {
    public var backgroundColor: UIColor!
    public var primaryColor: UIColor!
    public var secondaryColor: UIColor!
    public var detailColor: UIColor!
}

class PCCountedColor {
    let color: UIColor
    let count: Int
    
    init(color: UIColor, count: Int) {
        self.color = color
        self.count = count
    }
}

extension UIImage {
    class func imageWithColor(color :UIColor, size :CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithColor(color :UIColor) -> UIImage {
        return imageWithColor(color, size: CGSize(width: 1, height: 1))
    }
    
    /**
     截取一个圆形的图片
     
     - parameter radius: 半径
     
     - returns: 一张圆形的图片
     */
    func cutImageWithRadius(radius :CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(size)

        guard let gc = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let x1: CGFloat = 0
        let y1: CGFloat = 0
        let x2 = x1 + size.width
        let y2 = y1
        let x3 = x2
        let y3 = y1 + size.height
        let x4 = x1
        let y4 = y3
        let radius = radius * 2
        
        CGContextMoveToPoint(gc, x1, y1 + radius)
        CGContextAddArcToPoint(gc, x1, y1, x1 + radius, y1, radius)
        CGContextAddArcToPoint(gc, x2, y2, x2, y2 + radius, radius)
        CGContextAddArcToPoint(gc, x3, y3, x3 - radius, y3, radius)
        CGContextAddArcToPoint(gc, x4, y4, x4, y4 - radius, radius)
        
        CGContextClosePath(gc)
        CGContextClip(gc)
        
        CGContextTranslateCTM(gc, 0, size.height)
        CGContextScaleCTM(gc, 1, -1)
        CGContextDrawImage(gc, CGRectMake(0, 0, size.width, size.height), CGImage)
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newimage

    }
    
    func tintedImageWithColor(color :UIColor , alpha :CGFloat) -> UIImage? {
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, scale)

        guard let ctx = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        self.drawInRect(imageRect)

        CGContextSetFillColorWithColor(ctx, color.CGColor)
        CGContextSetAlpha(ctx, alpha)
        CGContextSetBlendMode(ctx, .SourceAtop)
        CGContextFillRect(ctx, imageRect)
    
        guard let imageRef = CGBitmapContextCreateImage(ctx) else {
            UIGraphicsEndImageContext()
            return nil
        }

        let  darkImage = UIImage(CGImage: imageRef, scale: scale, orientation: imageOrientation)
        UIGraphicsEndImageContext()
        return darkImage
    }
    
    public func resize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    public func getColors(completionHandler: (UIImageColors) -> Void) {
        let ratio = size.width/size.height
        let r_width: CGFloat = 250
        
        getColors(CGSizeMake(r_width, r_width/ratio), completionHandler: completionHandler)
    }
    
    public func getColors(scaleDownSize: CGSize, completionHandler: (UIImageColors) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            var result = UIImageColors()
            
            let cgImage = self.resize(scaleDownSize).CGImage
            let width = CGImageGetWidth(cgImage)
            let height = CGImageGetHeight(cgImage)
            
            let bytesPerPixel: Int = 4
            let bytesPerRow: Int = width * bytesPerPixel
            let bitsPerComponent: Int = 8
            let randomColorsThreshold = Int(CGFloat(height)*0.01)
            let sortedColorComparator: NSComparator = { (main, other) -> NSComparisonResult in
                let m = main as! PCCountedColor, o = other as! PCCountedColor
                if m.count < o.count {
                    return NSComparisonResult.OrderedDescending
                } else if m.count == o.count {
                    return NSComparisonResult.OrderedSame
                } else {
                    return NSComparisonResult.OrderedAscending
                }
            }
            let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let raw = malloc(bytesPerRow * height)
            let bitmapInfo = CGImageAlphaInfo.PremultipliedFirst.rawValue
            let ctx = CGBitmapContextCreate(raw, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo)
            CGContextDrawImage(ctx, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), cgImage)
            let data = UnsafePointer<UInt8>(CGBitmapContextGetData(ctx))
            
            let leftEdgeColors = NSCountedSet(capacity: height)
            let imageColors = NSCountedSet(capacity: width * height)
            
            for x in 0..<width {
                for y in 0..<height {
                    let pixel = ((width * y) + x) * bytesPerPixel
                    let color = UIColor(
                        red: CGFloat(data[pixel+1])/255,
                        green: CGFloat(data[pixel+2])/255,
                        blue: CGFloat(data[pixel+3])/255,
                        alpha: 1
                    )
                    
                    // A lot of albums have white or black edges from crops, so ignore the first few pixels
                    if 5 <= x && x <= 10 {
                        leftEdgeColors.addObject(color)
                    }
                    
                    imageColors.addObject(color)
                }
            }
            
            // Get background color
            var enumerator = leftEdgeColors.objectEnumerator()
            var sortedColors = NSMutableArray(capacity: leftEdgeColors.count)
            while let kolor = enumerator.nextObject() as? UIColor {
                let colorCount = leftEdgeColors.countForObject(kolor)
                if randomColorsThreshold < colorCount  {
                    sortedColors.addObject(PCCountedColor(color: kolor, count: colorCount))
                }
            }
            sortedColors.sortUsingComparator(sortedColorComparator)
            
            var proposedEdgeColor: PCCountedColor
            if 0 < sortedColors.count {
                proposedEdgeColor = sortedColors.objectAtIndex(0) as! PCCountedColor
            } else {
                proposedEdgeColor = PCCountedColor(color: blackColor, count: 1)
            }
            
            if proposedEdgeColor.color.isBlackOrWhite && 0 < sortedColors.count {
                for i in 1..<sortedColors.count {
                    let nextProposedEdgeColor = sortedColors.objectAtIndex(i) as! PCCountedColor
                    if (CGFloat(nextProposedEdgeColor.count)/CGFloat(proposedEdgeColor.count)) > 0.3 {
                        if !nextProposedEdgeColor.color.isBlackOrWhite {
                            proposedEdgeColor = nextProposedEdgeColor
                            break
                        }
                    } else {
                        break
                    }
                }
            }
            result.backgroundColor = proposedEdgeColor.color
            
            // Get foreground colors
            enumerator = imageColors.objectEnumerator()
            sortedColors.removeAllObjects()
            sortedColors = NSMutableArray(capacity: imageColors.count)
            let findDarkTextColor = !result.backgroundColor.isDarkColor
            
            while var kolor = enumerator.nextObject() as? UIColor {
                kolor = kolor.colorWithMinimumSaturation(0.15)
                if kolor.isDarkColor == findDarkTextColor {
                    let colorCount = imageColors.countForObject(kolor)
                    sortedColors.addObject(PCCountedColor(color: kolor, count: colorCount))
                }
            }
            sortedColors.sortUsingComparator(sortedColorComparator)
            
            for curContainer in sortedColors {
                let kolor = (curContainer as! PCCountedColor).color
                
                if result.primaryColor == nil {
                    if kolor.isContrastingColor(result.backgroundColor) {
                        result.primaryColor = kolor
                    }
                } else if result.secondaryColor == nil {
                    if !result.primaryColor.isDistinct(kolor) || !kolor.isContrastingColor(result.backgroundColor) {
                        continue
                    }
                    
                    result.secondaryColor = kolor
                } else if result.detailColor == nil {
                    if !result.secondaryColor.isDistinct(kolor) || !result.primaryColor.isDistinct(kolor) || !kolor.isContrastingColor(result.backgroundColor) {
                        continue
                    }
                    
                    result.detailColor = kolor
                    break
                }
            }
            
            let isDarkBackgound = result.backgroundColor.isDarkColor
            
            if result.primaryColor == nil {
                result.primaryColor = isDarkBackgound ? whiteColor:blackColor
            }
            
            if result.secondaryColor == nil {
                result.secondaryColor = isDarkBackgound ? whiteColor:blackColor
            }
            
            if result.detailColor == nil {
                result.detailColor = isDarkBackgound ? whiteColor:blackColor
            }
            
            // Release the allocated memory
            free(raw)
            
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(result)
            }
        }
    }
}
