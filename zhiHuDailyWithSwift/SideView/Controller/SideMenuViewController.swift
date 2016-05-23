//
//  SideMenuViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/23.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    let identifier = "SideMenuViewCell"
    var tableView: UITableView!
    var blurView: MLGradientView!
    var originState = true {
        didSet {
            if oldValue != originState {
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .Plain)
        self.tableView.backgroundColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 32/255.0)
        self.tableView.separatorStyle = .None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50.5
        
        blurView = MLGradientView(frame: CGRect(x: 0, y: ScreenHeight - 45 - 50 , width: ScreenWidth, height: 50), type: .TransparentOther)
        view.backgroundColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 32/255.0)
    }
    
    //更改StatusBar颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//tableViewDataSource和Delegate
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HomeViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
