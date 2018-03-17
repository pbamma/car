//
//  VehicleModel.swift
//  CarApp
//
//  Created by Philip Starner on 3/15/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//
//  Return a list of rentals Based on an
//    - address
//    - pickup date
//    - drop-off date
//
//  This list should be sortable by (ascending and descending order)
//     - company
//     - distance
//     - price
//

import Foundation

public struct VehicleModel {
    //dealer info
    public var address: Address?
    public var location: Location?
    public var distance: String?
    public var provider: Provider?
    
    public var price: Double = 0
    public var companyName: String = ""
    public var distanceVal: Double = 0.0
    public var type: String = "24door"
    
    //vehicle info
    public var vehicleInfo: VehicleInfo?
    public var estimatedTotal: EstimatedTotal?
}

