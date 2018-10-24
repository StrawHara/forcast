//
//  Realm.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import RealmSwift

extension Realm {
  
  static let realmSafeInstanceKey = "RealmSafeInstanceKey"
  
  static func safeInstance() -> Realm {
    var configuration = Realm.Configuration()
    configuration.deleteRealmIfMigrationNeeded = true
    let realm: Realm
    
    do {
      realm = try Realm(configuration: configuration)
    } catch {
      fatalError("Realm.safeInstance error:\n\(error)")
    }
    
    return realm
  }
  
  class func deleteAll() throws {
    let realm = Realm.safeInstance()
    try realm.write({
      realm.deleteAll()
    })
  }
}
