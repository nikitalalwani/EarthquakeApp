//
//  MapViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

enum Coordinates: String {
    case latitude = "latitude"
    case longitude = "longitude"
}

class MapViewModel: GenericViewModel {
    
    weak var mapViewController:MapViewControllerProtocol?

    var featureCollectionResultArray: FeatureCollection? {
         didSet {
             DispatchQueue.main.async {
                 self.mapViewController?.refreshMapUI()
             }
         }
    }
    var fetchError: Bool? {
        didSet {
                 DispatchQueue.main.async {
                    self.mapViewController?.noData()
                 }
             }
    }
    
    init(_ mapViewControllerProtocol:MapViewControllerProtocol) {
        super.init()
        self.mapViewController = mapViewControllerProtocol
        
        //Getting data from network using completion handler
        self.getFeaturesData()
    }
    
    func getFeaturesData() {
           self.getFeatureResults { [weak self] (result)  in
               
               switch result {
               case .success(let model):
                   self?.featureCollectionResultArray = model
               case .failure(let error):
                   print(error.localizedDescription)
                   self?.fetchError = ((error as? NetworkError) != nil)
               }

         }
       }
   
    //Get all earthquake features array from the response
    func getFeatures() -> FeatureCollection? {
        guard let featureResults = featureCollectionResultArray else {
            return nil
        }

        return featureResults
    }
    
    //getting a specific feature from a given id
    func getFeatureWithId(_ id: String) -> Feature? {
     guard let featureResults = featureCollectionResultArray else {
                    return nil
    }
        
        for feature in featureResults.features ?? [] {
            if feature.id == id {
                return feature
            }
        }
      return nil
    }
    

}
