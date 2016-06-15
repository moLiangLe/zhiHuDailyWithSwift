//
//  StringExtension.swift
//  V2EXWithSwift
//
//  Created by LCL on 16/6/7.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

extension String {
    public var Lenght:Int {
        get{
            return self.characters.count;
        }
    }
    
    subscript (r:Range<Int>) -> String {
        get{
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.endIndex.advancedBy(r.endIndex)
            return self[Range(startIndex..<endIndex)]
        }
    }
}