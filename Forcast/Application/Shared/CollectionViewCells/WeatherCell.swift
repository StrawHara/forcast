//
//  WeatherCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class WeatherCell: UICollectionViewCell, NibReusable {

  // MARK: IBOutlets
  @IBOutlet weak var cellContentView: UIView! {
    didSet {
      self.cellContentView.backgroundColor = UIColor(named: .blue)
      self.cellContentView.layer.cornerRadius = 25
    }
  }
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var weatherAnalysisImage: UIImageView!
  @IBOutlet weak var analysisDescriptionLabel: UILabel!
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var weatherBubbleLeft: WeatherBubbleInfoView!
  @IBOutlet weak var weatherBubbleMiddle: WeatherBubbleInfoView!
  @IBOutlet weak var weatherBubbleRight: WeatherBubbleInfoView!
  
  // MARK: Properties
  private var city: FCCity?
  private var weather: FCWeather?
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()

    self.setupCell()
  }
  
  // MARK: Public
  func setup(city: FCCity?, weather: FCWeather? = nil) {
    self.city = city
    self.weather = city?.weather
    
    if weather != nil {
      self.weather = weather
    }
    
    self.setupCell()
  }
  
  func setupCell() {
    self.cityNameLabel.text = city?.name
    self.dateTimeLabel.text = Date.formattedDate(for: self.weather?.dateTime)
    self.analysisDescriptionLabel.text = self.weather?.analysis?
      .analysisDescription.capitalizingFirstLetter()
    
    self.weatherBubbleRight.setup(weatherInfoType: .temp,
                                  contentText: "\(self.weather?.main?.temp ?? 0)")
    self.weatherBubbleMiddle.setup(weatherInfoType: .wind,
                                  contentText: "\(self.weather?.wind?.speed ?? 0)")
    self.weatherBubbleLeft.setup(weatherInfoType: .rain,
                                  contentText: "\(self.weather?.rain?.mlPer3H ?? 0)")
    
    self.weatherAnalysisImage.image = WeatherManager
      .weatherImage(for: self.weather?.analysis?.main, at: self.weather?.dateTime)
  }

}
