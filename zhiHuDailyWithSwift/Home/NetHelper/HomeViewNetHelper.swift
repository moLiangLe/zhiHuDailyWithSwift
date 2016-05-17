//
//  HomeViewNetHelper.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/17.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeViewNetHelper {
    func asyncGetHomeAllArticles(dateOfDate date:NSDate, completionHandler:(()->())?) {
        if getCalenderString(date.description) == getCalenderString(NSDate().dateByAddingTimeInterval(28800).description) {
            Alamofire.request(.GET, "https://news-at.zhihu.com/api/4/news/latest").responseJSON {
                response in
                if response.result.isSuccess {
                    let data = JSON(response.result.value!)
                    //取到本日文章列表数据
                    let topStoryData = data["top_stories"]
                    let contentStoryData = data["stories"]
                    //注入topStory
                    var tempTopStory = [TopStoryModel]()
                    for i in 0 ..< topStoryData.count {
                        tempTopStory.append(TopStoryModel(image: topStoryData[i]["image"].string!, id: String(topStoryData[i]["id"]), title: topStoryData[i]["title"].string!))
                    }
                    
                    //注入contentStory
                    var tempContentStory = [ContentStoryModel]()
                    for i in 0 ..< contentStoryData.count {
                        tempContentStory.append(ContentStoryModel(images: [contentStoryData[i]["images"][0].string!], id: String(contentStoryData[i]["id"]), title: contentStoryData[i]["title"].string!))
                    }
                    
                    if let completionHandler = completionHandler {
                        completionHandler()
                    }
                    
                } else {
                    print("数据获取失败")
                    return
                }
            }
        }
    }
    
    // MARK: - 日期相关
    func getCalenderString(dateString: String) -> String {
        var calenderString = ""
        for character in dateString.characters {
            if character == " " {
                break
            } else if character != "-" {
                calenderString += "\(character)"
            }
        }
        return calenderString
    }
}
