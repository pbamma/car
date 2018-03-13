//
//  Results.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Results {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let branchId = "branch_id"
    static let location = "location"
    static let airport = "airport"
    static let provider = "provider"
    static let cars = "cars"
    static let address = "address"
  }

  // MARK: Properties
  public var branchId: String?
  public var location: Location?
  public var airport: String?
  public var provider: Provider?
  public var cars: [Cars]?
  public var address: Address?

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
    branchId = json[SerializationKeys.branchId].string
    location = Location(json: json[SerializationKeys.location])
    airport = json[SerializationKeys.airport].string
    provider = Provider(json: json[SerializationKeys.provider])
    if let items = json[SerializationKeys.cars].array { cars = items.map { Cars(json: $0) } }
    address = Address(json: json[SerializationKeys.address])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = branchId { dictionary[SerializationKeys.branchId] = value }
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    if let value = airport { dictionary[SerializationKeys.airport] = value }
    if let value = provider { dictionary[SerializationKeys.provider] = value.dictionaryRepresentation() }
    if let value = cars { dictionary[SerializationKeys.cars] = value.map { $0.dictionaryRepresentation() } }
    if let value = address { dictionary[SerializationKeys.address] = value.dictionaryRepresentation() }
    return dictionary
  }

}
