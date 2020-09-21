//
//  SortController.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/20/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

protocol SortControllerProtocol: class {
    func refreshUIWithCriteria(_ criteria: SortType)
}

class SortController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    public var delegate: SortControllerProtocol?

    let values = ["Magnitude", "Date(Ascending)","Date(Descending)", "None"]
    var sortType = SortType.None
    var selectedIndex = 3 {
        didSet {
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setCheckmark()
    }
    
    func setCheckmark() {
        if UserDefaults.standard.value(forKey: Strings.userdefaultSortKey) != nil {
            if let check = UserDefaults.standard.object (forKey: Strings.userdefaultSortKey) {
                selectedIndex = check as! Int
            }
        }
    }
    
    @IBAction func closePressed() {
        self.dismiss(animated: true, completion: nil)
        delegate?.refreshUIWithCriteria(sortType)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.sortCell, for: indexPath)
        cell.textLabel?.text = values[indexPath.row]
        
        if selectedIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        sortType = SortType.init(rawValue: indexPath.row) ?? SortType.None
        selectedIndex = indexPath.row
        UserDefaults.standard.set(selectedIndex, forKey: Strings.userdefaultSortKey)
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
                  self.tableView.reloadData()
        }
      }

}

