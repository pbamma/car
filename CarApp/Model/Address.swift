//
//  Address.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Address {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let postalCode = "postal_code"
    static let city = "city"
    static let line1 = "line1"
    static let region = "region"
    static let country = "country"
  }

  // MARK: Properties
  public var postalCode: String?
  public var city: String?
  public var line1: String?
  public var region: String?
  public var country: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    postalCode = json[SerializationKeys.postalCode].string
    city = json[SerializationKeys.city].string
    line1 = json[SerializationKeys.line1].string
    region = json[SerializationKeys.region].string
    country = json[SerializationKeys.country].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = postalCode { dictionary[SerializationKeys.postalCode] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = line1 { dictionary[SerializationKeys.line1] = value }
    if let value = region { dictionary[SerializationKeys.region] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

}
