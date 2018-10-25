//
//  WeatherBubbleInfoView.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

enum WeatherInfoType: Int {
  case temp = 0
  case clouds
  case wind
  case rain
}

final class WeatherBubbleInfoView: UIView, NibOwnerLoadable {
  
  // MARK: Outlets
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var contentLabel: UILabel!
  
  // MARK: Properties
  private var icon: UIImage?
  private var weatherInfoType: WeatherInfoType?
  private var contentText: String?
  private var isDarkMode: Bool = false
  
  // MARK: Init
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = UIColor.white
    self.alpha = 1
    self.layer.cornerRadius = 20
    
    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.setupview()
  }
  
  // MARK: Public
  func setup(weatherInfoType: WeatherInfoType, contentText: String, darkMode: Bool = false) {
    self.weatherInfoType = weatherInfoType
    self.contentText = contentText
    self.isDarkMode = darkMode
    
    switch weatherInfoType {
    case .clouds: self.icon = UIImage(asset: Asset.ElementsIcon.cloud)
    case .rain: self.icon = UIImage(asset: Asset.ElementsIcon.umbrella)
    case .temp: self.icon = UIImage(asset: Asset.ElementsIcon.thermometer)
    case .wind: self.icon = UIImage(asset: Asset.ElementsIcon.wind)
    }
    
    self.setupview()
  }
  
  // MARK: Privates
  func setupview() {
    self.iconImage.image = self.icon
    self.contentLabel.text = self.contentText
    
    self.iconImage.tintColor =  self.isDarkMode ?
      UIColor(named: .blue) : UIColor(named: .yellow)
    
    self.contentLabel.textColor = self.isDarkMode ?
      UIColor(named: .black) : UIColor(named: .blue)
  }
  
}
