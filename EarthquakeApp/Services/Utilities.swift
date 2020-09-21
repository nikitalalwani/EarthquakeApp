//
//  Utilities.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/20/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

extension Date {
    
    func getEndDate() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getStartDate() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let finalDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else { return "" }
        let dateString = dateFormatter.string(from: finalDate)
        return dateString

    }
    
    func convertToLocalDate(_ strTime: Int64)  -> String {
       let timeResult = Double(strTime)
       let date = Date(timeIntervalSince1970: timeResult/1000)
       let dateFormatter = DateFormatter()
       dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
       dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
       dateFormatter.timeZone = .current
       return dateFormatter.string(from: date)
    }
}

enum SortType: Int {
  case Magnitude = 0
  case DateAsc = 1
  case DateDesc = 2
  case None = 3

  var name: String {
    return String(describing: self)
  }
}
