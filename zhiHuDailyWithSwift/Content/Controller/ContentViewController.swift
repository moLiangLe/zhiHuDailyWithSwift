//
//  ContentViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/6/16.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import Kingfisher

private let kTableHeaderHeight: CGFloat = 223.0
private let kTableHeaderCutAway: CGFloat = 10.0

class ContentViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate {

    var headerView: UIView!
    var webView: UIWebView!
    var imageView: UIImageView!
    var orginalHeight: CGFloat = 0
    var titleLabel: UILabel!
    var sourceLabel: UILabel!
    var blurView: MLGradientView!
    var refreshImageView: UIImageView!
    var dragging = false
    var triggered = false
    var newsId = ""
    var index = 0
    var isTopStory = false
    var hasImage = true
    var isThemeStory = false
    
    //滑到对应位置时调整StatusBar
    var statusBarFlag = true {
        didSet {
            UIView.animateWithDuration(0.2) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    //滑到对应位置时调整arrow方向
    var arrowState = false {
        didSet {
            if arrowState == true {
                
                guard index != 0 && isTopStory == false else {
                    return
                }
                
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.refreshImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                }
            } else {
                
                guard index != 0 && isTopStory == false else {
                    return
                }
                
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.refreshImageView.transform = CGAffineTransformIdentity
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSubView()
        
        //避免因含有navBar而对scrollInsets做自动调整
        self.automaticallyAdjustsScrollViewInsets = false
        
        //避免webScrollView的ContentView过长 挡住底层View
        self.view.clipsToBounds = true
        
        //隐藏默认返回button但保留左划返回
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.webView.delegate = self
        //对scrollView做基本配置
        self.webView.scrollView.delegate = self
        self.webView.scrollView.clipsToBounds = false
        self.webView.scrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(animated: Bool) {
        DailyNetHelper.asyncGetNextNews(newsId).then{
            [unowned self] contextModel -> Void in
            if let image = contextModel.image , let titleString = contextModel.titleString {
                if let imageSource = contextModel.imageSource {
                    self.loadParallaxHeader(image, imageSource: imageSource, titleString: titleString)
                } else {
                    self.loadParallaxHeader(image, imageSource: "(null)", titleString: titleString)
                }
            
            } else {
                self.hasImage = false
                self.setNeedsStatusBarAppearanceUpdate()
                self.loadNormalHeader()
            }
            
            if let html = contextModel.contentHtml{
                self.webView.loadHTMLString(html, baseURL: nil)
            } else if let url = contextModel.shareUrl {
                self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func configSubView(){
        webView = UIWebView(frame: self.view.bounds)
        view.addSubview(webView)
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kTableHeaderHeight))
        webView.addSubview(headerView)
    }
    
    //加载普通header
    func loadNormalHeader() {
        //载入上一篇Label
        let refreshLabel = UILabel(frame: CGRectMake(12, -45, self.view.frame.width, 45))
        refreshLabel.text = "载入上一篇"
        if index == 0 {
            refreshLabel.text = "已经是第一篇了"
            refreshLabel.frame = CGRectMake(0, -45, self.view.frame.width, 45)
        }
        refreshLabel.textAlignment = NSTextAlignment.Center
        refreshLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1)
        refreshLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        self.webView.scrollView.addSubview(refreshLabel)
        
        if refreshLabel.text != "已经是第一篇了" {
            //"载入上一篇"imageView
            refreshImageView = UIImageView(frame: CGRectMake(self.view.frame.width / 2 - 47, -30, 15, 15))
            refreshImageView.contentMode = UIViewContentMode.ScaleAspectFill
            refreshImageView.image = UIImage(named: "arrow")?.imageWithRenderingMode(.AlwaysTemplate)
            refreshImageView.tintColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1)
            self.webView.scrollView.addSubview(refreshImageView)
        }
    }
    
    //加载图片
    func loadParallaxHeader(imageURL: String, imageSource: String, titleString: String) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kTableHeaderHeight))
        imageView.contentMode = .ScaleToFill
        imageView.kf_setImageWithURL(NSURL(string: imageURL)!)
        
        orginalHeight = imageView.heiht
        
        titleLabel = UILabel(frame: CGRect(x: 15, y: orginalHeight - 80, width: ScreenWidth - 30, height: 60))
        titleLabel.font = UIFont(name: "STHeitiSC-Medium", size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.shadowColor = UIColor.blackColor()
        titleLabel.shadowOffset = CGSizeMake(0, 1)
        titleLabel.numberOfLines = 0
        titleLabel.text = titleString
        imageView.addSubview(titleLabel)
        
        //设置Image上的Image_sourceLabel
        sourceLabel = UILabel(frame: CGRectMake(15, orginalHeight - 22, self.view.frame.width - 30, 15))
        sourceLabel.font = UIFont(name: "HelveticaNeue", size: 9)
        sourceLabel.textColor = UIColor.lightTextColor()
        sourceLabel.textAlignment = NSTextAlignment.Right
        let sourceLabelText = imageSource
        sourceLabel.text = "图片：" + sourceLabelText
        imageView.addSubview(sourceLabel)
        
        //设置Image上的blurView
        blurView = MLGradientView(frame: CGRectMake(0, -85, self.view.frame.width, orginalHeight + 85), type: .TransparentTwice)
        //在blurView上添加"载入上一篇"Label
        let refreshLabel = UILabel(frame: CGRectMake(12, 15, self.view.frame.width, 45))
        refreshLabel.text = "载入上一篇"
        if index == 0 || isTopStory {
            refreshLabel.text = "已经是第一篇了"
            refreshLabel.frame = CGRectMake(0, 15, self.view.frame.width, 45)
        }
        refreshLabel.textAlignment = NSTextAlignment.Center
        refreshLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1)
        refreshLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        blurView.addSubview(refreshLabel)
        
        if refreshLabel.text != "已经是第一篇了" {
            //在blurView上添加"载入上一篇"图片
            refreshImageView = UIImageView(frame: CGRectMake(self.view.frame.width / 2 - 47, 30, 15, 15))
            refreshImageView.contentMode = UIViewContentMode.ScaleAspectFill
            refreshImageView.image = UIImage(named: "arrow")?.imageWithRenderingMode(.AlwaysTemplate)
            refreshImageView.tintColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1)
            blurView.addSubview(refreshImageView)
        }
        
        imageView.addSubview(blurView)
        //使Label不被遮挡
        imageView.bringSubviewToFront(titleLabel)
        imageView.bringSubviewToFront(sourceLabel)
        
        //将其添加到
        headerView.addSubview(imageView)
    }
    
    //依据statusBarFlag返回StatusBar颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //无图的情况
        guard hasImage else {
            return .Default
        }
        if statusBarFlag {
            return .LightContent
        }
        return .Default
    }
    
    //实现Parallax效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //判断是否含图
        if hasImage {
            let incrementY = scrollView.contentOffset.y
            if incrementY < 0 {
                
                //不断设置titleLabel及sourceLabel以保证frame正确
                titleLabel.frame = CGRectMake(15, orginalHeight - 80 - incrementY, self.view.frame.width - 30, 60)
                sourceLabel.frame = CGRectMake(15, orginalHeight - 20 - incrementY, self.view.frame.width - 30, 15)
                
                //保证frame正确
                blurView.frame = CGRectMake(0, -85 - incrementY, self.view.frame.width, orginalHeight + 85)
                
                //如果下拉超过65pixels则改变图片方向
                if incrementY <= -65 {
                    arrowState = true
                    //如果此时是第一次检测到松手则加载上一篇
                    guard dragging || triggered else {
                        //index不能为零, 且不为topStory
                        if index != 0 && isTopStory == false {
                            //loadNewArticle(true)
                            triggered = true
                        }
                        return
                    }
                } else {
                    let headerRect = CGRect(x: 0, y: 0, width: ScreenWidth, height: orginalHeight + -incrementY)
                    imageView.frame = headerRect
                    arrowState = false
                }
                
                //使Label不被遮挡
                imageView.bringSubviewToFront(titleLabel)
                imageView.bringSubviewToFront(sourceLabel)
            }
            
            //监听contentOffsetY以改变StatusBarUI
            if incrementY > 223 {
                if statusBarFlag {
                    statusBarFlag = false
                    if var parent = self.parentViewController {
                        while (parent.parentViewController != nil) {
                            parent = parent.parentViewController!
                        }
                        
                        guard let parentVC = parent as? ContentViewController else {
                            return
                        }
                        
                        parentVC.statusBarFlag = false
                    }
                }
                //statusBarBackground.backgroundColor = UIColor.whiteColor()
            } else {
                guard statusBarFlag else {
                    statusBarFlag = true
                    if var parent = self.parentViewController {
                        while (parent.parentViewController != nil) {
                            parent = parent.parentViewController!
                        }
                        guard let parentVC = parent as? ContentViewController else {
                            return
                        }
                        
                        parentVC.statusBarFlag = false
                    }
                    return
                }
                //statusBarBackground.backgroundColor = UIColor.clearColor()
            }
            
            layoutWebHeaderViewForScrollViewOffset(scrollView.contentOffset)
        } else {
            //如果下拉超过40pixels则改变图片方向
            if self.webView.scrollView.contentOffset.y <= -40 {
                arrowState = true
                //如果此时是第一次检测到松手则加载上一篇
                guard dragging || triggered else {
                    //index不能为零, 且不为topStory
                    if index != 0 {
                        //loadNewArticle(true)
                        triggered = true
                    }
                    return
                }
            } else {
                arrowState = false
            }
        }
    }
    
    //设置滑动极限 修改该值需要一并更改layoutWebHeaderViewForScrollViewOffset中的对应值
    func lockDirection() {
        self.webView.scrollView.contentOffset.y = -85
    }
    
    func layoutWebHeaderViewForScrollViewOffset(offset:CGPoint){
        if offset.y > 0 {
            
        } else if (offset.y < -85) {
            lockDirection()
        } else {
            var delta :CGFloat = 0.0
            var rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: kTableHeaderHeight)
            delta = offset.y;
            rect.origin.y += delta;
            rect.size.height -= delta;
        }
    }
}
