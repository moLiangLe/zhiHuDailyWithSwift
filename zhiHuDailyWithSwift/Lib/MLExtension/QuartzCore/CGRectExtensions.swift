//
//  CGRectExtensions.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/27.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension CGRect {
    
    /// X value of CGRect's origin
    public var x: CGFloat {
        get {
            return self.origin.x
        } set(value) {
            self.origin.x = value
        }
    }
    
    /// Y value of CGRect's origin
    public var y: CGFloat {
        get {
            return self.origin.y
        } set(value) {
            self.origin.y = value
        }
    }
    
    /// Width of CGRect's size
    public var w: CGFloat {
        get {
            return self.size.width
        } set(value) {
            self.size.width = value
        }
    }
    
    /// Height of CGRect's size
    public var h: CGFloat {
        get {
            return self.size.height
        } set(value) {
            self.size.height = value
        }
    }
}
