//
//  FCClouds.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCClouds: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  
  @objc dynamic var all: Int = 0
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case all = "all"
  }
  
  convenience init(identifier: String, all: Int) {
    self.init()
    self.identifier = identifier
    self.all = all
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let all = try container.decode(Int.self, forKey: .all)
    
    self.init(identifier: identifier, all: all)
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
