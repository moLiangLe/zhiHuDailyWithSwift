//
//  HomeController.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/12.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    private var _tableView : UITableView!
    lazy var _dataKey = NSMutableArray()
    lazy var _dataFull = NSMutableDictionary() //date as key, above
    lazy var _slideArray = NSMutableArray()
    lazy var _slideImgArray = NSMutableArray()
    lazy var _slideTtlArray = NSMutableArray()
    private var _netHelper: HomeViewNetHelper?
    
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
        _netHelper = HomeViewNetHelper()
        showLauchImage()
        
        loadData()
    }
    
    func showLauchImage() {
        
    }
    
    func loadData(){
        _netHelper?.asyncGetHomeAllArticles(dateOfDate: NSDate(), completionHandler: {
            
        })
    }
}


