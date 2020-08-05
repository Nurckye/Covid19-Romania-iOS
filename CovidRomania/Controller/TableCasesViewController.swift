//
//  TableCasesViewController.swift
//  CovidRomania
//
//  Created by Radu Nitescu  on 21/07/2020.
//  Copyright © 2020 Radu Nitescu . All rights reserved.
//

import UIKit

class TableCasesViewController: UITableViewController, UISearchResultsUpdating {
    let searchController = UISearchController(searchResultsController: nil)
    var filteredData = MapUtils.APIData?.data
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.filteredData = MapUtils.APIData?.data.filter { $0.county.lowercased().folding(options: .diacriticInsensitive, locale: .current).hasPrefix(text.lowercased().folding(options: .diacriticInsensitive, locale: .current)) }
        print(text)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Cautati dupa numele localitatii"

        self.tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.register(NumberUITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = self.filteredData?.count else {
            return 0
        }
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NumberUITableViewCell
        cell.countyData = self.filteredData?[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let secondViewController = MapViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst().lowercased()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
