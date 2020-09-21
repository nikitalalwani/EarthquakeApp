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

struct Strings {
    
    static let sortButton = "sort"
    static let noData = "Unable to load data from server"
    static let homeTitle = "Earthquakes"
    static let pinReuseId = "pin"
    static let homeCell = "homeCell"
    static let detailTitle = "Details"
    static let emptyStr = ""
    static let urlNotCorrect = "URL is not correct"
    static let urlEmpty = "URL is nil"
    static let dateFormat = "dd/MM/yyyy"
    static let networkUnreachable = "Network became unreachable"
    static let networkReachableWifi = "Network reachable through WiFi"
    static let networkReachableData = "Network reachable through Cellular Data"
    static let reachabilityNotifier = "Could not start reachability notifier"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let userdefaultSortKey = "sortTypeSelected"
    static let sortCell = "sortCell"
}

extension UILabel {
    
    static func createNoDataLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:21))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray
        label.text = Strings.noData
        return label
    }
}


enum Coordinates: String {
    case latitude = "latitude"
    case longitude = "longitude"
}
