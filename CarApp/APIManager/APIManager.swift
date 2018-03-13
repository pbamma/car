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
//    /// GET https://sandbox.amadeus.com/
//    /// :param: term - a search term like 'pizza' or 'starbucks'.
//    /// :param: lat, long - a location on earth to search around.
//    /// :param: callback: onCompletion 'Businesses' data.
//    func getSearch(term:String, lat: Double, long: Double, onCompletion: ((_ businesses: [Business]?, _ error: Error?) -> Void)?) {
//        //format the term to work in the request string (no spaces!)
//        if let escapedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
//            let requestString = (Constants.YelpHost + "businesses/search" + "?term=\(escapedTerm)" + "&latitude=\(lat)" + "&longitude=\(long)")
//            
//            Alamofire.request(requestString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.headers).responseJSON { (response) in
//                
//                if let data = response.data {
//                    do {
//                        let json = try JSON.init(data: data)
//                        
//                        let search = Search(json: json)
//                        
//                        //update the coreData
//                        DatabaseManager.sharedInstance.createOrUpdateSearchTerm(id: term, lat: lat, long: long, business: search.businesses!)
//                        
//                        //make callback
//                        onCompletion!(search.businesses, nil)
//                        
//                    } catch {
//                        print("Error: \(error.localizedDescription)")
//                        onCompletion!(nil, error)
//                    }
//                } else {
//                    print("Error: response data no good)")
//                    onCompletion!(nil, nil)
//                }
//            }
//        } else {
//            print("Error: text escaping failed)")
//            onCompletion!(nil, nil)
//        }
//        
//    }
    
}
