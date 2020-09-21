//
//  FeatureCollection.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/20/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit


    struct FeatureCollection: Decodable {
        var type: String?
        var metadata: MetaData?
        var features: [Feature]?
    }

    struct MetaData: Decodable {
        var generated: Int64?
        var url: String?
        var title: String?
        var status: Int?
        var api: String?
        var count: Int?
    }

    struct Feature: Decodable {
        var type: String?
        var properties: Properties?
        var geometry: Geometry?
        var id: String?
    }


    struct Properties: Decodable {
        var mag: Float?
        var place: String?
        var time: Int64?
        var updated: Int64?
        var url: String?
        var detail: String?
        var status: String?
        var magType: String?
        var type: String?
        var title: String?
    }

    struct Geometry: Decodable {
        var type: String?
        var coordinates: [Float64]?
    }
