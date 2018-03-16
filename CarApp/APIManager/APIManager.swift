//
//  APIManager.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CoreLocation

class APIManager {
    
    //Singleton class to speak to whenever and whereever we need
    static var sharedInstance = APIManager()
    
//    /// get a list of businesses
    //    /// GET http://api.sandbox.amadeus.com/v1.2/cars/search-circle?pick_up=2015-11-22&drop_off=2015-11-23&latitude=37.721278&longitude=-122.220722&radius=25&apikey=<your API key>

//    /// :param: location - an airport code.
//    /// :param: pickup, dropoff - picup and dropoff dates.
//    /// :param: callback: onCompletion 'vehicleModel' data.
    func getCarSearchCircle(lat: Double, long: Double, pickup: String, dropoff: String, radius: String, onCompletion: ((_ vehicleModels: [VehicleModel]?, _ error: Error?) -> Void)?) {
        let requestString = (Constants.Host + "search-circle" + "?pick_up=\(pickup)" + "&drop_off=\(dropoff)" + "&latitude=\(lat)" + "&longitude=\(long)" + "&radius=\(radius)" +  "&apikey=\(Constants.APIKey)")
        print("request: \(requestString)")
        
        Alamofire.request(requestString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.headers).responseJSON { (response) in
            
            if let data = response.data {
                let json =  JSON.init(data: data)
                print(Utils.prettyJSONStringConversion(data: data))
                let carData = CarData.init(json: json)
                
                //build VehicleModels
                var models: [VehicleModel]?
                if let results = carData.results {
                    models = [VehicleModel]()
                    for result in results {
                        
                        if let cars = result.cars {
                            for car in cars {
                                var model = VehicleModel()
                                
                                model.address = result.address
                                model.location = result.location
                                // find the distance
                                if let lat2 = result.location?.latitude,
                                    let long2 = result.location?.longitude,
                                    let lat1 = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LATITUDE) as? Double,
                                    let long1 = UserDefaults.standard.value(forKey: Constants.USER_DEFAULT_LONGITUDE) as? Double {
                                    let location1 = CLLocation(latitude: lat1, longitude: long1)
                                    let location2 = CLLocation(latitude: Double(lat2), longitude: Double(long2))
                                    let dist = Utils.getDistance(coordinate1: location1, coordinate2: location2)
                                    model.distance = "\(dist) miles"
                                    
                                    //sorting needs
                                    model.distanceVal = dist
                                    if let amount = car.estimatedTotal?.amount {
                                        if let dub = Double(amount) {
                                            model.price = dub
                                        }
                                    }
                                    if let name = result.provider?.companyName {
                                        model.companyName = name
                                    }
                                }
                                
                                model.provider = result.provider
                                
                                model.vehicleInfo = car.vehicleInfo
                                model.estimatedTotal = car.estimatedTotal
                                
                                
                                
                                models?.append(model)
                            }
                        }
                    }
                }
                
                //make callback
                onCompletion!(models, nil)
            } else {
                print("Error: response data no good)")
                onCompletion!(nil, nil)
            }
        }
        
        
    }
    
}
