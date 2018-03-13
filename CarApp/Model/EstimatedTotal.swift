//
//  EstimatedTotal.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct EstimatedTotal {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let currency = "currency"
    static let amount = "amount"
  }

  // MARK: Properties
  public var currency: String?
  public var amount: String?

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
    currency = json[SerializationKeys.currency].string
    amount = json[SerializationKeys.amount].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = currency { dictionary[SerializationKeys.currency] = value }
    if let value = amount { dictionary[SerializationKeys.amount] = value }
    return dictionary
  }

}
