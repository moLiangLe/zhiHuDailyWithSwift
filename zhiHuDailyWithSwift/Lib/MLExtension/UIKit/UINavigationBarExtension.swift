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
        static var overlayKey = "ml_overlayKey"
    }
    
    var overlay: UIView? {
        get{
           return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
        }
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
}
