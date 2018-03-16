//
//  DetailViewController.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var showMapButton: UIButton!
    @IBOutlet weak var hideMapButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var airConditioning: UILabel!
    @IBOutlet weak var fuelType: UILabel!
    
    @IBOutlet weak var agency: UILabel!
    @IBOutlet weak var pickup: UILabel!
    @IBOutlet weak var dropoff: UILabel!
    @IBOutlet weak var estimatedCost: UILabel!
    
    var vehicleModel:VehicleModel?
    var selectedPickupDate:Date?
    var selectedDropoffDate:Date?
    
    //constraints
    @IBOutlet weak var constraintMapContainerTop: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    var initialRegion: MKCoordinateRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let vehicleModel = vehicleModel {
            self.category.text = vehicleModel.vehicleInfo?.category
            self.type.text = vehicleModel.vehicleInfo?.type
            if let ac = vehicleModel.vehicleInfo?.airConditioning {
                self.airConditioning.text = (ac) ? "Yes" : "No"
            }
            self.fuelType.text = vehicleModel.vehicleInfo?.fuel
            self.agency.text = vehicleModel.provider?.companyName
            if let amount = vehicleModel.estimatedTotal?.amount {
                self.estimatedCost.text = "$\(amount)"
            } else {
                self.estimatedCost.text = "-"
            }
            
        }
        
        if let pickup = self.selectedPickupDate {
            self.pickup.text = Utils.monthDay(date: pickup)
        }
        
        if let dropoff = self.selectedDropoffDate {
            self.dropoff.text = Utils.monthDay(date: dropoff)
        }
        
        self.startLocating()
    }
    
    func startLocating() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNavigateUp(_ sender: AnyObject) {
        
        self.navigationController?.isNavigationBarHidden = true
        self.constraintMapContainerTop.constant = self.view.frame.size.height
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.showMapButton.alpha = 0
            self.hideMapButton.alpha = 1
        }) { (Bool) -> Void in
        }
        
        
    }
    
    @IBAction func onNavigateDown(_ sender: AnyObject) {
        self.navigationController?.isNavigationBarHidden = false
        self.constraintMapContainerTop.constant = 62
        
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
            self.showMapButton.alpha = 1
            self.hideMapButton.alpha = 0
        }) { (Bool) -> Void in
        }
    }

}

extension DetailViewController: MKMapViewDelegate {
    //MARK: mapviewdelagate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "annID"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pin")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //print("pin tapped")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let vAnnotation = view.annotation as! MKVehiclePointAnnotation
        
        self.launchMapNavigation(vehicle: vAnnotation.vehicle)
    }
    
    func launchMapNavigation(vehicle: VehicleModel?) {
        if let vehicle = vehicle {
            let latitude:CLLocationDegrees = CLLocationDegrees(vehicle.location!.latitude!)
            let longitude: CLLocationDegrees = CLLocationDegrees(vehicle.location!.longitude!)
            let regiondistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionspan  = MKCoordinateRegionMakeWithDistance(coordinates, regiondistance, regiondistance)
            let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate:regionspan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan:regionspan.span)]
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapitem = MKMapItem(placemark: placemark)
            mapitem.name = vehicle.provider?.companyName
            mapitem.openInMaps(launchOptions: options)
        }
        
    }
    
    func addPinToMapView(vehicle: VehicleModel, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKVehiclePointAnnotation()
        annotation.vehicle = vehicle
        annotation.title = vehicle.provider?.companyName
        annotation.subtitle = vehicle.address?.line1
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}

extension DetailViewController: CLLocationManagerDelegate {
    //MARK: locationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        self.currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        if self.initialRegion == nil {
            self.initialRegion = MKCoordinateRegion(center: self.currentLocation!, span: MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4))
            self.mapView.setRegion(self.initialRegion!, animated: true)
            
//            let reverse = CLGeocoder()
//            reverse.reverseGeocodeLocation(location!) { (placemarks: [CLPlacemark]?, error: Error?) in
//                if let pmarks = placemarks, pmarks.count > 0 {
//                    //self.currentZip = pmarks[0].postalCode
//
//                    //now that we've got a zip we can make a call to API
//
//                    if let vehicleModel = self.vehicleModel {
//                        self.addPinToMapView(vehicle: vehicleModel, latitude: CLLocationDegrees(vehicleModel.location!.latitude!), longitude: CLLocationDegrees(vehicleModel.location!.longitude!))
//                    }
//
//                }
//            }
            
            if let vehicleModel = self.vehicleModel {
                self.addPinToMapView(vehicle: vehicleModel, latitude: CLLocationDegrees(vehicleModel.location!.latitude!), longitude: CLLocationDegrees(vehicleModel.location!.longitude!))
            }
        }
    }
}
