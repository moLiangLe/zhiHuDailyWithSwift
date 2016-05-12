//
//  File.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/11.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Create a snapshot image of the complete view hierarchy.
     */
    func snapshotImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    /**
     Create a snapshot image of the complete view hierarchy.
     @discussion It's faster than "snapshotImage", but may cause screen updates.
     See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
     */
    func snapshotImageAfterScreenUpdates(afterUpdates:Bool) -> UIImage{
        guard self.respondsToSelector(#selector(UIView.drawViewHierarchyInRect(_:afterScreenUpdates:))) else{
            return self.snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: afterUpdates)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap;
    }
    
    func snapshotPDF() -> NSData{
        return NSData()
    }
    
    //    - (NSData *)snapshotPDF {
    //    CGRect bounds = self.bounds;
    //    NSMutableData* data = [NSMutableData data];
    //    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    //    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    //    CGDataConsumerRelease(consumer);
    //    if (!context) return nil;
    //    CGPDFContextBeginPage(context, NULL);
    //    CGContextTranslateCTM(context, 0, bounds.size.height);
    //    CGContextScaleCTM(context, 1.0, -1.0);
    //    [self.layer renderInContext:context];
    //    CGPDFContextEndPage(context);
    //    CGPDFContextClose(context);
    //    CGContextRelease(context);
    //    return data;
    //    }
    
    /**
     Shortcut to set the view.layer's shadow
     
     @param color  Shadow Color
     @param offset Shadow offset
     @param radius Shadow radius
     */
    func setLayerShadow(color:UIColor, offset:CGSize, radius:CGFloat) {
        self.layer.shadowColor = color.CGColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    /**
     Remove all subviews.
     
     @warning Never call this method inside your view's drawRect: method.
     */
    func removeAllSubviews(){
        while self.subviews.count > 0{
            if let view = self.subviews.last {
                view.removeFromSuperview();
            }
        }
    }
    //
    //    func viewController() -> UIViewController {
    //        for (var view = self; view; view = view.superview){
    //            let nextResponde = view.nextResponder()
    //            if let nextResponde = nextResponde.isKindOfClass(UIViewController.self){
    //                return nextResponde;
    //            }
    //        }
    //    }
    
    //    func visibleAlpha() -> CGFloat{
    //        if self.isKindOfClass(UIWindow.self) {
    //            return self.hidden ? 0 : self.alpha
    //        }
    //        guard let _ = self.window else{
    //            return 0
    //        }
    //        var alpha:CGFloat = 1
    //        var view = self
    //        while(view != nil){
    //            if view.hidden {
    //                alpha = 0
    //                break
    //            }
    //            alpha
    //        }
    //    }
    
    //    func convertPoint(point:CGPoint, toViewOrWindow view:UIView?) -> CGPoint {
    //        guard let view = view else{
    //            if self.isKindOfClass(UIWindow.self) {
    //                return self.convertPoint(point, toView: nil)
    //            } else {
    //                return self.convertPoint(point, toView: nil)
    //            }
    //        }
    //
    //        let from = self.isKindOfClass(UIWindow.self) ? self : self.window!
    //        let to = view.isKindOfClass(UIWindow.self) ? view : view.window!
    //        if (!from || !to) || (from == to) {
    //
    //        }
    //    }
    
    ///< Shortcut for frame.origin.x.
    var left:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var top:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var right:CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var bottom:CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var heiht:CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var centerX:CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY:CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    var origin:CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var size:CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
}
