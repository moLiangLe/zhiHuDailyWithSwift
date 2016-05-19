//
//  MLDotView.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/19.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

public protocol MLDotViewProtocol {
    func changeActivityState(active:Bool)
    func getInstall(frame: CGRect, color: UIColor) -> UIView
}

public class MLDotView: UIView, MLDotViewProtocol{
    
    private var dotColor: UIColor = UIColor.whiteColor()
    
    public func changeActivityState(active:Bool) {
        if active {
            self.backgroundColor = UIColor.whiteColor();
        } else {
            self.backgroundColor = UIColor.clearColor();
        }
    }
    
    func congfigDotView(color: UIColor = UIColor.whiteColor()) {
        self.dotColor = color
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 2
    }
    
    public func getInstall(frame: CGRect, color: UIColor) -> UIView {
        let install = MLDotView(frame: frame)
        install.congfigDotView()
        return install
    }
}

public class MLAnimatedDotView: UIView, MLDotViewProtocol {
    
    let kAnimateDuration: NSTimeInterval = 1
    
    private var dotColor: UIColor = UIColor.whiteColor()
    
    public func changeActivityState(active: Bool) {
        if active {
            self.animateToActiveState()
        } else {
            self.animateToDeactiveState()
        }
    }
    
    public func congfigDotView(color: UIColor = UIColor.whiteColor()) {
        self.dotColor = color
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2
        self.layer.borderColor = self.dotColor.CGColor
        self.layer.borderWidth = 2
    }
    
    private func animateToActiveState() {
        UIView.animateWithDuration(kAnimateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .CurveLinear, animations: {
            self.backgroundColor = self.dotColor
            self.transform = CGAffineTransformMakeScale(1.4, 1.4);
            }, completion: nil)
    }
    
    private func animateToDeactiveState() {
        UIView.animateWithDuration(kAnimateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .CurveLinear, animations: {
            self.backgroundColor = UIColor.clearColor()
            self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    public func getInstall(frame: CGRect, color: UIColor) -> UIView {
        let install = MLDotView(frame: frame)
        install.congfigDotView(color)
        return install
    }
}


