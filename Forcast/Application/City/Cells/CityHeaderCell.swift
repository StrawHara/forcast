//
//  CityHeaderCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class CityHeaderCell: UITableViewCell, NibReusable {
  
  // MARK: IBOutlets
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var analysisLabel: UILabel!
  
  // MARK: Properties
  private var timestamp: Int?
  private var analysis: String?
  private var analysisDescription: String?
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = UIColor(named: .blue)
    self.setupCell()
  }
  
  // MARK: Public
  func setup(timestamp: Int?, analysis: String?, analysisDescription: String?) {
    self.timestamp = timestamp
    self.analysis = analysis
    self.analysisDescription = analysisDescription

    self.setupCell()
  }
  
  func setupCell() {
    self.analysisLabel.text = self.analysisDescription?.capitalizingFirstLetter()
    self.iconImage.image = WeatherManager
      .weatherImage(for: self.analysis, at: self.timestamp)
  }
  
}
