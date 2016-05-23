//
//  UIColorExtension.swift
//  MLExtension
//
//  Created by LCL on 16/4/25.
//  Copyright © 2016年 lclpro. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
