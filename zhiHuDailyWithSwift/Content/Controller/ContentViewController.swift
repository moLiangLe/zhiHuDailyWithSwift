//
//  ContentViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/6/16.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate {
    
    var webView: UIWebView!
    var imageView: UIImageView!
    var orginalHeight: CGFloat = 0
    var titleLabel: UILabel!
    var blurView: MLGradientView!
    var refreshImageView: UIImageView!
    var dragging = false
    var triggered = false
    var newsId = ""
    var index = 1
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
    }
    func loadNormalHeader() {
        
    }
    
    //加载图片
    func loadParallaxHeader(imageURL: String, imageSource: String, titleString: String) {
    }

}
