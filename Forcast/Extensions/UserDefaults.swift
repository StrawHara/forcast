//
//  UserDefaults.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation

// MARK: Warning - Do not create duplicates

extension UserDefaults {
  
  var favedCities: [String] {
    get { let anyArray = array(forKey: #function) ?? []
      guard let stringArray = anyArray as? [String] else {
        return []
      }
      return stringArray
    }
    set { set(newValue, forKey: #function) }
  }
  
}
