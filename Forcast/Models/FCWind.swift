//
//  FCWind.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCWind: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  
  @objc dynamic var speed: Double = 0
  @objc dynamic var deg: Int = 0
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case speed = "speed"
    case deg = "deg"
  }
  
  convenience init(identifier: String, speed: Double, deg: Int) {
    self.init()
    self.identifier = identifier
    self.speed = speed
    self.deg = deg
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let speed = try container.decode(Double.self, forKey: .speed)
    let deg = try container.decode(Int.self, forKey: .deg)
    
    self.init(identifier: identifier, speed: speed, deg: deg)
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
