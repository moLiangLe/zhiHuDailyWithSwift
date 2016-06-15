//
//  NSObjectExtension.swift
//  V2EXWithSwift
//
//  Created by LCL on 16/6/7.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

extension NSObject {
    /**
     当前的类名字符串
     
     - returns: 当前类名的字符串
     */
    public class func Identifier() -> String {
        return "\(self)";
    }
}