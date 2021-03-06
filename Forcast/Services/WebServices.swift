//
//  WebServices.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import Alamofire

final class WebServices {
  
  func findCity(lon: Double, lat: Double) {
    
    guard let url = URL(string: Environment.baseURL + Route.find(lat: lat, lon: lon).description) else {
      return
    }
    
    Alamofire.request(url)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData { response in
        switch response.result {
        case .success:
          let serializer = JSONSerializer()
          serializer.serialize(input: response.data,
                               sourceType: .city)
        case .failure(let error):
          log.error(error)
        }
    }
  }
  
  func fetchFavedCities() {
    for cityID in UserDefaults.standard.favedCities {
      self.fetchCity(cityID: cityID)
    }
  }
  
  func fetchCity(cityID: String) {
    guard let url = URL(string: Environment.baseURL + Route.city(cityID: cityID).description) else {
      return
    }
    
    Alamofire.request(url)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData { response in
        switch response.result {
        case .success:
          let serializer = JSONSerializer()
          serializer.serialize(input: response.data,
                               sourceType: .forecast(cityID: cityID))
        case .failure(let error):
          log.error(error)
        }
    }
    
  }
  
}
