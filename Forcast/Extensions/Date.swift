//
//  Date.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation

extension Date {
  
  static func formattedDate(from timestamp: Int?) -> String? {
    guard let timestamp = timestamp else { return nil }
    
    let date = Date(timeIntervalSince1970: Double(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMMM - HH:mm"
    return dateFormatter.string(from: date)
  }
  
  static func isNight() -> Bool {
    let date = Date()
    let calendar = Calendar.current
    
    let hour = calendar.component(.hour, from: date)
    return hour > 18 || hour < 8
  }
  
}
