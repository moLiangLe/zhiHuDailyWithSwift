//
//  HomeViewNetHelper.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/17.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation
import PromiseKit

class HomeViewNetHelper : MLNetWork {
    
    class func asyncGetHomeAllArticles() -> Promise<HomeStoryModel> {
        return getJSON("https://news-at.zhihu.com/api/4/news/latest", parameters: [:]).then { (response) -> Promise<HomeStoryModel> in
            
                let topStoryData = response["top_stories"]
                let contentStoryData = response["stories"]
                
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
                
                let homeStoryModel = HomeStoryModel(topStories: tempTopStory, contentStories: tempContentStory)
                return Promise(homeStoryModel)
        }
    }
    
//    // MARK: - 日期相关
//    func getCalenderString(dateString: String) -> String {
//        var calenderString = ""
//        for character in dateString.characters {
//            if character == " " {
//                break
//            } else if character != "-" {
//                calenderString += "\(character)"
//            }
//        }
//        return calenderString
//    }
}
