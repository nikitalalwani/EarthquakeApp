//
//  HomeViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewModel: GenericViewModel {
   
    weak var homeViewController:HomeViewControllerProtocol?
    
    //our global array that is responsible for data render
    var featureCollectionResultArray: FeatureCollection? {
         didSet {
             DispatchQueue.main.async {
                 self.homeViewController?.refreshUI()
             }
         }
    }
    //Error in data fetching
    var fetchError: NetworkError? {
        didSet {
                 DispatchQueue.main.async {
                    self.homeViewController?.noData()
                 }
             }
    }
    //initializing homeviewmodel with its delegate as homecontroller
    init(_ homeViewControllerProtocol:HomeViewControllerProtocol) {
        super.init()
        homeViewController = homeViewControllerProtocol
        //gettting data from network and story it in a local array
        getFeatures()
    }
    //get All the features
    func getFeatures() {
        self.getFeatureResults { [weak self] (result)  in
            
            switch result {
            case .success(let model):
                self?.featureCollectionResultArray = model
            case .failure(let error):
                print(error.localizedDescription)
                self?.fetchError = error
            }

      }
    }

    func getNumberOfFeatures() -> Int {
        if let featureResults = featureCollectionResultArray {
            return featureResults.features?.count ?? 0
        }
        return 0
    }
    
    //get title of the feature
    func getFeatureTitle(at index:Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        //If index exists then append title string to Title
        if index < featureResults.features!.count && index >= 0 {
            if let str = featureResults.features?[index].properties?.title {
                return "Title: " + str
            }
        }
        return ""
    }
    
    //get type of the feature
    func getFeatureType(at index:Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features!.count && index >= 0 {
            if let str = featureResults.features?[index].properties?.type {
                return "Type: " + str
            }
        }
        return "Type: - "
    }
    
    //get feature at a specific index
    func getFeature(at index:Int) -> Feature? {
        guard let featureResults = featureCollectionResultArray else {
            return nil
        }
        if index < featureResults.features!.count && index >= 0 {
            return featureResults.features![index]
        }
        return nil
    }
    
    //get magnitude at a specific index
    func getMag(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features!.count && index >= 0 {
            if let str = featureResults.features![index].properties?.mag{
                return "Magnitude: " + String(str)
            }
        }
        return "Magnitude: - "
    }
    
    //get type of magnitude
    func getMagType(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features!.count && index >= 0 {
            if let str = featureResults.features![index].properties?.magType {
                 return "MagnitudeType: " + str
            }
        }
        return "MagnitudeType: - "
    }
    
    //get location of the earthquake
    func getPlace(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        if index < featureResults.features!.count && index >= 0 {
            if let str = featureResults.features![index].properties?.place {
                 return "Place: " + str
           }
        }
        return "Place: - "
    }
    
    //get date and time of the earthquake
    func getTime(at index: Int) -> String {
        guard let featureResults = featureCollectionResultArray else {
            return ""
        }
        //modifying time into a readable format
        if index < featureResults.features!.count && index >= 0 {
            guard let res = featureResults.features![index].properties?.time else {
                return ""
            }
            let localDate = Date().convertToLocalDate(res)
            return "Time: " + localDate
        }
        return "Time: - "
    }

    func sortByMag() {
        if var features =  featureCollectionResultArray?.features {
            
         features.sort{
            guard let first = $0.properties?.mag, let second = $1.properties?.mag else {
                    return false
            }
            return first < second
        }
            self.featureCollectionResultArray?.features = features
        }
    }
    
    func sortByDateAscending() {
        if var features =  featureCollectionResultArray?.features {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            features.sort {
                let first = Date().convertToLocalDate($0.properties?.time ?? 0)
                let second = Date().convertToLocalDate($1.properties?.time ?? 0)
                return first < second
            }
                self.featureCollectionResultArray?.features = features
         }
      }
    
    func sortByDateDescending() {
        if var features =  featureCollectionResultArray?.features {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            features.sort {
                let first = Date().convertToLocalDate($0.properties?.time ?? 0)
                let second = Date().convertToLocalDate($1.properties?.time ?? 0)
                return first > second
            }
                self.featureCollectionResultArray?.features = features
         }
      }
    //sorting the array based on ids
    func defaultSort() {
        if var features =  featureCollectionResultArray?.features {
         features.sort{
            guard let first = $0.id, let second = $1.id else {
                    return false
            }
            return first < second
        }
            self.featureCollectionResultArray?.features = features
        }
    }
}
