//
//  JSONSerializer.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift

final class JSONSerializer {
  
  func serialize(input data: Data?) {
    
    guard let data = data else {
      log.error("Unbale to unwrap data")
      return
    }
    
    let jsonDecoder = JSONDecoder()
    do {
      
      guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        return
      }
      
      do {
        
        let citiesData = try JSONSerialization.data(withJSONObject: json["list"] ?? [], options: [])
        
        let cities = try jsonDecoder.decode([FCCity].self, from: citiesData)
        let weathers = try jsonDecoder.decode([FCWeather].self, from: citiesData)
        
        for (iterator, weather) in weathers.enumerated() {
          cities[iterator].weather = weather
        }
        
        let realm = Realm.safeInstance()
        
        try realm.write {
          realm.add(cities, update: true)
        }
      } catch {
        log.error("failed to convert data")
      }
    } catch let error {
      log.error(error)
    }
  }
  
}
