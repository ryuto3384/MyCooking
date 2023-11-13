//
//  Date_Extensions.swift
//  MyCooking
//
//  Created by 中島瑠斗 on 2023/11/13.
//

import SwiftUI

//Date Extensions Needed for Building UI
extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ja_JP")
        
        return formatter.string(from: self)
    }
    
    //日本の表記
    func dateformat(_ now: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        // 日本のロケールを設定
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let formattedDate = dateFormatter.string(from: now)
        
        return formattedDate
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    //checking if the date is same hour
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    //checking if the date is Past hours
    var isPast: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    //指定した日付に対しての週を取得する
    // Fetch Week Based on given Date
    //dateがない時にデフォルト値で現在の日付が入る
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        //現在のカレンダーオブジェクトを取得
        //Calendar(identifier: .gregorian)でローカルカレンダーではなく西暦で指定する
        //ローカルカレンダーならCalendar.current
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)

        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekday, for: startOfDate)
        //print(weekForDate)
        guard (weekForDate? .start) != nil else {
            return []
        }
        
        //一週間分を取得する
        // Iterating to get the Full week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfDate) {
                //print(weekDay)
                week.append(.init(date: weekDay))
            }
        }
        
        return week
        
    }
    
    //next Week creatting
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    //previous Week creatting
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else {
            return []
        }
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
