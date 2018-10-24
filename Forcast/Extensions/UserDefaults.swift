//
//  UserDefaults.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation

extension UserDefaults {
  
  var favoriteCities: [String] {
    get { let anyArray = array(forKey: #function) ?? []
      guard let stringArray = anyArray as? [String] else {
        return []
      }
      return stringArray
    }
    set { set(newValue, forKey: #function) }
  }
  
}
