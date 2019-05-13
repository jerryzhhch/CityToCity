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
    
    //MARK: Search Functionality
    func setupSearch() {
        
        searchController.definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities..."
        searchController.searchBar.delegate = self
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
        let city = viewModel.cities[indexPath.row]
        cell.configure(with: city)
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //TODO: Filter Data
        print("Search Button Clicked")
    }
}
