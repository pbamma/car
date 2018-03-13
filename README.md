# iOS Take Home Excercise

* Create a rental shopping app using Swift for iOS or Java/Kotlin for Android

The app should have the following functionality:

* Finding a car
* Based on an address, pickup date, and drop-off date return a list of rentals. This list should be sortable by company, distance, and price (ascending and descending order)
* Upon user selection provide rental details
* Directions to pickup the rental
* There should be a call to action showing user's the nearest pickup location and directions on how to get there.
* Make the app look as appealing as possible to use

* **Bonus** - See Bonus points.

---------------------------------------------------------------------------------

# Major functions
* CoreLocation to get user current possition (stored in UserDefaults)
* AlamoFire to retrieve JSON data from API

# Architecture
* MVC-N (Modle-View-Controller-Network)
* RESTful with test backend
* Capabilities - Maps + CoreLocation

# Requirements
* iOS 11.0+
* Xcode 9.2+
* Swift 4.0+

# Data Source
* https://sandbox.amadeus.com/
* 8ziGGBD5UYagqCGpPGKAk0tCg7BHpnhg


# Review Testing
-

# Bonus points
* For anything that you think would make your demo stand out, i.e. non-traditional navigation methods, cool presentation / animation styles

# Dev Notes
* SwiftyJSON is old school.  Could use a Swift4 Codable facelift
* an image cache management system would be really cool.  SDWebImage is outdated and currently not customized to our special needs.
* more and better Unit Tests!!!


