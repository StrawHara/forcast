//
//  String.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation

extension String {

  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }

}
