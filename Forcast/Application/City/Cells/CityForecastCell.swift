//
//  CityForecastCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class CityForecastCell: UITableViewCell, NibReusable {
  
  // MARK: IBOutlets
  
  // MARK: Properties
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = UIColor(named: .yellow)
  }
  
  // MARK: Public
  func setup() {
  }
  
  func setupCell() {
  }
  
}
