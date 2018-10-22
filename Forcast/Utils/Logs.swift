//
//  Logs.swift
//  Forcast
//
//  Created by Romain Le Drogo on 22/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import SwiftyBeaver

enum GenericError: Error {
  case realmWrite
  case unwrappFailed(String)
}

extension GenericError {
  
  var errorMessage: String {
    switch self {
    case .realmWrite:
      return  "Unable to write in Realm"
    case .unwrappFailed(let value):
      return "Unable to unwrapp \(value) value"
    }
  }
}

// Create global variable for logs
let log =  SwiftyBeaver.self

struct Logs {
  static func setup() {
    let console = ConsoleDestination()
    
    console.format = "$D[HH:mm:ss]$d $L - $N.$F:$l > $M"
    console.levelString.verbose = "📔 VERBOSE"
    console.levelString.debug = "📗 DEBUG"
    console.levelString.info = "📘 INFO"
    console.levelString.warning = "📙 WARNING"
    console.levelString.error = "📕 ERROR"
    
    log.addDestination(console)
  }
  
}
