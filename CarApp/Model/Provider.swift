//
//  Provider.swift
//
//  Created by Philip Starner on 3/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Provider {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let companyCode = "company_code"
    static let companyName = "company_name"
  }

  // MARK: Properties
  public var companyCode: String?
  public var companyName: String?

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
    companyCode = json[SerializationKeys.companyCode].string
    companyName = json[SerializationKeys.companyName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = companyCode { dictionary[SerializationKeys.companyCode] = value }
    if let value = companyName { dictionary[SerializationKeys.companyName] = value }
    return dictionary
  }

}
