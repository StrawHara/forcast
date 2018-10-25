//
//  JSONSerializer.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift

enum SourceType {
  case city
  case forecast(cityID: String)
}

final class JSONSerializer {
  
  func serialize(input data: Data?, sourceType: SourceType) {
    
    guard let data = data else {
      log.error("Unbale to unwrap data")
      return
    }
    
    do {
      guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        return
      }
      
      switch sourceType {
      case .city:
        self.citySerializer(json: json)
      case .forecast(let cityID):
        self.forecastSerializer(json: json, cityID: cityID)
      }
      
    } catch let error {
      log.error(error)
    }
  }
  
  func citySerializer(json: [String: Any]) {
    let jsonDecoder = JSONDecoder()
    
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
      log.error("failed to convert city data")
    }
  }

  func forecastSerializer(json: [String: Any], cityID: String) {
    let jsonDecoder = JSONDecoder()
    
    do {
      let forecastData = try JSONSerialization.data(withJSONObject: json["list"] ?? [], options: [])
      let forecast = try jsonDecoder.decode([FCWeather].self, from: forecastData)

      let realm = Realm.safeInstance()

      let predicate = NSPredicate(format: "%k == %@", "identifier", cityID)
      let city = realm.objects(FCCity.self).filter(predicate).first
      
      try realm.write {
        realm.add(forecast, update: true)
        city?.forecast.append(objectsIn: forecast)
      }
    } catch {
      log.error("failed to convert forecast data")
    }
  }
  
}
