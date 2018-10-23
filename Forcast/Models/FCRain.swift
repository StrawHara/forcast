//
//  FCRain.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCRain: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  
  @objc dynamic var mlPer3H: Double = 0.0
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case mlPer3H = "3h"
  }
  
  convenience init(identifier: String, mlPer3H: Double) {
    self.init()
    self.identifier = identifier
    self.mlPer3H = mlPer3H
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let mlPer3H = try container.decode(Double.self, forKey: .mlPer3H)
    
    self.init(identifier: identifier, mlPer3H: mlPer3H)
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
