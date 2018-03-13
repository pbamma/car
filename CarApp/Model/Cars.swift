//
//  Cars.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Cars {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let rates = "rates"
    static let vehicleInfo = "vehicle_info"
    static let estimatedTotal = "estimated_total"
  }

  // MARK: Properties
  public var rates: [Rates]?
  public var vehicleInfo: VehicleInfo?
  public var estimatedTotal: EstimatedTotal?

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
    if let items = json[SerializationKeys.rates].array { rates = items.map { Rates(json: $0) } }
    vehicleInfo = VehicleInfo(json: json[SerializationKeys.vehicleInfo])
    estimatedTotal = EstimatedTotal(json: json[SerializationKeys.estimatedTotal])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = rates { dictionary[SerializationKeys.rates] = value.map { $0.dictionaryRepresentation() } }
    if let value = vehicleInfo { dictionary[SerializationKeys.vehicleInfo] = value.dictionaryRepresentation() }
    if let value = estimatedTotal { dictionary[SerializationKeys.estimatedTotal] = value.dictionaryRepresentation() }
    return dictionary
  }

}
