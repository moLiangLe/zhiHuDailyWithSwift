//
//  SideMenuViewController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/23.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    let identifier = "SideMenuCell"
    var tableView: UITableView!
    var blurView: MLGradientView!
    private var themeList: [ThemeModel] = []
    
    var originState = true {
        didSet {
            if oldValue != originState {
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        self.tableView.backgroundColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 32/255.0)
        self.tableView.separatorStyle = .None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 50.5
        tableView.registerNib(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.view.addSubview(tableView)
        
        blurView = MLGradientView(frame: CGRect(x: 0, y: ScreenHeight - 45 - 50 , width: ScreenWidth, height: 50), type: .TransparentOther)
        view.backgroundColor = UIColor(red: 19/255.0, green: 26/255.0, blue: 32/255.0)
        loadData()
    }
    
    func loadData() {
        DailyNetHelper.asyncGetThemesData().then{ [unowned self] themeList -> Void in
            self.themeList = themeList;
            self.tableView.reloadData()
        }
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
        guard themeList.count > 0 else {
            return 0
        }
        return themeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! SideMenuCell
        cell.congfigSileMenu(self.themeList[indexPath.row].name, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
