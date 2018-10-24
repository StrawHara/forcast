//
//  CityCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

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
    self.favoriteImage.image = UserDefaults.standard.favoriteCities.contains(cityID) ?
      UIImage(asset: Asset.starPlain) : UIImage(asset: Asset.starEmpty)
  }

  @IBAction func favoriteButtonTouchedUp(_ sender: Any) {
    guard let cityID = self.cityID else { return }
    
    if UserDefaults.standard.favoriteCities.contains(cityID) {
      UserDefaults.standard.favoriteCities = UserDefaults.standard.favoriteCities.filter({$0 != cityID})
      
      // TODO: Remove city from Realm as well
    } else {
      guard UserDefaults.standard.favoriteCities.count < 20 else {
        // TODO: Build delegate AddCityVC side to show an alert
        log.error("More than 20 favorties")
        return
      }
      UserDefaults.standard.favoriteCities.append(cityID)
    }
    
    self.setupCell()
  }
  
}