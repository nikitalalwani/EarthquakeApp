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
        
      func getFeatureResults(completion: @escaping (FeatureCollection?) -> Void) {
        service.fetchDataFrom(baseUrl:EndPoints.baseUrl.rawValue, path:EndPointsPath.search.rawValue, parameters:"format=geojson&starttime=2020-01-01&endtime=2020-01-02") { (result )  in
                switch result {
                case .success(let model):
                    completion(model)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
}
