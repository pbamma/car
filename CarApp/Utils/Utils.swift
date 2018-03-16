//
//  Utils.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//
import UIKit
import CoreLocation



class Utils {
    static func prettyJSONStringConversion(dict: [String: Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            let dataString = String(data: jsonData,encoding: String.Encoding.utf8)!
            return dataString
        } catch {
            print(error.localizedDescription)
            return "Could not parse JSON"
        }
    }
    
    static func prettyJSONStringConversion(data: Data) -> String {
        if let dataString = String(data: data,encoding: String.Encoding.utf8){
            return dataString
        } else {
            return "Could not parse JSON"
        }
    }
    
    static func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat(Double.pi) / 180
    }
    
    static func yearMonthDay(date: Date) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    static func monthDay(date: Date) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MMM-dd"
        return formatter.string(from: date)
    }
    
    static func getDistance(coordinate1: CLLocation?, coordinate2: CLLocation?) -> Double {
        var retVal = 0.0
        
        if let coordinate1 = coordinate1, let coordinate2 = coordinate2 {
            let distanceInMeters = coordinate1.distance(from: coordinate2)
            let miles = distanceInMeters * 0.000621371192
            retVal = Double(round(100*miles)/100)
        }
        
        return retVal
    }
    
    static func getTypeString(type: String?) -> String {
        var retVal = "24door"
        if let type = type {
            let charSet = CharacterSet.init(charactersIn: "/- ")
            retVal = String(type.components(separatedBy: charSet).joined()).lowercased()
        }
        return retVal
    }
}
