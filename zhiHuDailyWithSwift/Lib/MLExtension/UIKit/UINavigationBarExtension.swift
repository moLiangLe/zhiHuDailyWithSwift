//
//  UINavigationBarExtension.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/23.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationBar {
    private struct AssociatedKeys {
        static var overlay_Key = "ml_overlay_Key"
    }
    
    var overlay: UIView? {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.overlay_Key) as? UIView
        }
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.overlay_Key, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
}
