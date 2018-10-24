//
//  Routes.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation

public enum Route {
  case forecast(city: String)
  case find(lat: Double, lon: Double)
  
  public var path: String {
    switch self {
    case .forecast(let city): return "forecast?q=\(city)&APPID=\(Environment.accessToken)"
    case .find(let lat, let lon): return "find?lat=\(lat)&lon=\(lon)&cnt=50&APPID=\(Environment.accessToken)"
    }
  }
}

extension Route: CustomStringConvertible {
  public var description: String { return path }
}
