//
//  ViewController.swift
//  City2City
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupView()
        viewModel.get()
        
    }
    
    
    
    //MARK: Helper Functions
    
    func getCities(for section: Int) -> [City] {
        
        let keys = viewModel.orderedCities.keys.sorted(by: {$0 < $1})
        
        //access the key by section
        let key = keys[section]
        
        //get correct cities based on key
        return viewModel.orderedCities[key]!
    
    }
    
    func filterCities(by search: String) {
        
        viewModel.filteredCities = viewModel.cities.filter({$0.name.lowercased().contains(search.lowercased()) || $0.state.lowercased().contains(search.lowercased())})
        
        searchTableView.reloadData()
        
    }
    
    func isFiltering() -> Bool {
        
        let isEmpty = searchController.searchBar.text!.isEmpty
        
        return !isEmpty && searchController.isActive
        
    }
    
    
    //MARK: Search Functionality
    
    func setupSearch() {
        
        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities..."
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    //MARK: Setup
    
    func setupView() {
        
        searchTableView.register(UINib(nibName: CityTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityTableCell.identifier)
        
        searchTableView.tableFooterView = UIView(frame: .zero)
        
        viewModel.delegate = self
    }

}

//MARK: Table View

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering() ? 1 : viewModel.orderedCities.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cities = getCities(for: section)
        
        return isFiltering() ? viewModel.filteredCities.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
    
        let cities = isFiltering() ? viewModel.filteredCities : getCities(for: indexPath.section)
        
        let city = cities[indexPath.row]
        
        cell.configure(with: city)
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cities = isFiltering() ? viewModel.filteredCities : getCities(for: indexPath.section)
        let city = cities[indexPath.row]
        viewModel.currentCity = city
        
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        mapVC.viewModel = viewModel
        
        self.navigationItem.searchController?.dismiss(animated: true, completion: nil)
        self.navigationController?.pushViewController(mapVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = viewModel.orderedCities.keys.sorted(by: {$0 < $1})
        return isFiltering() ? nil : keys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let keys = viewModel.orderedCities.keys.sorted(by: {$0 < $1})
        return isFiltering() ? nil : keys
    }
    
}

//MARK: ViewModelDelegate

extension SearchViewController: ViewModelDelegate {
    
    func updateView() {
        print("Main: \(Thread.isMainThread)")
        searchTableView.reloadData()
    }
}

//MARK: Search Bar Delgate

extension SearchViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let search = searchController.searchBar.text else {
            return
        }
        
        filterCities(by: search)
        
    }
}
