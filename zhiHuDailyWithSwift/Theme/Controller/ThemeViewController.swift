//
//  ThemeViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/6/1.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {
    
    weak var tableView: UITableView!
    weak var navTitleLabel: UILabel!
    weak var topConstant: NSLayoutConstraint!
    var id = ""
    var name = ""
    var firstDisplay = true
    var dragging = false
    var triggered = false
    var navImageView: UIImageView!
    var themeSubview: ParallaxHeaderView!
    //var animator: ZFModalTransitionAnimator!
    //var loadCircleView: PNCircleChart!
    var loadingView: UIActivityIndicatorView!
    let identifier = "ThemeViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //简单点说就是automaticallyAdjustsScrollViewInsets根据按所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，不让viewController调整，我们自己修改布局即可~
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame:self.view.bounds, style: .Plain)
        tableView.registerNib(UINib(nibName: "ThemeViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90;
        self.view.addSubview(tableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置StatusBar颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

extension ThemeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! ThemeViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
