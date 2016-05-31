//
//  NSUserDefaultsExtension.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/31.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

public extension NSUserDefaults {
    public subscript(key: String) -> AnyObject? {
        get {
            return objectForKey(key)
        }
        set {
            setObject(newValue, forKey: key)
        }
    }
}