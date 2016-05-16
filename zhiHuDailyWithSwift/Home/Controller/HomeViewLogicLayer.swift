//
//  HomeViewLogicLayer.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/16.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let identifier = "HomeViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)!
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    
}

