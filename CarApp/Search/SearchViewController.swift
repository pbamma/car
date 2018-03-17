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
import RangeSeekSlider

class SearchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    
    var vehicleModels:[VehicleModel]?
    var selectedVehicleModel:VehicleModel?
    
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    var selectedPickupDate:Date?
    var selectedDropoffDate:Date?
    
    @IBOutlet weak var sortHighLowButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    enum Sort : String {
        case Distance = "distance", Price = "price", Company = "company"
    }
    var currentSort = Sort.Distance
    var isAscending = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //no loading screen nav
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        
        self.setupSortButtons()
        self.setupSlider()
        
        self.startLocating()
        
        //start an early load based on current location
        self.getNewData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let dst = segue.destination as! DetailViewController
            dst.vehicleModel = self.selectedVehicleModel
            dst.selectedPickupDate = self.selectedPickupDate
            dst.selectedDropoffDate = self.selectedDropoffDate
        }
     }
    
    func setupSortButtons() {
        sortButton.layer.borderColor = Constants.COLOR_ORANGE.cgColor
        sortButton.layer.cornerRadius = 6
        sortButton.layer.borderWidth = 2
        
        sortHighLowButton.layer.borderColor = Constants.COLOR_ORANGE.cgColor
        sortHighLowButton.layer.cornerRadius = 6
        sortHighLowButton.layer.borderWidth = 2
    }
    
    func setupSlider() {
        
        rangeSlider.delegate = self
        
        if let font = UIFont(name: "HelveticaNeue-Medium", size: 16) {
            rangeSlider.minLabelFont = font
            rangeSlider.maxLabelFont = font
        }
        
        self.selectedPickupDate = Date()
        if let inAWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date()) {
            self.selectedDropoffDate = inAWeek
        } else {
            self.selectedDropoffDate = Date()
        }
    }
    
    func getNewData() {
        self.vehicleModels = nil
        self.tableView.reloadData()
        if let lat = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LATITUDE) as? Double, let long = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LONGITUDE) as? Double {
            if let pickup = self.selectedPickupDate, let dropoff = self.selectedDropoffDate {
                APIManager.sharedInstance.getCarSearchCircle(lat: lat, long: long, pickup: Utils.yearMonthDay(date: pickup), dropoff: Utils.yearMonthDay(date: dropoff), radius: "25") { (vehicleModels: [VehicleModel]?, error: Error?) in
                    if let vehicleModels = vehicleModels {
                        self.vehicleModels = vehicleModels
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func onHighLowSort(_ sender: Any) {
         if let title = sortHighLowButton.currentTitle {
            if title == "lowest" {
                sortHighLowButton.setTitle("highest", for: .normal)
                self.isAscending = true
            } else {
                sortHighLowButton.setTitle("lowest", for: .normal)
                self.isAscending = false
            }
        }
        
        if let title = sortButton.currentTitle {
            if title == Sort.Distance.rawValue {
                sortByDistance(ascending: isAscending)
            } else if title == Sort.Company.rawValue {
                sortByCompany(ascending: isAscending)
            } else if title == Sort.Price.rawValue {
                sortByPrice(ascending: isAscending)
            }
        }
    }
    
    @IBAction func onSort(_ sender: Any) {
        if let title = sortButton.currentTitle {
            if title == Sort.Distance.rawValue {
                sortByCompany(ascending: isAscending)
                sortButton.setTitle(Sort.Company.rawValue, for: .normal)
            } else if title == Sort.Company.rawValue {
                sortByPrice(ascending: isAscending)
                sortButton.setTitle(Sort.Price.rawValue, for: .normal)
            } else if title == Sort.Price.rawValue {
                sortByDistance(ascending: isAscending)
                sortButton.setTitle(Sort.Distance.rawValue, for: .normal)
            }
        }
    }
    
    func sortByPrice(ascending: Bool) {
        if let vehicles = self.vehicleModels {
            if ascending {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.price > rhs.price }
            } else {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.price < rhs.price }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func sortByCompany(ascending: Bool) {
        if let vehicles = self.vehicleModels {
            if ascending {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.companyName > rhs.companyName }
            } else {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.companyName < rhs.companyName }
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    func sortByDistance(ascending: Bool) {
        if let vehicles = self.vehicleModels {
            if ascending {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.distanceVal > rhs.distanceVal }
            } else {
                self.vehicleModels = vehicles.sorted { (lhs, rhs) in return lhs.distanceVal < rhs.distanceVal }
            }
            
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: RangeSeekSliderDelegate {
    func didEndTouches(in slider: RangeSeekSlider) {
        self.getNewData()
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        let today = Date()
        if let date = Calendar.current.date(byAdding: .day, value: Int(minValue), to: today) {
            self.selectedPickupDate = date
            return Utils.monthDay(date: date)
        } else {
            return "-"
        }
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        let today = Date()
        if let date = Calendar.current.date(byAdding: .day, value: Int(maxValue), to: today) {
            self.selectedDropoffDate = date
            return Utils.monthDay(date: date)
        } else {
            return "-"
        }
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
        
        cell.imageThumb.image = UIImage(named: self.vehicleModels![indexPath.item].type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVehicleModel = self.vehicleModels?[indexPath.item]
        self.performSegue(withIdentifier: "segueToDetail", sender: self)
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
