//
//  MLNetWork.swift
//  zhiHuDailyWithSwift
//
//  Created by LCL on 16/5/17.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class MLNetWork {
    typealias ParameterType = [String : AnyObject]
    
    class func postJSON(URLString: String, parameters: ParameterType) -> Promise<JSON> {
        
        let (promise, fulfill, reject) = Promise<JSON>.pendingPromise()
        
        Alamofire.request(.POST, URLString, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                fulfill(data)
            } else {
                reject(response.result.error!)
            }
        }
        return promise
    }
    
    class func getJSON(URLString: String, parameters: ParameterType) -> Promise<JSON> {
        
        let (promise, fulfill, reject) = Promise<JSON>.pendingPromise()
        
        Alamofire.request(.GET, URLString, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                fulfill(data)
            } else {
                reject(response.result.error!)
            }
        }
        
        return promise
    }
    
    class func getData(URLString: String) -> Promise<NSData> {
        let (promise, fulfill, reject) = Promise<NSData>.pendingPromise()
        
        Alamofire.request(.GET, URLString).responseData {
            response in
            if let data = response.result.value where response.result.isSuccess == true {
                fulfill(data)
            } else {
                reject(response.result.error!)
            }
        }
        
        return promise
    }
}
