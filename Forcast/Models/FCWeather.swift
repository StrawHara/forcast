//
//  FCWeather.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCWeather: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  @objc dynamic var dateTime: Int = 0

  @objc dynamic var main: FCMain?
  @objc dynamic var wind: FCWind?
  @objc dynamic var rain: FCRain?
  @objc dynamic var clouds: FCClouds?
  @objc dynamic var analysis: FCAnalysis?

  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case dateTime = "dt"
    case main = "main"
    case wind = "wind"
    case rain = "rain"
    case clouds = "clouds"
    case analysis = "weather"
  }
  
  convenience init(identifier: String, dateTime: Int, main: FCMain?,
                   wind: FCWind?, rain: FCRain?, clouds: FCClouds?,
                   analysis: FCAnalysis?) {
    self.init()
    self.identifier = identifier
    self.dateTime = dateTime
    self.main = main
    self.wind = wind
    self.rain = rain
    self.clouds = clouds
    self.analysis = analysis
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let dateTime = try container.decode(Int.self, forKey: .dateTime)
    let main = try? container.decode(FCMain.self, forKey: .main)
    let wind = try? container.decode(FCWind.self, forKey: .wind)
    let rain = try? container.decode(FCRain.self, forKey: .rain)
    let clouds = try? container.decode(FCClouds.self, forKey: .clouds)
    let analysis = try? container.decode([FCAnalysis].self, forKey: .analysis)

    self.init(identifier: identifier, dateTime: dateTime, main: main,
              wind: wind, rain: rain, clouds: clouds,
              analysis: analysis?.first)
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
