//
//  FCAnalysis.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class FCAnalysis: Object, Decodable {
  
  @objc dynamic var identifier: String = ""
  
  @objc dynamic var analysisID: Int = 0
  @objc dynamic var main: String = ""
  @objc dynamic var analysisDescription: String = ""
  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  enum CodingKeys: String, CodingKey {
    case analysisID = "id"
    case main = "main"
    case analysisDescription = "description"
  }
  
  convenience init(identifier: String, analysisID: Int, main: String,
                   analysisDescription: String) {
    self.init()
    self.identifier = identifier
    self.analysisID = analysisID
    self.main = main
    self.analysisDescription = analysisDescription
  }
  
  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let identifier =  UUID().uuidString
    let analysisID = try container.decode(Int.self, forKey: .analysisID)
    let main = try container.decode(String.self, forKey: .main)
    let analysisDescription = try container.decode(String.self, forKey: .analysisDescription)
    
    self.init(identifier: identifier, analysisID: analysisID, main: main,
              analysisDescription: analysisDescription)
  }
  
  required init() {
    super.init()
  }
  
  required init(value: Any, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
  
  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }

}
