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
  @IBOutlet weak var nameLabel: UILabel!
  
  // MARK: Properties
  private var name: String?

  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: Public
  func setup(name: String) {
    self.name = name
    self.setupCell()
  }
  
  func setupCell() {
    self.nameLabel.text = self.name
  }

}
