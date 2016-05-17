//
//  MLViewModelProtocol.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/16.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

public class MLBaseViewModel {
    typealias BoolHandler = () -> Bool
    typealias VoidHandler = () -> ()
    
    let completionHandler: BoolHandler
    let updateHandler: VoidHandler
    
    public var isHasLoadMore:Bool { return _isHasLoadMore}
    private var _isHasLoadMore: Bool = true
    
    public var isFirst:Bool { return _isFirst}
    private var _isFirst: Bool = true
    
    init(completionHandler: BoolHandler, updateHandler:VoidHandler){
        self.completionHandler = completionHandler
        self.updateHandler = updateHandler
    }
    
    public func update() {
        _isFirst = handling() ? false : true
    }
    
    public func loadMore() {
        handling()
    }
    
    private func handling() -> Bool {
        updateHandler()
        if completionHandler() {
                return true
        }
        return false
    }
    
}