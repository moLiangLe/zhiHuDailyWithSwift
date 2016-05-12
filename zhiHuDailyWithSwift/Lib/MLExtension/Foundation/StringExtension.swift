//
//  StringExtension.swift
//  MLExtension
//
//  Created by LCL on 16/2/28.
//  Copyright © 2016年 lclpro. All rights reserved.
//

import Foundation

extension String {
    subscript (r:Range<Int>) -> String {
        get{
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.endIndex.advancedBy(r.endIndex)
            return self[Range(startIndex..<endIndex)]
        }
    }
    
}