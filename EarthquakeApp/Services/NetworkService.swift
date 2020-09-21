//
//  NetworkService.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

//Custom enums for error
enum NetworkError:Error {
    case malformedURL(message:String)
    case errorWith(response:URLResponse?)
    case dataParsinFailed
    case serverError
}

//completion handler to support network requests
typealias completionHandler<DataModel:Decodable> = (Result<DataModel , NetworkError>) -> Void
typealias imageDownlaodCompletionHandler = (Data?, NetworkError?) -> Void

class NetworkService {

    let urlSesson = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?
    
    //Fetch data from network along with handling the errors.
    // baseUrl + path creates = url
    // parameters contain start and end time
    func fetchDataFrom(baseUrl: String, path: String, parameters: String, completion: @escaping (Result<FeatureCollection, NetworkError>) -> Void) {
        dataTask?.cancel()
          //creating the url with parameters
        guard var urlComponents = URLComponents(string:baseUrl + path) else {
            completion(.failure(.malformedURL(message:"URL is not correct")))
            return
        }
        urlComponents.query = "\(parameters)"
        guard let url = urlComponents.url else {
            completion(.failure(.malformedURL(message:"URL is nil")))
            return
        }
        dataTask =  urlSesson.dataTask(with:url) { (data, responce, error)  in
            guard let data = data , let _response = responce as? HTTPURLResponse , (200...299).contains( _response.statusCode) else {
                completion(.failure(.serverError))
                return
            }
            do {
                let features = try JSONDecoder().decode(FeatureCollection.self, from: data)
                completion(.success(features))
            }catch {
                print(error)
                completion(.failure(.dataParsinFailed))
            }
        }
        dataTask?.resume()
    }
}

