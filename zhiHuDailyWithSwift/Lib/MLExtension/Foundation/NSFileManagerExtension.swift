//
//  NSFileManagerExtension.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/25.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

extension NSFileManager {
    
    func pathForDocumentsDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        return path;
    }
    
    func pathForCachesDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        return path;
    }
    
    func pathForLibraryDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        return path;
    }
    
    func pathForMainBundleDirectory() -> String {
        let path = NSBundle.mainBundle().resourcePath!
        return path
    }
    
    func pathForTemporaryDirectory() -> String {
        let path = NSTemporaryDirectory()
        return path;
    }
    
    func pathForApplicationSupportDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.ApplicationDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        return path;
    }
}