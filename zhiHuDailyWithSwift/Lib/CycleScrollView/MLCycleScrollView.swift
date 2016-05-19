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
    func cycleScrollView(cycleScrollView: MLCycleScrollView, didSelectItemAtIndex index:NSInteger)
}

class MLCycleScrollView: UIView {
    var localizationImagesGroup: [UIImage]?
    var imageURLStringsGroup: [String]?
    var titlesGroup: [String]?
    var autoScrollTimeInterval: CGFloat
    var infiniteLoop: Bool
    var autoScroll: Bool
    var delegate: MLCycleScrollViewDelegate?
    var showPageControl: Bool
    var pageControlStyle: MLCycleScrollViewPageContolStyle
    var placeholderImage: UIImage?
    var pageControlAliment: MLCycleScrollViewPageContolAliment
    var pageControlDotSize: CGSize
    var dotColor: UIColor?
    var titleLabelTextColor: UIColor?
    var titleLabelTextFont: UIFont?
    var titleLabelBackgroundColor: UIColor?
    var titleLabelHeight: CGFloat = 0
    var titleLabelAlpha: CGFloat = 0
    
    private var mainView: UICollectionView?
    private var flowLayout: UICollectionViewFlowLayout?
    private var imagesGroup: [UIImage]?
    private var timer: NSTimer?
    private var totalItemsCount: NSInteger = 0
    private var pageControl: UIControl?
    
    let CycleScrollidentifier = "CycleScrollidentifier"
    
    override init(frame: CGRect) {
        pageControlAliment = .Center
        autoScrollTimeInterval = 2.0
        titleLabelTextColor = UIColor.whiteColor()
        titleLabelTextFont = UIFont.systemFontOfSize(12)
        titleLabelBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        titleLabelHeight = 30
        autoScroll = true
        infiniteLoop = true
        showPageControl = true
        pageControlDotSize = CGSizeMake(10, 10)
        pageControlStyle = .Animated
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
    }
    
    convenience init(frame: CGRect, imagesGroup:[UIImage] ) {
        
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        mainView?.delegate = nil
        mainView?.dataSource = nil
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
