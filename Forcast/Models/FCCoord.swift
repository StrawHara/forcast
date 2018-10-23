//
//  FCCoord.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCCoord: Object, Decodable {
  
  @objc dynamic var identifier: String = ""

  @objc dynamic var lon: Double = 0.0
  @objc dynamic var lat: Double = 0.0

  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case lon = "lon"
    case lat = "lat"
  }
  
  convenience init(identifier: String, lon: Double, lat: Double) {
    self.init()
    self.identifier = identifier
    self.lon = lon
    self.lat = lat
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let lon = try container.decode(Double.self, forKey: .lon)
    let lat = try container.decode(Double.self, forKey: .lat)

    self.init(identifier: identifier, lon: lon, lat: lat)
  }
  
  required init() {
    super.init()
  }
  
  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
  
  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }
  
}
