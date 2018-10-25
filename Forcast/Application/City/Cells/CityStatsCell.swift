//
//  CityStatsCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class CityStatsCell: UITableViewCell, NibReusable {
  
  // MARK: IBOutlets
  @IBOutlet weak var infoView: WeatherBubbleInfoView!
  
  // MARK: Properties
  private var weatherInfoType: WeatherInfoType?
  private var city: FCCity?

  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.setupCell()
  }
  
  // MARK: Public
  func setup(weatherInfoType: WeatherInfoType, city: FCCity) {
    self.weatherInfoType = weatherInfoType
    self.city = city
    
    self.setupCell()
  }
  
  // MARK: Privates
  private func setupCell() {
    guard let weatherInfoType = self.weatherInfoType,
      let city = self.city else { return }
    
    var contentText = ""
    switch weatherInfoType {
    case .clouds:
      contentText = "\(city.weather?.clouds?.all ?? 0)"
    case .rain:
      contentText = "\(city.weather?.rain?.mlPer3H ?? 0)"
    case .temp:
      contentText = L10n.temp("\(city.weather?.main?.temp ?? 0)",
        "\(city.weather?.main?.tempMax ?? 0)",
        "\(city.weather?.main?.tempMin ?? 0)",
        "\(city.weather?.main?.humidity ?? 0)")
    case .wind:
      contentText = L10n.wind("\(city.weather?.wind?.speed ?? 0)",
        WeatherManager.degreeToDirection(degree: city.weather?.wind?.deg))
    }
    
    self.infoView.setup(weatherInfoType: weatherInfoType, contentText: contentText, darkMode: true)
  }
  
}
