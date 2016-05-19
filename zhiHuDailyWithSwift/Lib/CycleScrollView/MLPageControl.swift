//
//  MLPageControl.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/19.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

protocol MLPageControlDelegate {
    func pageControl(pageControl: MLPageControl, didSelectItemAtIndex index:Int)
}

class MLPageControl: UIControl {
    
    let kDefaultDotSize = CGSize(width: 8, height: 8)
    
    var dotColor: UIColor?
    var delegate: MLPageControlDelegate?
    var hidesForSinglePage = false
    var shouldResizeFromCenter = true
    var dotView: UIView?
    var dots:NSMutableArray = []
    
    private var _dotImage: UIImage?
    var dotImage: UIImage? {
        get{ return _dotImage }
        set{
            _dotImage = newValue
            resetDotViews()
            dotViewClass = nil
        }
    }
    
    private var _currentDotImage: UIImage?
    var currentDotImage: UIImage? {
        get{ return _currentDotImage }
        set{
            _currentDotImage = newValue
            resetDotViews()
            dotViewClass = nil
        }
    }
    
    private var _dotViewClass : MLDotViewProtocol?
    var dotViewClass: MLDotViewProtocol? {
        get{ return _dotViewClass }
        set{
            _dotViewClass = newValue
            self.dotSize = CGSizeZero;
            resetDotViews()
        }
    }
    
    private var _currentPage = 0
    var currentPage: Int {
        get { return _currentPage }
        set {
            if self.numberOfPages == 0 || currentPage == _currentPage {
                _currentPage = currentPage
                return
            }
            changeActivity(false, atIndex: _currentPage)
            _currentPage = newValue
            changeActivity(true, atIndex: _currentPage)
        }
    }
    
    private var _dotSize: CGSize = CGSizeZero
    var dotSize: CGSize {
        get {
            if let dotImage = self.dotImage {
                if CGSizeEqualToSize(_dotSize, CGSizeZero) {
                    return dotImage.size
                }
            } else {
                if CGSizeEqualToSize(_dotSize, CGSizeZero) {
                    return kDefaultDotSize
                }
            }
            return _dotSize
        }
        set {
            _dotSize = newValue
        }
    }
    
    private var _spacingBetweenDots: CGFloat = 8
    var spacingBetweenDots: CGFloat {
        get { return _spacingBetweenDots }
        set {
            _spacingBetweenDots = newValue
            resetDotViews()
        }
    }
    
    private var _numberOfPages = 0
    var numberOfPages: Int {
        get { return _numberOfPages }
        set
        {
            _numberOfPages = newValue
            resetDotViews()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        
        if touch?.view != self {
            let index = self.dots.indexOfObject((touch?.view)!)
            if let delegate = self.delegate {
                delegate.pageControl(self, didSelectItemAtIndex:index)
            }
        }
    }
    
    override func sizeToFit() {
        updateFrame(true)
    }
    
    func sizeForNumberOfPages(pageCount: Int) -> CGSize {
        let width = (self.dotSize.width + self.spacingBetweenDots) * CGFloat(pageCount) - self.spacingBetweenDots
        let height = self.dotSize.height
        return CGSize(width: width, height: height)
    }
    
    func updateDots() {
        guard self.numberOfPages == 0 else{
            return
        }
        
        for i in 0  ..< self.numberOfPages {
            var dot: UIView
            if i < self.dots.count {
                dot = self.dots.objectAtIndex(i) as! UIView
            } else {
                dot = self.generateDotView();
            }
            updateDotFrame(dot, atIndex: i)
        }
        
        changeActivity(true, atIndex: self.currentPage)
        
        hideForSinglePage()
    }
    
    private func updateFrame(overrideExistingFrame: Bool) {
        let center = self.center;
        let requiredSize = sizeForNumberOfPages(self.numberOfPages)
        
        // We apply requiredSize only if authorize to and necessary
        if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
            self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
            if (self.shouldResizeFromCenter) {
                self.center = center;
            }
        }
        
        resetDotViews()
    }
    
    private func updateDotFrame(dot: UIView, atIndex index: Int) {
        let x = (self.dotSize.width + self.spacingBetweenDots) * CGFloat(index) + ( (CGRectGetWidth(self.frame) - self.sizeForNumberOfPages(self.numberOfPages).width) / 2)
        let y = (CGRectGetHeight(self.frame) - self.dotSize.height) / CGFloat(2)
        dot.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
    }
    
    // MARK: Utils
    private func generateDotView() -> UIView {
        var dotView: UIView
        if let dotViewClass = self.dotViewClass {
            dotView = dotViewClass.getInstall(self.bounds, color: self.dotColor!)
        } else {
            dotView = UIImageView(image: self.dotImage)
            dotView.frame = self.bounds
        }
        
        self.addSubview(dotView)
        self.dots.addObject(dotView)
        dotView.userInteractionEnabled = true
        return dotView
    }
    
    private func changeActivity(active: Bool, atIndex index: Int) {
        if dotViewClass != nil {
            let dot = self.dots.objectAtIndex(index) as! MLDotViewProtocol
            dot.changeActivityState(active)
        } else {
            let dotView = self.dots.objectAtIndex(index) as! UIImageView
            dotView.image = (active) ? self.currentDotImage : self.dotImage;
        }
    }
    
    private func resetDotViews() {
        for dotView in dots {
            (dotView as! UIView).removeAllSubviews()
        }
        
        dots.removeAllObjects()
        updateDots()
    }
    
    private func hideForSinglePage() {
        if self.dots.count == 1 && self.hidesForSinglePage {
            self.hidden = true
        } else {
            self.hidden = false
        }
    }

}
