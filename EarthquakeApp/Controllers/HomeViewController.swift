//
//  HomeViewController.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/19/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import ReachabilitySwift

protocol HomeViewControllerProtocol:class {
    func refreshUI()
    func refreshTablView(for indexPath:IndexPath)
}

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!

    var homeViewModel: HomeViewModel?
    var noDataLbl: UILabel? = nil

    //View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Initializing the viewmodel with self as its delegate
        homeViewModel = HomeViewModel(self)
        ReachabilityManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }    

    //separate method for user interface setup
    func setupUI() {
        navigationItem.title = Strings.homeTitle
        navigationItem.titleView?.accessibilityIdentifier = Strings.homeTitle
        
        
        let button = UIButton.init(type: .custom)
        let img = UIImage.init(named: Strings.sortButton)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.contentMode = .scaleAspectFit
        button.setBackgroundImage(img, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(self.sortArr(_:)), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        noDataLbl = UILabel.createNoDataLabel()
        self.view.addSubview(noDataLbl ?? UILabel())
        noDataLbl?.isHidden = true
        noDataLbl?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant:2.0).isActive = true
        noDataLbl?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:2.0).isActive = true
    }
    
    //This method opens the sorting filter view
    @objc func sortArr(_ sender: UIBarButtonItem) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SortController") as? SortController else {
            return
        }
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion:nil)
    }

    //Moving to a view when tableview cell is tapped
         func moveToDetailVC(for indexPath:IndexPath) {
            let detailsViewCtrl = DetailsViewController()
            self.navigationController?.pushViewController(detailsViewCtrl, animated: true)
            //Pass the tapped cell's indexpath object from feature array to details view
            detailsViewCtrl.viewModel = DetailViewModel(feature:homeViewModel?.getFeature(at: indexPath.row), detailViewCtrl: detailsViewCtrl)
        }
    }

    //Extension for table view data source
    extension HomeViewController:UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let homeViewModel = homeViewModel else {
                return 0
            }
            return homeViewModel.getNumberOfFeatures()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:Strings.homeCell, for:indexPath) as! HomeCell
            
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

            //if homeViewModel exists, we will get all our details from view model that we need to show to the user
            if let homeViewModel = homeViewModel {
                cell.titleLbl.text = homeViewModel.getFeatureTitle(at: indexPath.row)
                cell.nameLbl.text = homeViewModel.getFeatureType(at: indexPath.row)
                cell.magTypeLbl.text = homeViewModel.getMagType(at: indexPath.row)
                cell.placeLbl.text = homeViewModel.getPlace(at: indexPath.row)
                cell.timeLbl.text = homeViewModel.getTime(at: indexPath.row)
                cell.albumImgView.text = homeViewModel.getMag(at: indexPath.row)
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

    extension HomeViewController:HomeViewControllerProtocol, SortControllerProtocol {
        func refreshUI() {
            tableView?.reloadData()
        }
        func refreshTablView(for indexPath:IndexPath) {
            tableView?.reloadRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        func refreshUIWithCriteria(_ criteria: SortType) {
            if criteria == .Magnitude {
                homeViewModel?.sortByMag()
            } else if criteria == .DateAsc {
                homeViewModel?.sortByDateAscending()
            } else if criteria == .DateDesc {
                homeViewModel?.sortByDateDescending()
            } else {
                homeViewModel?.defaultSort()
            }
        }
}

//handling the internet connection
extension HomeViewController: NetworkStatusListener {
    func networkStatusDidChange(status: Reachability.NetworkStatus) {

        switch status {
        case .notReachable:
            tableView.isHidden = true
            noDataLbl?.isHidden = false
        case .reachableViaWiFi:
            tableView.isHidden = false
            noDataLbl?.isHidden = true
            homeViewModel?.getFeatures()
        case .reachableViaWWAN:
            tableView.isHidden = false
            noDataLbl?.isHidden = true
            homeViewModel?.getFeatures()
        }
    }
}
