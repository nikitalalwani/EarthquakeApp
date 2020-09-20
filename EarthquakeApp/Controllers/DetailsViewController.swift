//
//  DetailsViewController.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import WebKit

protocol DetailsViewControllerProtocol:class {
    func refreshUI()
}

final class DetailsViewController: UIViewController, WKUIDelegate {

    //configure web view
        lazy var webView: WKWebView = {
            let webConfiguration = WKWebViewConfiguration()
            let webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            webView.translatesAutoresizingMaskIntoConstraints = false
            return webView
        }()
        
    //refreshing UI whenever viewModel is changed
        var viewModel: DetailViewModel? {
            didSet {
                refreshUI()
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
        
        func setupUI() {
                self.view.backgroundColor = .white
                self.view.addSubview(webView)
                
            //Programmatically adding constraints to web view
                NSLayoutConstraint.activate([
                    webView.topAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                    webView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                    webView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    webView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
            }
    }


extension DetailsViewController: DetailsViewControllerProtocol {
    
    //This method is used to open a url in a webView
    func refreshUI() {
        if let viewModel = viewModel, let feature = viewModel.feature {
            let myURL = URL(string: feature.properties.url ?? "")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        
    }
}

