//
//  CALayerExection.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/25.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension CALayer {
    
    // MARK: - properties
    
    var left:CGFloat {
        get{ return self.frame.origin.x }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var top:CGFloat {
        get{ return self.frame.origin.y }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var right:CGFloat {
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var bottom:CGFloat {
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var width:CGFloat {
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var heiht: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.frame.origin.x + self.frame.size.width * 0.5, y: self.frame.origin.y + self.frame.size.height * 0.5)
        }
        set {
            var frame = self.frame
            frame.origin.x = center.x - frame.size.width * 0.5
            frame.origin.y = center.y - frame.size.height * 0.5
            self.frame = frame
        }
    }
    
    var centerX:CGFloat {
        get{
            return self.frame.origin.x + self.frame.size.width * 0.5
        }
        set{
            var frame = self.frame
            frame.origin.x = centerX - frame.size.width * 0.5
            self.frame = frame
        }
    }
    
    var centerY:CGFloat {
        get{
            return self.frame.origin.y + self.frame.size.height * 0.5
        }
        set{
            var frame = self.frame;
            frame.origin.y = centerY - frame.size.height * 0.5;
            self.frame = frame
        }
    }
    
    var origin:CGPoint {
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var size:CGSize {
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var frameSize: CGSize{
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame;
            frame.size = size;
            self.frame = frame
        }
    }
    
    var transformRotation: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.rotation") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.rotation")
        }
    }
    
    var transformRotationX: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.rotation.x") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.rotation.x")
        }
    }
    
    var transformRotationY: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.rotation.y") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.rotation.y")
        }
    }
    
    var transformRotationZ: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.rotation.z") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.rotation.z")
        }
    }
    
    var transformScaleX: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.scale.x") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.scale.x")
        }
    }
    
    var transformScaleY: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.scale.y") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.scale.y")
        }
    }
    
    var transformScaleZ: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.scale.z") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.scale.z")
        }
    }
    
    var transformScale: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.scale") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.scale")
        }
    }
    
    var transformTranslationX: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.translation.x") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.translation.x")
        }
    }
    
    var transformTranslationY: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.translation.y") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.translation.y")
        }
    }
    
    var transformTranslationZ: CGFloat {
        get {
            let v = self.valueForKeyPath("transform.translation.z") as! CGFloat
            return v
        }
        set {
            self.setValue(newValue, forKey: "transform.translation.z")
        }
    }
    
    var transformDepth: CGFloat {
        get {
            return self.transform.m34
        }
        set {
            var d = self.transform;
            d.m34 = newValue;
            self.transform = d;
        }
    }
    
    // MARK: - functions

    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.renderInContext(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func snapshotPDF() -> NSData? {
        var bounds = self.bounds
        let data = NSMutableData()
        let consumer = CGDataConsumerCreateWithCFData(data)
        guard let context = CGPDFContextCreate(consumer, &bounds, nil) else {
            return nil;
        }
        CGPDFContextBeginPage(context, nil)
        CGContextTranslateCTM(context, 0, bounds.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        self.renderInContext(context)
        CGPDFContextEndPage(context)
        CGPDFContextClose(context)
        return data
    }
    
    func setLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        self.shadowColor = color.CGColor
        self.shadowOffset = offset
        self.shadowRadius = radius
        self.shadowOpacity = 1
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    func removeAllSublayers() {
        guard let sublayers = self.sublayers else {
            return
        }
        
        while sublayers.count > 0 {
            sublayers.last?.removeFromSuperlayer()
        }
    }
}
