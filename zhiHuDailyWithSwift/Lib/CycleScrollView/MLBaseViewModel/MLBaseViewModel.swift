//
//  MLViewModelProtocol.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/16.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

public struct MLBaseViewModel {
    typealias BoolHandler = () -> Bool
    typealias VoidHandler = () -> ()
    
    let completionHandler: BoolHandler?
    let updateHandler: VoidHandler?
    
    public var isHasLoadMore:Bool { return _isHasLoadMore}
    private var _isHasLoadMore: Bool = true
    
    public var isFirst:Bool { return _isFirst}
    private var _isFirst: Bool = true
    
    public mutating func update() {
        _isFirst = handling() ? false : true
    }
    
    public mutating func loadMore() {
        handling()
    }
    
    private mutating func handling() -> Bool {
        if let updateHandler = updateHandler{
            updateHandler()
        }
        
        if let completionHandler = completionHandler {
            if completionHandler() {
                return true
            }
        }
        return false
    }
    
}