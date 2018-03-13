//
//  SearchViewController.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isFiltered:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearchBarView()
        
        //no loading screen nav
        self.navigationItem.hidesBackButton = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupSearchBarView() {
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.backgroundImage = UIImage()
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let filtVehicles = self.filteredVehicles, isFiltered {
//            return filtVehicles.count
//        }
//        if let vList = self.vehicleList?.vehicles {
//            return vList.count
//        }
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
    
        
//        if let vList = self.vehicleList.vehicles {
//            var theVehicles:[VehicleListItem]
//            if(isFiltered) {
//                theVehicles = self.filteredVehicles!
//            } else {
//                theVehicles = vList
//            }
//
//
            cell.make.text = "test"
            cell.model.text = "test"
            cell.information.text = "test"
//
//            //get the image
//
//            if let thumbURL = URL.init(string: theVehicles[indexPath.item].thumb!) {
//                let thumbRequest = URLRequest.init(url: thumbURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
//
//                cell.imageThumb.setImageWith(thumbRequest as URLRequest, placeholderImage: UIImage.init(named: ""), success: { (request: URLRequest, response: HTTPURLResponse?, image: UIImage) in
//
//                    cell.imageThumb.image = image
//                    cell.setNeedsLayout()
//                }) { (request: URLRequest, response: HTTPURLResponse?, error: Error) in
//                    //do nothing
//                }
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vList = self.vehicleList.vehicles {
//            var theVehicles:[VehicleListItem]
//            if(isFiltered) {
//                theVehicles = self.filteredVehicles!
//            } else {
//                theVehicles = vList
//            }
        
            let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            viewController.make = theVehicles[indexPath.item].make
//            viewController.model = theVehicles[indexPath.item].model
//            viewController.year = theVehicles[indexPath.item].year
//            viewController.styleID = theVehicles[indexPath.item].styleID
            
            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        if let vList = vehicleList.vehicles, vList.count > 0 {
        //            if searchText == "" {
        //                self.isFiltered = false
        //            } else {
        //                self.isFiltered = true
        //                self.filteredVehicles = [VehicleListItem]()
        //
        //                for i in 0..<vList.count {
        //                    let vListItem = vList[i]
        //
        //                    if vListItem.searchString.hasPrefix(searchText) {
        //                        self.filteredVehicles?.append(vListItem)
        //                    }
        //
        //                }
        //            }
        //        }
        //
        //        self.tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

