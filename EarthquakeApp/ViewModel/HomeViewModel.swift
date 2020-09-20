//
//  HomeViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class HomeViewModel: GenericViewModel {
   
    weak var homeViewController:HomeViewControllerProtocol?
    var featureCollectionResultArray: FeatureCollection? {
         didSet {
             DispatchQueue.main.async {
                 self.homeViewController?.refreshUI()
             }
         }
    }
    //initializing homeviewmodel with its delegate as homecontroller
    init(_ homeViewControllerProtocol:HomeViewControllerProtocol) {
        super.init()
        self.homeViewController = homeViewControllerProtocol
        //gettting data from network and story it in a local array
        self.getFeatureResults { [weak self] (result)  in
            if let res = result {
                self?.featureCollectionResultArray = res
            }
        }
    }

    func getNumberOfFeatures() -> Int {
        if let featureResults = featureCollectionResultArray {
            return featureResults.features.count
        }
        return 0
    }
    
    //get title of the feature
    func getFeatureTitle(at index:Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        //If index exists then append title string to Title
        if index < featureResults.features.count && index >= 0 {
            return "Title: " + featureResults.features[index].properties.title
        }
        return ""
    }
    
    //get type of the feature
    func getFeatureType(at index:Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features.count && index >= 0 {
            return "Type: " + featureResults.features[index].properties.type
        }
        return ""
    }
    
    //get feature at a specific index
    func getFeature(at index:Int) -> Feature? {
        guard let featureResults = featureCollectionResultArray else {
            return nil
        }
        if index < featureResults.features.count && index >= 0 {
            return featureResults.features[index]
        }
        return nil
    }
    
    //get magnitude at a specific index
    func getMag(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features.count && index >= 0 {
            return "Magnitude: " + String(featureResults.features[index].properties.mag)
        }
        return ""
    }
    
    //get type of magnitude
    func getMagType(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features.count && index >= 0 {
            return "MagnitudeType: " + featureResults.features[index].properties.magType
        }
        return ""
    }
    
    //get location of the earthquake
    func getPlace(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features.count && index >= 0 {
            return "Place: " + featureResults.features[index].properties.place
        }
        return ""
    }
    
    //get date and time of the earthquake
    func getTime(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        //modifying time into a readable format
        if index < featureResults.features.count && index >= 0 {
            let timeResult = Double(featureResults.features[index].properties.time)
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return "Time: " + localDate
        }
        return ""
    }
}
