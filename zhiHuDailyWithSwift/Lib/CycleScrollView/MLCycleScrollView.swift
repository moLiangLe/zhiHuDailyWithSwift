//
//  MLCycleScrollView.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/11.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

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
    //func cycleScrollView(cycleScrollView: MLCycleScrollView, didScrollToIndex index:NSInteger)
}

class MLCycleScrollView: UIView {
    
    var infiniteLoop = true
    var delegate: MLCycleScrollViewDelegate?
    var placeholderImage: UIImage?
    var pageControlAliment: MLCycleScrollViewPageContolAliment = .Center
    var pageControlDotSize = CGSizeMake(10, 10)
    var dotColor: UIColor = UIColor.whiteColor()
    var titleLabelTextColor = UIColor.whiteColor()
    var titleLabelTextFont = UIFont.systemFontOfSize(12)
    var titleLabelBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    var titleLabelHeight: CGFloat = 30
    var titleLabelAlpha: CGFloat = 0
    lazy var localizationImagesGroup: [UIImage] = []
    lazy var titlesGroup: [String] = []
    
    var pageControlStyle: MLCycleScrollViewPageContolStyle = .Classic {
        didSet {
            setupPageControl()
        }
    }
    
    var autoScrollTimeInterval: CGFloat = 2.0 {
        didSet{
            setupTimer()
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
            setupTimer()
        }
    }
    
    var imageURLStringsGroup: [String] = [] {
        didSet {
            
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
    private var totalItemsCount: NSInteger = 0
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
        timer?.invalidate()
        timer = nil
        if autoScroll {
            
        }
    }
    
    private func setupPageControl() {
        if self.pageControl != nil {
            self.pageControl!.removeFromSuperview()
        }
        
        let pageControl = UIPageControl()
        pageControl.numberOfPages = self.imagesGroup.count;
        pageControl.currentPageIndicatorTintColor = self.dotColor;
        self.addSubview(pageControl)
        self.pageControl = pageControl;
    }
}


// MARK: ViewLogicLayer
extension MLCycleScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CycleScrollidentifier, forIndexPath: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
