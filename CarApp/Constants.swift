//
//  Constants.swift
//  CarApp
//
//  Created by Philip Starner on 3/9/18.
//  Copyright © 2018 Philip Starner. All rights reserved.
//

import Foundation
import UIKit


class Constants: NSObject {
    //constant colors used in app
    static let COLOR_ORANGE = UIColor(red: 232/255.0, green: 94/255.0, blue: 2/255.0, alpha: 1.0)
    static let COLOR_LIGHT_ORANGE = UIColor(red: 251/255.0, green: 159/255.0, blue: 2/255.0, alpha: 1.0)
    
    // host urls
    static let Host = "http://api.sandbox.amadeus.com/v1.2/cars/"
    static let APIKey = "8ziGGBD5UYagqCGpPGKAk0tCg7BHpnhg"
    
    //Authorization: Bearer <YOUR API KEY>
    static let headers = [
        "Authorization": "Bearer \(Constants.APIKey)",
    ]
    
    static let USER_DEFAULT_LATITUDE = "USER_DEFAULT_LATITUDE"
    static let USER_DEFAULT_LONGITUDE = "USER_DEFAULT_LONGITUDE"
    //Fair headquarters 34.012219,-118.494540
    static let LATITUDE_DEFAULT = 34.012219
    static let LONGITUDE_DEFAULT = -118.494540
    
    
    //MARK: - device structs
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1024.0
    }
}

