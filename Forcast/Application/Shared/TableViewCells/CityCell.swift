//
//  CityCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

final class CityCell: UITableViewCell, NibReusable {
  
  // MARK: IBOutlets
  @IBOutlet weak var nameLabel: UILabel! {
    didSet {
      self.nameLabel.textColor = UIColor(named: .blue)
    }
  }
  @IBOutlet weak var favoriteImage: UIImageView! {
    didSet {
      self.favoriteImage.image = UIImage(asset: Asset.starEmpty)
    }
  }
  
  // MARK: Properties
  private var cityID: String?
  private var name: String?
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: Public
  func setup(cityID: String, name: String) {
    self.cityID = cityID
    self.name = name
    self.setupCell()
  }
  
  func setupCell() {
    guard let cityID = self.cityID else {
      return
    }
    
    self.nameLabel.text = self.name
    self.favoriteImage.image = UserDefaults.standard.favedCities.contains(cityID) ?
      UIImage(asset: Asset.starPlain) : UIImage(asset: Asset.starEmpty)
  }
  
  @IBAction func favoriteButtonTouchedUp(_ sender: Any) {
    guard let cityID = self.cityID else { return }
    
    if UserDefaults.standard.favedCities.contains(cityID) {
      UserDefaults.standard.favedCities = UserDefaults.standard.favedCities.filter({$0 != cityID})
      
      let realm = Realm.safeInstance()
      let predicate = NSPredicate(format: "%K == %@",
                                  "identifier", cityID)
      if let city = realm.objects(FCCity.self).filter(predicate).first {
        do {
          try realm.write {
            realm.delete(city)
          }
        } catch {
          log.error("unable to delete city from realm")
        }
      }
      
    } else {
      guard UserDefaults.standard.favedCities.count < 20 else {
        // TODO: Build delegate AddCityVC side to show an alert
        log.error("More than 20 favorties")
        return
      }
      UserDefaults.standard.favedCities.append(cityID)
    }
    
    self.setupCell()
  }
  
}
