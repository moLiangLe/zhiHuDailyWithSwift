//
//  MLCycleScrollView.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/11.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import Kingfisher

enum MLCycleScrollViewPageContolAliment {
    case Right
    case Center
}

enum MLCycleScrollViewPageContolStyle {
    case Classic        // 系统自带经典样式;
    case Animated       // 动画效果pagecontrol
    case None           // 不显示pagecontrol
}

protocol MLCycleScrollViewDelegate {
    /** 点击图片回调 */

    func cycleScrollView(cycleScrollView: MLCycleScrollView, didSelectItemAtIndex index:NSInteger)
    
    /** 图片滚动回调 */
    func cycleScrollView(cycleScrollView: MLCycleScrollView, didScrollToIndex index:NSInteger)
}

class MLCycleScrollView: UIView {
    
    var delegate: MLCycleScrollViewDelegate?
    var pageControlAliment: MLCycleScrollViewPageContolAliment = .Center
    var pageControlDotSize = CGSizeMake(10, 10)
    var dotColor: UIColor = UIColor.whiteColor()
    var titleLabelTextColor = UIColor.whiteColor()
    var titleLabelTextFont = UIFont.systemFontOfSize(12)
    var titleLabelBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    var titleLabelHeight: CGFloat = 30
    var titleLabelAlpha: CGFloat = 0
    var localizationImagesGroup: [UIImage] = []
    var imageURLStringsGroup: [String] = []
    var titlesGroup: [String] = []
    
    var backgroundImageView: UIImageView?
    var placeholderImage: UIImage? {
        didSet{
            if self.backgroundImageView == nil {
                self.backgroundImageView = UIImageView()
                self.backgroundImageView?.contentMode = .ScaleAspectFit
                self.insertSubview(self.backgroundImageView!, belowSubview: self.mainView)
            }
            self.backgroundImageView?.image = placeholderImage
        }
    }
    
    var pageControlStyle: MLCycleScrollViewPageContolStyle = .Classic {
        didSet {
            setupPageControl()
        }
    }
    
    var autoScrollTimeInterval: NSTimeInterval = 2.0 {
        didSet{
            let autoScroll = self.autoScroll
            self.autoScroll = autoScroll
        }
    }
    
    var showPageControl: Bool = true {
        didSet {
            if let pageControl = self.pageControl {
                pageControl.hidden = !showPageControl
            }
        }
    }
    
    var autoScroll: Bool = true {
        didSet {
            invalidateTimer()
            if autoScroll {
                setupTimer()
            }
        }
    }
    
    var scrollDirection: UICollectionViewScrollDirection {
        get { return flowLayout.scrollDirection }
        set { flowLayout.scrollDirection = scrollDirection }
    }
    
    var imagePathsGroup: [String] = [] {
        didSet {
            totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
            if imagePathsGroup.count != 1 {
                mainView.scrollEnabled = true
                let autoScroll = self.autoScroll
                self.autoScroll = autoScroll
            } else {
                invalidateTimer()
                mainView.scrollEnabled = false;
            }
            setupPageControl()
            mainView.reloadData()
            
            if imagePathsGroup.count > 0 {
                backgroundImageView!.removeFromSuperview()
            } else {
                if self.backgroundImageView != nil && !(self.backgroundImageView!.superview != nil) {
                    self.insertSubview(self.backgroundImageView! , belowSubview: self.mainView)
                }
            }
        }
    }
    
    var infiniteLoop: Bool = true {
        didSet {
            if self.imagePathsGroup.count > 0 {
                let array = self.imagePathsGroup
                self.imagePathsGroup = array
            }
        }
    }
    
    lazy private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy private var mainView: UICollectionView = UICollectionView()
    private var imagesGroup: [UIImage] = [] {
        didSet {
            totalItemsCount = self.infiniteLoop ? self.imagesGroup.count * 100 : self.imagesGroup.count
            if imagesGroup.count != 1 {
                self.mainView.scrollEnabled = true
                setupTimer()
            } else {
                self.mainView.scrollEnabled = false;
            }
            
            self.setupPageControl()
            self.mainView.reloadData()
        }
    }
    
    private var timer: NSTimer?
    private var totalItemsCount: Int = 0
    private var pageControl: UIPageControl?
    
    let CycleScrollidentifier = "CycleScrollidentifier"
    
    func configCycleScrollView() {
        flowLayout.itemSize = self.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        
        mainView.collectionViewLayout = flowLayout
        mainView.frame = self.bounds
        mainView.backgroundColor = UIColor.clearColor();
        mainView.pagingEnabled = true;
        mainView.showsHorizontalScrollIndicator = false;
        mainView.showsVerticalScrollIndicator = false;
        mainView.registerClass(MLCollectionViewCell.self, forCellWithReuseIdentifier: CycleScrollidentifier)
        mainView.delegate = self
        mainView.dataSource = self
        self.addSubview(mainView)
        
        backgroundColor = UIColor.lightGrayColor()
    }
    
    deinit {
        mainView.delegate = nil
        mainView.dataSource = nil
    }
    
    private func setupTimer() {
        let timer =  NSTimer.scheduledTimerWithTimeInterval(self.autoScrollTimeInterval, target: self , selector:#selector(automaticScroll), userInfo: nil, repeats: true)
        self.timer = timer
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)

    }
    
    private func invalidateTimer() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    private func setupPageControl() {
        if let pageControl = self.pageControl {
            pageControl.removeFromSuperview()
        }
        
        let pageControl = UIPageControl()
        pageControl.numberOfPages = self.imagesGroup.count;
        pageControl.currentPageIndicatorTintColor = self.dotColor;
        self.addSubview(pageControl)
        self.pageControl = pageControl;
    }
    
    @objc private func automaticScroll() {
        guard totalItemsCount > 0 else {
            return
        }
        let currentIndex = self.currentIndex()
        var targetIndex = currentIndex + 1
        if targetIndex >= totalItemsCount {
            if infiniteLoop {
                targetIndex = Int(Double(totalItemsCount) * 0.5);
                mainView.scrollToItemAtIndexPath(NSIndexPath(forItem: targetIndex, inSection: 0), atScrollPosition: .None, animated: true)
            }
            return
        }
        mainView.scrollToItemAtIndexPath(NSIndexPath(forItem: targetIndex, inSection: 0), atScrollPosition: .None, animated: true)
    }
    
    private func currentIndex() -> Int {
        guard mainView.width > 0 || mainView.heiht > 0 else {
            return 0
        }
        var index = 0
        if flowLayout.scrollDirection == .Horizontal {
            index = Int((mainView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width);
        } else {
            index = Int((mainView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height);
        }
        return index
    }
    
    func clearCache() {
        KingfisherManager.sharedManager.cache.clearDiskCache()
    }
    
    class func clearImagesCache() {
        KingfisherManager.sharedManager.cache.clearDiskCache()
    }
    
    
    private func loadImageWithImageURLsGroup(imageURLsGroup: [String]) {
        for i in 0...imageURLsGroup.count {
            loadImageAtIndex(i)
        }
    }
    
    private func loadImageAtIndex(index: Int) {
        
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flowLayout.itemSize = self.bounds.size
        mainView.frame = self.bounds
        
        if mainView.contentOffset.x == 0 && totalItemsCount > 0 {
            var targetIndex = 0;
            if self.infiniteLoop {
                targetIndex = Int(Double(totalItemsCount) * 0.5)
            }else{
                targetIndex = 0;
            }
            mainView.scrollToItemAtIndexPath(NSIndexPath(forItem: targetIndex, inSection: 0), atScrollPosition: .None, animated: true)
        }
        
        if let backgroundImageView = self.backgroundImageView {
            backgroundImageView.frame = self.bounds
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        if let _ = newSuperview {
            invalidateTimer()
        }
    }
}

// MARK: ViewLogicLayer
extension MLCycleScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CycleScrollidentifier, forIndexPath: indexPath) as! MLCollectionViewCell
        
        let itemIndex = indexPath.item % self.imagePathsGroup.count
        
        let imagePath = imagePathsGroup[itemIndex]

        if imagePath.containsString("http") {
            cell.imageView.kf_setImageWithURL(NSURL(string: imagePath)!, placeholderImage:self.placeholderImage)
        }
        if titlesGroup.count > 0 && itemIndex < titlesGroup.count {
            cell.title = titlesGroup[itemIndex];
        }
        
        if cell.hasConfigured {
            cell.congfigCell(titleLabelTextColor, titleLabelTextFont: titleLabelTextFont, titleLabelBackgroundColor: titleLabelBackgroundColor, titleLabelHeight: titleLabelHeight)
            cell.imageView.contentMode = .ScaleToFill
            cell.clipsToBounds = true;
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            delegate.cycleScrollView(self, didSelectItemAtIndex:0)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard self.imagePathsGroup.count > 0 else {
            return
        }
        let itemIndex = currentIndex()
        let indexOnPageControl = itemIndex % self.imagePathsGroup.count;

        if let pageControl = pageControl {
            pageControl.currentPage = indexOnPageControl
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if self.autoScroll {
            invalidateTimer()
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.autoScroll {
            setupTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(mainView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        guard self.imagePathsGroup.count > 0 else {
            return
        }
        let itemIndex = currentIndex()
        let indexOnPageControl = itemIndex % self.imagePathsGroup.count;
        if let delegate = delegate {
            delegate.cycleScrollView(self, didScrollToIndex: indexOnPageControl)
        }
    }
}
