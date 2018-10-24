//
//  FooterView.swift
//  Forcast
//
//  Created by Romain Le Drogo on 23/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class FooterView: UIView, NibLoadable {
  
  // MARK: Outlets
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = UIColor.clear
  }
  
  // MARK: Public
  func setup(backgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
  }
  
}
