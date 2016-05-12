//
//  UIImageExtension.swift
//  Addition
//
//  Created by kugou on 16/2/23.
//  Copyright © 2016年 kugou. All rights reserved.
//

import UIKit

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
    func cutImageWithRadius(radius :CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let gc = UIGraphicsGetCurrentContext()
        let x1 : (CGFloat) = 0;
        let y1 : (CGFloat) = 0;
        let x2 = x1 + self.size.width;
        let y2 = y1;
        let x3 = x2;
        let y3 = y1 + self.size.height;
        let x4 = x1;
        let y4 = y3;
        let radius = radius * 2;
        
        CGContextMoveToPoint(gc, x1, y1 + radius);
        CGContextAddArcToPoint(gc, x1, y1, x1 + radius, y1, radius);
        CGContextAddArcToPoint(gc, x2, y2, x2, y2 + radius, radius);
        CGContextAddArcToPoint(gc, x3, y3, x3 - radius, y3, radius);
        CGContextAddArcToPoint(gc, x4, y4, x4, y4 - radius, radius);
        
        CGContextClosePath(gc);
        CGContextClip(gc);
        
        CGContextTranslateCTM(gc, 0, self.size.height);
        CGContextScaleCTM(gc, 1, -1);
        CGContextDrawImage(gc, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
        
        let newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newimage;

    }
    

    
//    class func tintedImageWithColor(color :UIColor , alpha :CGFloat) {
//        let rect = CGRect(x: 0, y: 0, width: self.width, height: size.height)
//    }
    
//    - (UIImage *)tintedImageWithColor:(UIColor*)color alpha:(CGFloat)alpha
//    {
//    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
//    
//    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    [self drawInRect:imageRect];
//    
//    CGContextSetFillColorWithColor(ctx, [color CGColor]);
//    CGContextSetAlpha(ctx, alpha);
//    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
//    CGContextFillRect(ctx, imageRect);
//    
//    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
//    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
//    scale:self.scale
//    orientation:self.imageOrientation];
//    CGImageRelease(imageRef);
//    
//    UIGraphicsEndImageContext();
//    
//    return darkImage;
//    }
}
