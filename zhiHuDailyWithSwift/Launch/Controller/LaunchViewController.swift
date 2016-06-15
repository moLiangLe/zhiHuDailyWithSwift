//
//  LaunchViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/6/15.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import SnapKit
import DrawerController

class LaunchViewController: UIViewController {
    
    var launchImageView: UIImageView!
    var launchText: UILabel!
    var launchBottomView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        congfitSubView()
        
        launchText.text = NSUserDefaults.standardUserDefaults().objectForKey(Keys.launchTextKey) as? String
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(Keys.launchImgKey) {
            launchImageView.image = UIImage(data: data as! NSData)
        } else {
            launchImageView.image = UIImage(named: "DemoLaunchImage")
        }
        
        DailyNetHelper.asyncGetLaunchImage().then{ _ -> Void in
            
            let homeViewController = HomeViewController()
            let homeNav = UINavigationController(rootViewController: homeViewController)
            
            let sideViewController = SideMenuViewController()
            let sideNav = UINavigationController(rootViewController: sideViewController)
            
            let drawerController = DrawerController(centerViewController: homeNav, leftDrawerViewController: sideNav)
            drawerController.maximumLeftDrawerWidth = 100;
            drawerController.openDrawerGestureModeMask = OpenDrawerGestureMode.PanningCenterView
            drawerController.closeDrawerGestureModeMask = .All
            
            if let window = UIApplication.sharedApplication().delegate?.window {
                window?.rootViewController = drawerController;
            }
        }
    }
    
    func congfitSubView() {
        launchImageView = UIImageView()
        self.view.addSubview(launchImageView)
        
        launchBottomView = UIView()
        self.view.addSubview(launchBottomView)
        
        launchText = UILabel()
        self.view.addSubview(launchText)
        
        launchImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        launchBottomView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: ScreenHeight - 100, left: 0, bottom: 0, right: 0))
        }
        
        launchText.snp_makeConstraints { (make) in
            make.bottom.equalTo(launchBottomView.snp_top)
            make.centerX.equalTo(self.view.snp_centerX)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
