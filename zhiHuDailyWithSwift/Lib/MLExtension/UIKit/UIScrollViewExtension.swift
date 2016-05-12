//
//  UIScrollViewExtension.swift
//  MLExtension
//
//  Created by LCL on 15/12/4.
//  Copyright © 2015年 lclpro. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop(){
        self.scrollToTopAnimated(true)
    }
    
    func scrollToBottom(){
        self.scrollToBottomAnimated(true)
    }
    
    func scrollToLeft(){
        self.scrollToLeftAnimated(true)
    }
    
    func scrollToRight(){
        self.scrollToRightAnimated(true)
    }
    
    func scrollToTopAnimated(animated:Bool){
        var off = self.contentOffset
        off.y = 0 - self.contentInset.top
        self.setContentOffset(off, animated: animated)
    }
    
    func scrollToBottomAnimated(animated:Bool){
        var off = self.contentOffset
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        self.setContentOffset(off, animated: animated)
    }
    
    func scrollToLeftAnimated(animated:Bool){
        var off = self.contentOffset
        off.x = 0 - self.contentInset.left
        self.setContentOffset(off, animated: animated)
    }
    
    func scrollToRightAnimated(animated:Bool){
        var off = self.contentOffset
        off.x = self.contentSize.width - self.size.width + self.contentInset.right
        self.setContentOffset(off, animated: animated)
    }
}
