//
//  CGFloatExection.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/27.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension CGFloat {
    /// Return the central value of CGFloat.
    public var center: CGFloat { return (self / 2) }

    public func toRadians() -> CGFloat {
        return (CGFloat (M_PI) * self) / 180.0
    }
    
    public func degreesToRadians() -> CGFloat {
        return toRadians()
    }
    
    public mutating func toRadiansInPlace() {
        self = (CGFloat (M_PI) * self) / 180.0
    }
    
    public func degreesToRadians (angle: CGFloat) -> CGFloat {
        return (CGFloat (M_PI) * angle) / 180.0
    }
    
    static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}