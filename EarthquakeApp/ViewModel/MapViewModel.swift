//
//  MapViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class MapViewModel: GenericViewModel {
    
    weak var mapViewController:MapViewControllerProtocol?

    var featureCollectionResultArray: FeatureCollection? {
         didSet {
             DispatchQueue.main.async {
                 self.mapViewController?.refreshMapUI()
             }
         }
    }

    init(_ mapViewControllerProtocol:MapViewControllerProtocol) {
        super.init()
        self.mapViewController = mapViewControllerProtocol
        
        //Getting data from network using completion handler
        self.getFeatures()
    }
    
    func getFeatures() {
           self.getFeatureResults { [weak self] (result)  in
               
               switch result {
               case .success(let model):
                   self?.featureCollectionResultArray = model
               case .failure(let error):
                   print(error.localizedDescription)
               }

         }
       }
   
    //Get all earthquake features array from the response
    func getAllFeatures() -> FeatureCollection? {
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
