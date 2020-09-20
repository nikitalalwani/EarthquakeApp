//
//  DetailViewModel.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    weak var detailViewCtrl:DetailsViewControllerProtocol?
    var feature:Feature?

    init(feature:Feature?, detailViewCtrl:DetailsViewControllerProtocol) {
        self.detailViewCtrl = detailViewCtrl
        self.feature = feature
    }
}
