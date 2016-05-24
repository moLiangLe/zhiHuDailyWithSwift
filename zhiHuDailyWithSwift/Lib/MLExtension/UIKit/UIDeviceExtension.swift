//
//  UIDeviceExtension.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/24.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension UIDevice {
    class func systemVersion() -> Double {
        return (UIDevice.currentDevice().systemVersion as NSString).doubleValue
    }
    
    class func isPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .Pad
    }
}
