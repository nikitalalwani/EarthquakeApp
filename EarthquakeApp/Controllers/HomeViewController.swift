//
//  HomeViewController.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
protocol HomeViewControllerProtocol:class {
    func refreshUI()
    func refreshTablView(for indexPath:IndexPath)
}

class HomeViewController: UIViewController {


    var homeViewModel: HomeViewModel?
        
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            
            //Initializing the viewmodel with self as its delegate
            homeViewModel = HomeViewModel(self)
            navigationItem.title = "Earthquakes"
            
        }

    //Moving to a view when tableview cell is tapped
         func moveToDetailVC(for indexPath:IndexPath) {
            let detailsViewCtrl = DetailsViewController()
            self.navigationController?.pushViewController(detailsViewCtrl, animated: true)
            //Pass the tapped cell's indexpath object from feature array to details view
            detailsViewCtrl.viewModel = DetailViewModel(feature:homeViewModel?.getFeature(at: indexPath.row), detailViewCtrl: detailsViewCtrl)
        }
    }


    extension HomeViewController:UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let homeViewModel = homeViewModel else {
                return 0
            }
            return homeViewModel.getNumberOfFeatures()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"homeCell", for:indexPath) as! HomeCell
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

            //if homeViewModel exists, we will get all our details from view model that we need to show to the user
            if let homeViewModel = homeViewModel {
                cell.titleLbl.text = homeViewModel.getFeatureTitle(at: indexPath.row)
                cell.nameLbl.text = homeViewModel.getFeatureType(at: indexPath.row)
                cell.magLbl.text = homeViewModel.getMag(at: indexPath.row)
                cell.magTypeLbl.text = homeViewModel.getMagType(at: indexPath.row)
                cell.placeLbl.text = homeViewModel.getPlace(at: indexPath.row)
                cell.timeLbl.text = homeViewModel.getTime(at: indexPath.row)
                cell.albumImgView.text = homeViewModel.getMag(at: indexPath.row)
            }else {
                cell.titleLbl.text = ""
                cell.nameLbl.text = ""
            }
            return cell
        }
    }


    extension HomeViewController:UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.moveToDetailVC(for: indexPath)
        }
    }

    extension HomeViewController:HomeViewControllerProtocol {
        func refreshUI() {
            tableView?.reloadData()
        }
        func refreshTablView(for indexPath:IndexPath) {
            tableView?.reloadRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
        }

}
