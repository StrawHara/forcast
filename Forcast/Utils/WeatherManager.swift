//
//  WeatherImageManager.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit

final class WeatherManager {
  
  static func weatherImage(for analysis: String?, at timestamp: Int?) -> UIImage? {
    guard let analysis = analysis else { return nil }
    let isNight = Date.isNight(at: timestamp)
    switch analysis {
    case "Clouds":
      return isNight ?
        UIImage(asset: Asset.WeatherIcon.fewCloudsNight) :
        UIImage(asset: Asset.WeatherIcon.fewCloudsDay)
    case "Clear":
      return isNight ?
        UIImage(asset: Asset.WeatherIcon.clearSkyNight) :
        UIImage(asset: Asset.WeatherIcon.clearSkyDay)
    case "Rain":
      return isNight ?
        UIImage(asset: Asset.WeatherIcon.rainNight) :
        UIImage(asset: Asset.WeatherIcon.rainDay)
    default:
      // TODO: vv get exhaustive analysis responses
      return isNight ?
        UIImage(asset: Asset.WeatherIcon.snowNight) :
        UIImage(asset: Asset.WeatherIcon.snowDay)
    }
  }
  
  static func degreeToDirection(degree: Int?) -> String {
    guard let degree = degree else { return "Not set" }
    
    if degree >= 315 || degree <= 45 {
      return L10n.north
    } else if degree >= 45 || degree <= 135 {
      return L10n.east
    } else if degree >= 135 || degree <= 225 {
      return L10n.south
    } else {
      return L10n.west
    }
  }
  
}
