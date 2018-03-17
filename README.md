[![Watch the video](http://recordit.co/VOUrSjGPt8)](http://recordit.co/VOUrSjGPt8)

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
* image data is local as the API did not offer ACRISS related images

# Review Testing
* The map uses pins which can be tapped an then navigated to through Apple Maps externally.
* The API claims to return image references but it does not.  I've got to roll-my-own images using acriss code type field.

# Bonus points
* For anything that you think would make your demo stand out, i.e. non-traditional navigation methods, cool presentation / animation styles

# Dev Notes
* SwiftyJSON is old school.  Could use a Swift4 Codable facelift
* more and better Unit Tests!!!
* WARNING: images in this project are from the internet and not to be distributed into real world app!
* there is an outstanding map related warning "Could not inset compass from edges 9" I believe it's related to autolayout somehow.


