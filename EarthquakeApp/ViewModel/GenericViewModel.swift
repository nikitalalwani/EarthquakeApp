//
//  GenericViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class GenericViewModel: NSObject {

     var service = NetworkService()
    
    ///Get all the data from network. This view model is inherited by other models
      func getFeatureResults(completion: @escaping (Result<FeatureCollection?, NetworkError>) -> Void) {
        
        let par = "format=geojson&starttime=\(Date().getStartDate())&endtime=\(Date().getEndDate())"
        
        service.fetchDataFrom(baseUrl:EndPoints.baseUrl.rawValue, path:EndPointsPath.search.rawValue, parameters:par) { (result )  in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(.serverError))
                }
            }
        }

}
