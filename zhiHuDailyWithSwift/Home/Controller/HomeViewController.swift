//
//  HomeController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/12.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController{
    
    private var _tableView : UITableView!
    lazy var _dataKey = NSMutableArray()
    lazy var _dataFull = NSMutableDictionary() //date as key, above
    lazy var _slideArray = NSMutableArray()
    lazy var _slideImgArray = NSMutableArray()
    lazy var _slideTtlArray = NSMutableArray()
    
    var _bloading = false
    var _dateString = ""
    
    let identifier = "HomeViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今日热闻"
        _tableView = UITableView(frame:CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .Plain)
        _tableView.registerClass(HomeViewCell.self, forCellReuseIdentifier: identifier)
        self.edgesForExtendedLayout = UIRectEdge.Top
        _tableView.dataSource = self
        _tableView.delegate = self
        self.view.addSubview(_tableView)
        showLauchImage()
        
        loadData()
    }
    
    func showLauchImage() {
        
    }
    
    func loadData(){
        HomeViewNetHelper.asyncGetHomeAllArticles().then { homeStoryModel -> Void in
            print(homeStoryModel)
        }
    }
}


