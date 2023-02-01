//
//  Date+.swift
//  GongGanGam
//
//  Created by kimchansoo on 2023/02/01.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

extension Date {
    
    enum Format: String {
        case yearToDay = "yyyy-MM-dd"
        case yearToSecond = "yyyy-MM-dd HH:mm:ss"
        case timeStamp = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case hourAndMinute = "HH:mm"
        case monthAndDate = "M월 d일"
        case monthAndDate2 = "MM/dd"
        case yearAndMonthAndDate = "YYYY년 M월 d일"
        case yearAndMonth = "YYYY년 M월"
    }
    
    // MARK: Methods
    func toString(type: Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = type.rawValue
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }

    func stringToDate(dateString: String, type: Format) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = type.rawValue
        return formatter.date(from: dateString)
    }
    
    func stringToDate(dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}

extension Date {
    
    static func fromStringOrNow(_ string: String, ofFormat format: Format = .timeStamp) -> Date {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "ko_KR")
        
        if formatter.date(from: string) == nil {
//            Logger.print("string -> date failed.")
        }
        
        return formatter.date(from: string) ?? Date()
    }
}
