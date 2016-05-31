//
//  DateUtil.swift
//  zhiHuDailyWithSwift
//
//  Created by moLiang on 16/5/31.
//  Copyright © 2016年 moliang. All rights reserved.
//

import Foundation

struct DateUtil {
    // MARK: - 日期相关
    static func getCalenderString(dateString: String) -> String {
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
    
    static func getDetailString(dateString: String) -> String {
        //拿到month
        var month = ""
        month = dateString.substringWithRange(Range(dateString.startIndex.advancedBy(4) ..< dateString.startIndex.advancedBy(6)))
        if month.hasPrefix("0") {
            month.removeAtIndex(month.startIndex)
        }
        
        //拿到day
        var day = ""
        
        day = dateString.substringWithRange(Range(dateString.startIndex.advancedBy(6) ..< dateString.startIndex.advancedBy(8)))
        if day.hasPrefix("0") {
            day.removeAtIndex(day.startIndex)
        }
        //拼接返回
        return month + "月" + day + "日"
    }
}

extension NSDate {
    func dayOfWeek() -> String {
        let interval = self.timeIntervalSince1970
        let days = Int(interval / 86400)
        let intValue = (days - 3) % 7
        switch intValue {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
            break
        }
        return "未取到数据"
    }
}