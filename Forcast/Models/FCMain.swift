//
//  FCMain.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCMain: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  
  @objc dynamic var temp: Double = 0.0
  @objc dynamic var pressure: Double = 0.0
  @objc dynamic var humidity: Int = 0
  @objc dynamic var tempMin: Double = 0.0
  @objc dynamic var tempMax: Double = 0.0

  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case temp = "temp"
    case pressure = "pressure"
    case humidity = "humidity"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
  }
  
  convenience init(identifier: String, temp: Double, pressure: Double,
                   humidity: Int, tempMin: Double, tempMax: Double) {
    self.init()
    self.identifier = identifier
    self.temp = temp
    self.pressure = pressure
    self.humidity = humidity
    self.tempMin = tempMin
    self.tempMax = tempMax
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let temp = try container.decode(Double.self, forKey: .temp)
    let pressure = try container.decode(Double.self, forKey: .pressure)
    let humidity = try container.decode(Int.self, forKey: .humidity)
    let tempMin = try container.decode(Double.self, forKey: .tempMin)
    let tempMax = try container.decode(Double.self, forKey: .tempMax)

    self.init(identifier: identifier, temp: temp, pressure: pressure,
              humidity: humidity, tempMin: tempMin, tempMax: tempMax)
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
