//
//  FCCity.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCCity: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var coord: FCCoord?
  
  @objc dynamic var weather: FCWeather?
  
  @objc dynamic var forecast: [FCWeather]?
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case name = "name"
    case coord = "coord"
  }
  
  convenience init(identifier: String, name: String, coord: FCCoord) {
    self.init()
    self.identifier = identifier
    self.name = name
    self.coord = coord
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  try container.decode(String.self, forKey: .identifier)
    let name = try container.decode(String.self, forKey: .name)
    let coord = try container.decode(FCCoord.self, forKey: .coord)
    
    self.init(identifier: identifier, name: name, coord: coord)
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
