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
    
    class func asyncGetBeforeDayArticles(dataOfDate date:NSDate) -> Promise<HomeStoryModel> {
        let componentOfURL = DateUtil.getCalenderString(date.dateByAddingTimeInterval(86400).description)
        //let calenderStringOfDate = DateUtil.getCalenderString(date.description)
        
        return getJSON("http://news.at.zhihu.com/api/4/news/before/\(componentOfURL)", parameters: [:]).then { (response) -> Promise<HomeStoryModel> in
            
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
        return getJSON("http://news-at.zhihu.com/api/4/themes", parameters: [:]).then { (response) -> Promise<[ThemeModel]> in
                let data = response["others"]
                var themeModel = [ThemeModel]()
                for i in 0 ..< data.count {
                    themeModel.append(ThemeModel(id: String(data[i]["id"]), name: data[i]["name"].string!))
                }
                return Promise(themeModel)
            }
    }
    
    //获取下一次所需的启动页数据
    class func asyncGetLaunchImage() {
//        return getJSON("http://news-at.zhihu.com/api/4/start-image/1080*1776", parameters: [:]).then { (response) -> Promise<Void> in
//            
//            //拿到text并保存
//            let text = JSON(dataResult.value!)["text"].string!
//            self.text.text = text
//            NSUserDefaults.standardUserDefaults().setObject(text, forKey: Keys.launchTextKey)
//            
//            //拿到图像URL后取出图像并保存
//            let launchImageURL = JSON(dataResult.value!)["img"].string!
//            Alamofire.request(.GET, launchImageURL).responseData({ (_, _, imgResult) -> Void in
//                let imgData = imgResult.value!
//                NSUserDefaults.standardUserDefaults().setObject(imgData, forKey: Keys.launchImgKey)
//            })
//            
//            return Promise()
//        }
    }
    
    class func asyncGetTheme(themeId: String) {
//        return getJSON("http://news-at.zhihu.com/api/4/theme/\(themeId)", parameters: [:]).then { (response) -> Promise<Void> in
//
//            //取得Story
//            let storyData = data["stories"]
//            //暂时注入themeStory
//            var themeStory: [ContentStoryModel] = []
//            for i in 0 ..< storyData.count {
//                //判断是否含图
//                if storyData[i]["images"] != nil {
//                    themeStory.append(ContentStoryModel(images: [storyData[i]["images"][0].string!], id: String(storyData[i]["id"]), title: storyData[i]["title"].string!))
//                } else {
//                    //若不含图
//                    themeStory.append(ContentStoryModel(images: [""], id: String(storyData[i]["id"]), title: storyData[i]["title"].string!))
//                }
//            }
//            
//            //取得avatars
//            let avatarsData = data["editors"]
//            //暂时注入editorsAvatars
//            var editorsAvatars: [String] = []
//            for i in 0 ..< avatarsData.count {
//                editorsAvatars.append(avatarsData[i]["avatar"].string!)
//            }
//            
//            //更新图片
//            self.navImageView.sd_setImageWithURL(NSURL(string: data["background"].string!), completed: { (image, _, _, _) -> Void in
//                self.themeSubview.blurViewImage = image
//                self.themeSubview.refreshBlurViewForNewImage()
//            })
//            
//            //注入themeContent
//            self.appCloud().themeContent = ThemeContentModel(stories: themeStory, background: data["background"].string!, editorsAvatars: editorsAvatars)
//            
//            return Promise()
//        }
    }
    
    class func asyncGetNextNews(newsID: String) {
//        return getJSON("http://news-at.zhihu.com/api/4/news/\(newsID)", parameters: [:]).then { (response) -> Promise<Void> in
//
//            //若body存在 拼接body与css后加载
//            if let body = JSON(dataResult.value!)["body"].string {
//                let css = JSON(dataResult.value!)["css"][0].string!
//                
//                if let image = JSON(dataResult.value!)["image"].string {
//                    if let titleString = JSON(dataResult.value!)["title"].string {
//                        if let imageSource = JSON(dataResult.value!)["image_source"].string {
//                            self.loadParallaxHeader(image, imageSource: imageSource, titleString: titleString)
//                        } else {
//                            self.loadParallaxHeader(image, imageSource: "(null)", titleString: titleString)
//                        }
//                        self.setNeedsStatusBarAppearanceUpdate()
//                    }
//                } else {
//                    self.hasImage = false
//                    self.setNeedsStatusBarAppearanceUpdate()
//                    self.statusBarBackground.backgroundColor = UIColor.whiteColor()
//                    self.loadNormalHeader()
//                }
//                
//                var html = "<html>"
//                html += "<head>"
//                html += "<link rel=\"stylesheet\" href="
//                html += css
//                html += "</head>"
//                html += "<body>"
//                html += body
//                html += "</body>"
//                html += "</html>"
//                
//                self.webView.loadHTMLString(html, baseURL: nil)
//            } else {
//                //若是直接使用share_url的类型
//                self.hasImage = false
//                self.setNeedsStatusBarAppearanceUpdate()
//                self.statusBarBackground.backgroundColor = UIColor.whiteColor()
//                self.loadNormalHeader()
//                
//                let url = JSON(dataResult.value!)["share_url"].string!
//                self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
//            }
//            
//            return Promise()
//        }
    }
}
