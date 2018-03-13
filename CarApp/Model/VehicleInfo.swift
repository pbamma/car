//
//  VehicleInfo.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct VehicleInfo {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let acrissCode = "acriss_code"
    static let transmission = "transmission"
    static let type = "type"
    static let fuel = "fuel"
    static let category = "category"
    static let airConditioning = "air_conditioning"
  }

  // MARK: Properties
  public var acrissCode: String?
  public var transmission: String?
  public var type: String?
  public var fuel: String?
  public var category: String?
  public var airConditioning: Bool? = false

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
    acrissCode = json[SerializationKeys.acrissCode].string
    transmission = json[SerializationKeys.transmission].string
    type = json[SerializationKeys.type].string
    fuel = json[SerializationKeys.fuel].string
    category = json[SerializationKeys.category].string
    airConditioning = json[SerializationKeys.airConditioning].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = acrissCode { dictionary[SerializationKeys.acrissCode] = value }
    if let value = transmission { dictionary[SerializationKeys.transmission] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = fuel { dictionary[SerializationKeys.fuel] = value }
    if let value = category { dictionary[SerializationKeys.category] = value }
    dictionary[SerializationKeys.airConditioning] = airConditioning
    return dictionary
  }

}
