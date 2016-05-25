//
//  UIGestureRecognizerExection.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/25.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    private struct AssociatedKeys {
        static var block_key = "ml_block_key"
    }
    
    typealias ActionBlock = (sender: AnyObject?) -> ()
    
    class MLUIGestureRecognizerBlockTarget {
        let actionBlock: ActionBlock?
        
        init(block: ActionBlock?){
            self.actionBlock = block
        }
        
        @objc func invoke(sender: AnyObject?) {
            if let block = actionBlock {
                block(sender: sender)
            }
        }
    }
    
    convenience init(block: ActionBlock) {
        self.init()
    }
    
    func addActionBlock(block: ActionBlock) {
        let target = MLUIGestureRecognizerBlockTarget(block: block)
        self.addTarget(target, action: #selector(target.invoke(_:)))
        let targets = self.mlAllUIGestureRecognizerBlockTargets()
        targets.addObject(target)
    }
    
    func removeAllActionBlocks() {
        let targets = self.mlAllUIGestureRecognizerBlockTargets()
        for target in targets {
            self.removeTarget(target, action: #selector(target.invoke(_:)))
        }
        targets.removeAllObjects()
    }
    
    func mlAllUIGestureRecognizerBlockTargets() -> NSMutableArray {
        var targets = objc_getAssociatedObject(self, &AssociatedKeys.block_key) as? NSMutableArray
        if targets == nil  {
            targets = NSMutableArray()
            objc_setAssociatedObject(self, &AssociatedKeys.block_key, targets, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return targets!
    }
}
