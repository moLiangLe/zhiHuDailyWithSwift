//
//  GCDExtension.swift
//  V2EXWithSwift
//
//  Created by LCL on 16/6/7.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

func dispatch_sync_safely_main_queue(block: ()->()) {
    if NSThread.isMainThread() {
        block()
    } else {
        dispatch_sync(dispatch_get_main_queue()) {
            block()
        }
    }
}