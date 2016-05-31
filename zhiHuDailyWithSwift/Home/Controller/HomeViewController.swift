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
    private var homeStoryModel: HomeStoryModel!
    private var cycleScrollView: MLCycleScrollView!
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
        
        cycleScrollView = MLCycleScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 154))
        cycleScrollView.configCycleScrollView()
        cycleScrollView.infiniteLoop = true
        cycleScrollView.delegate = self
        cycleScrollView.autoScrollTimeInterval = 6.0
        cycleScrollView.titleLabelTextFont = UIFont(name: "STHeitiSC-Medium", size: 21)!
        cycleScrollView.titleLabelBackgroundColor = UIColor.clearColor()
        cycleScrollView.titleLabelHeight = 60
        cycleScrollView.titleLabelAlpha = 1
        
        
        //将ParallaxView设置为tableHeaderView
        self.tableView.tableHeaderView = cycleScrollView
        
        loadData()
    }
    
    func loadData(){
        DailyNetHelper.asyncGetArticles(dataOfDate: NSDate().dateByAddingTimeInterval(28800 - Double(0) * 86400)).then
            { [unowned self] homeStoryModel -> Void in
                self.homeStoryModel = homeStoryModel
                for item in self.homeStoryModel.topStories {
                    self.cycleScrollView.imagePathsGroup.append(item.image)
                    self.cycleScrollView.titlesGroup.append(item.title)
                }
                self.tableView.reloadData()
        }
    }
}

// MARK: ViewLogicLayer
extension HomeViewController : UITableViewDataSource, UITableViewDelegate,MLCycleScrollViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let homeStoryModel = homeStoryModel else {
            return 0
        }
        
        return homeStoryModel.contentStories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HomeViewCell
        let contentStory =  homeStoryModel.contentStories[indexPath.row];
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
    
    func cycleScrollView(cycleScrollView: MLCycleScrollView, didSelectItemAtIndex index:NSInteger) {
        
    }
    
    func cycleScrollView(cycleScrollView: MLCycleScrollView, didScrollToIndex index:NSInteger) {
    
    }
}


