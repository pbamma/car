//
//  APIManager.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIManager {
    
    //Singleton class to speak to whenever and whereever we need
    static var sharedInstance = APIManager()
    
//    /// get a list of businesses
    //    /// GET http://api.sandbox.amadeus.com/v1.2/cars/search-circle?pick_up=2015-11-22&drop_off=2015-11-23&latitude=37.721278&longitude=-122.220722&radius=25&apikey=<your API key>

//    /// :param: location - an airport code.
//    /// :param: pickup, dropoff - picup and dropoff dates.
//    /// :param: callback: onCompletion 'car search' data.
    func getCarSearchCircle(lat: Double, long: Double, pickup: String, dropoff: String, radius: String, onCompletion: ((_ data: CarData?, _ error: Error?) -> Void)?) {
        let requestString = (Constants.Host + "search-circle" + "?pick_up=\(pickup)" + "&drop_off=\(dropoff)" + "&latitude=\(lat)" + "&longitude=\(long)" + "&radius=\(radius)" + "&apikey=\(Constants.APIKey)")
        
        Alamofire.request(requestString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.headers).responseJSON { (response) in
            
            if let data = response.data {
                    let json =  JSON.init(data: data)
                    //print(Utils.prettyJSONStringConversion(data: data))
                    let carData = CarData.init(json: json)
                    //make callback
                    onCompletion!(carData, nil)
            } else {
                print("Error: response data no good)")
                onCompletion!(nil, nil)
            }
        }
        
        
    }
    
}
