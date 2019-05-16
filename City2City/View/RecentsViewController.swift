//
//  RecentsViewController.swift
//  City2City
//
//  Created by mac on 5/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController {
    
    @IBOutlet weak var recentsTableView: UITableView!
    

    let coreViewModel = CoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecents()
        createObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coreViewModel.get()
    }
    
    
    
    //MARK: Observer
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: Notification.Name.CoreNotification, object: nil)
    }
    
    @objc func updateView() {
        recentsTableView.reloadData()
    }

    //MARK: Setup
    
    func setupRecents() {
        recentsTableView.register(UINib(nibName: CityTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityTableCell.identifier)
        recentsTableView.tableFooterView = UIView(frame: .zero)
        title = "Recent Cities"
    }

}

extension RecentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreViewModel.coreCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
        let coreCity = coreViewModel.coreCities[indexPath.row]
        let city = City(with: coreCity)
        cell.configure(with: city)
        
        return cell
    }
}

extension RecentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO: Go To Maps
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            let city = coreViewModel.coreCities[indexPath.row]
            coreManager.delete(with: city)
            coreViewModel.coreCities.remove(at: indexPath.row)
        
        default:
            break
        }
    }
    
}
