//
//  HomeViewModel.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/17.
//  Copyright © 2016年 moliang. All rights reserved.
//

import UIKit


class HomeViewModel: MLBaseViewModel {
    private let _netHelper: DailyNetHelper
    
    override init(completionHandler: BoolHandler, updateHandler: VoidHandler) {
        _netHelper = DailyNetHelper()
        super.init(completionHandler: completionHandler, updateHandler: updateHandler)
    }
    
    
}
