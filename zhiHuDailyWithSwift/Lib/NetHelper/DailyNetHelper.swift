//
//  HomeViewNetHelper.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/17.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation
import PromiseKit

class DailyNetHelper : MLNetWork {
    
    //请求给定日期的首页文章数据
    class func asyncGetArticles(dataOfDate date:NSDate) -> Promise<HomeStoryModel> {
        if DateUtil.getCalenderString(date.description) == DateUtil.getCalenderString(NSDate().dateByAddingTimeInterval(28800).description) {
            return asyncGetTodayArticles()
        }
        return asyncGetBeforeDayArticles(dataOfDate: date)
    }
    
    class func asyncGetTodayArticles() -> Promise<HomeStoryModel> {
        return getJSON("https://news-at.zhihu.com/api/4/news/latest", parameters: [:]).then { response -> Promise<HomeStoryModel> in
            
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
    
    class func asyncGetBeforeDayArticles(dataOfDate date:NSDate) -> Promise<HomeStoryModel> {
        let componentOfURL = DateUtil.getCalenderString(date.dateByAddingTimeInterval(86400).description)
        //let calenderStringOfDate = DateUtil.getCalenderString(date.description)
        
        return getJSON("http://news.at.zhihu.com/api/4/news/before/\(componentOfURL)", parameters: [:]).then { response -> Promise<HomeStoryModel> in
            
            let contentStoryData = response["stories"]
            
            //注入contentStory
            var tempContentStory = [ContentStoryModel]()
            for i in 0 ..< contentStoryData.count {
                tempContentStory.append(ContentStoryModel(images: [contentStoryData[i]["images"][0].string!], id: String(contentStoryData[i]["id"]), title: contentStoryData[i]["title"].string!))
            }
            
            let homeStoryModel = HomeStoryModel(topStories: [], contentStories: tempContentStory)
            return Promise(homeStoryModel)
        }
    }
    
    //取得主题日报列表
    class func asyncGetThemesData() -> Promise<[ThemeModel]> {
        return getJSON("http://news-at.zhihu.com/api/4/themes", parameters: [:]).then { response -> Promise<[ThemeModel]> in
                let data = response["others"]
                var themeModel = [ThemeModel]()
                for i in 0 ..< data.count {
                    themeModel.append(ThemeModel(id: String(data[i]["id"]), name: data[i]["name"].string!))
                }
                return Promise(themeModel)
            }
    }
    
    //获取下一次所需的启动页数据
    class func asyncGetLaunchImage() -> Promise<Void>{
        //下载下一次所需的启动页数据
        return getJSON("http://news-at.zhihu.com/api/4/start-image/1080*1776", parameters: [:])
            .then{ response -> Promise<String> in
            //拿到text并保存
            let text = response["text"].stringValue
            NSUserDefaults.standardUserDefaults().setObject(text, forKey: Keys.launchTextKey)
            let launchImageURL = response["img"].stringValue
            return Promise(launchImageURL)
            }
            .then{ launchImageURL -> Promise<NSData> in
                return getData(launchImageURL)
            }
            .then{ response -> Promise<Void> in
                let imgData = response;
                NSUserDefaults.standardUserDefaults().setObject(imgData, forKey: Keys.launchImgKey)
                return Promise()
        }
    }
    
    class func asyncGetTheme(themeId: String) -> Promise<ThemeContentModel>{
        return getJSON("http://news-at.zhihu.com/api/4/theme/\(themeId)", parameters: [:]).then { response -> Promise<ThemeContentModel> in

            //取得Story
            let storyData = response["stories"]
            //暂时注入themeStory
            var themeStory: [ContentStoryModel] = []
            for i in 0 ..< storyData.count {
                //判断是否含图
                if storyData[i]["images"] != nil {
                    themeStory.append(ContentStoryModel(images: [storyData[i]["images"][0].string!], id: String(storyData[i]["id"]), title: storyData[i]["title"].string!))
                } else {
                    //若不含图
                    themeStory.append(ContentStoryModel(images: [""], id: String(storyData[i]["id"]), title: storyData[i]["title"].string!))
                }
            }
            
            //取得avatars
            let avatarsData = response["editors"]
            //暂时注入editorsAvatars
            var editorsAvatars: [String] = []
            for i in 0 ..< avatarsData.count {
                editorsAvatars.append(avatarsData[i]["avatar"].string!)
            }
            
            //注入themeContent
            let themeContentModel = ThemeContentModel(stories: themeStory, background: response["background"].stringValue, editorsAvatars: editorsAvatars)
            
            return Promise(themeContentModel)
        }
    }
    
    class func asyncGetNextNews(newsID: String) -> Promise<ContentModel>{
        return getJSON("http://news-at.zhihu.com/api/4/news/\(newsID)", parameters: [:]).then { response -> Promise<ContentModel> in

            //若body存在 拼接body与css后加载
            if let body = response["body"].string {
                let css = response["css"][0].stringValue
                let image = response["image"].string
                let titleString = response["title"].string
                let imageSource = response["image_source"].string
                
                var html = "<html>"
                html += "<head>"
                html += "<link rel=\"stylesheet\" href="
                html += css
                html += "</head>"
                html += "<body>"
                html += body
                html += "</body>"
                html += "</html>"
                
                let contentModel = ContentModel(image: image, titleString: titleString, imageSource: imageSource, contentHtml: html, shareUrl: nil)
                return Promise(contentModel)
            } else {
                //若是直接使用share_url的类型
                let url = response["share_url"].stringValue
                let contentModel = ContentModel(image: nil, titleString: nil, imageSource: nil, contentHtml: nil, shareUrl: url)
                return Promise(contentModel)
            }
        }
    }
}
