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
import MapKit

class SearchViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    
    var vehicleModels:[VehicleModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearchBarView()
        
        //no loading screen nav
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        
        self.startLocating()
        
        //start an early load based on current location
        if let lat = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LATITUDE) as? Double, let long = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LONGITUDE) as? Double {
            let today = Date()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)

            APIManager.sharedInstance.getCarSearchCircle(lat: lat, long: long, pickup: Utils.yearMonthDay(date: today), dropoff: Utils.yearMonthDay(date: tomorrow!), radius: "25") { (vehicleModels: [VehicleModel]?, error: Error?) in
                if let vehicleModels = vehicleModels {
                    self.vehicleModels = vehicleModels
                    self.tableView.reloadData()
                }
            }
        }
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
        var totalCars = 0
        if let models = self.vehicleModels {
            totalCars = models.count
        }
        return totalCars
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        

        cell.type.text = self.vehicleModels![indexPath.item].vehicleInfo?.type
        cell.agency.text = self.vehicleModels![indexPath.item].provider?.companyName
        if let amount = self.vehicleModels?[indexPath.item].estimatedTotal?.amount {
            cell.estimate.text = "$" + amount
        }
        cell.distance.text = self.vehicleModels![indexPath.item].distance

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
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
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

//MARK: CLLocationManagerDelegate methods
extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        self.currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        if let location = location {
            UserDefaults.standard.set(location.coordinate.latitude, forKey: Constants.USER_DEFAULT_LATITUDE)
            UserDefaults.standard.set(location.coordinate.longitude, forKey: Constants.USER_DEFAULT_LONGITUDE)
        }
    }
    
    func startLocating() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            //Save Battery!  our location accuracy doesn't have to be all that accurate.
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
}
