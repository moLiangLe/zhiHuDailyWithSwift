//
//  HomeController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/12.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher

class HomeViewController: UIViewController{
    
    private var tableView: UITableView!
    private var homeStoryModel: HomeStoryModel?
    let identifier = "homeViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今日热闻"
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .Plain)
        tableView.registerNib(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.edgesForExtendedLayout = UIRectEdge.Top
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        loadData()
    }
    
    func loadData(){
        HomeViewNetHelper.asyncGetHomeAllArticles().then
            { homeStoryModel -> Void in
            self.homeStoryModel = homeStoryModel
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let homeStoryModel = homeStoryModel else {
            return 0
        }
        
        return homeStoryModel.contentStories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let identifier = "homeViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HomeViewCell
        let contentStory =  homeStoryModel!.contentStories[indexPath.row];
        cell.titleLabel.text = contentStory.title
        if let url = NSURL(string: homeStoryModel!.contentStories[indexPath.row].images[0]) {
            cell.titleImageView.kf_setImageWithURL(url)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
    
}


