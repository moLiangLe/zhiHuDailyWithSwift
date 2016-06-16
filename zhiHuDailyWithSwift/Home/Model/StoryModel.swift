//
//  StoryModel.swift
//  zhihuDaily 2.0
//
//  Created by Nirvana on 10/2/15.
//  Copyright © 2015 NSNirvana. All rights reserved.
//

import Foundation

struct HomeStoryModel {
    let topStories: [TopStoryModel]
    let contentStories: [ContentStoryModel]
}

struct TopStoryModel {
    let image: String
    let id: String
    let title: String
}

protocol PastContentStoryItem {
    
}

struct ContentStoryModel: PastContentStoryItem {
    let images: [String]
    let id: String
    let title: String
}

struct DateHeaderModel:PastContentStoryItem {
    let date: String
}

struct ThemeModel {
    let id: String
    let name: String
}

struct ThemeContentModel {
    let stories: [ContentStoryModel]
    let background: String
    let editorsAvatars: [String]
}

struct Keys {
    static let launchImgKey = "launchImgKey"
    static let launchTextKey = "launchTextKey"
    static let readNewsId = "readNewsId"
}

struct ContentModel {
    let image: String?
    let titleString: String?
    let imageSource: String?
    let contentHtml: String?
    let shareUrl: String?
}
