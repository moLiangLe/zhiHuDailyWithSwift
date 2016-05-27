//
//  NSAttributedStringExtension.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/27.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    #if os(iOS)
    
    public func bold() -> NSAttributedString {
        let range = (self.string as NSString).rangeOfString(self.string)
        return self.bold(range)
    }
    
    public func bold(range:NSRange) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(UIFont.systemFontSize())], range: range)
        return copy
    }
    
    #endif
    
    /// Adds underline attribute to NSAttributedString and returns it
    public func underline() -> NSAttributedString {
        let range = (self.string as NSString).rangeOfString(self.string)
        return underline(range)
    }
    
    public func underline(range:NSRange) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue], range: range)
        return copy
    }
    
    #if os(iOS)
    
    /// Adds italic attribute to NSAttributedString and returns it
    public func italic() -> NSAttributedString {
        let range = (self.string as NSString).rangeOfString(self.string)
        return italic(range)
    }
    
    public func italic(range:NSRange) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttributes([NSFontAttributeName: UIFont.italicSystemFontOfSize(UIFont.systemFontSize())], range: range)
        return copy
    }
    
    #endif
    
    /// Adds color attribute to NSAttributedString and returns it
    public func textColor(color: UIColor) -> NSAttributedString {
        let range = (self.string as NSString).rangeOfString(self.string)
        return textColor(color, range: range)
    }
    
    public func textColor(color: UIColor, range:NSRange) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        copy.addAttributes([NSForegroundColorAttributeName: color], range: range)
        return copy
    }
}

public func += (inout left: NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.appendAttributedString(right)
    left = ns
}

