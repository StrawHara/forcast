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
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()

    self.setupCell()
  }
  
  // MARK: Public
  func setup(city: FCCity) {
    self.city = city
    
    self.setupCell()
  }
  
  func setupCell() {
    guard let city = self.city else {
      return
    }
    
    self.cityNameLabel.text = city.name
    self.dateTimeLabel.text = Date.formattedDate(for: city.weather?.dateTime)
    self.analysisDescriptionLabel.text = city.weather?.analysis?
      .analysisDescription.capitalizingFirstLetter()
    
    self.weatherBubbleRight.setup(weatherInfoType: .temp,
                                  contentText: "\(city.weather?.main?.temp ?? 0)")
    self.weatherBubbleMiddle.setup(weatherInfoType: .wind,
                                  contentText: "\(city.weather?.wind?.speed ?? 0)")
    self.weatherBubbleLeft.setup(weatherInfoType: .rain,
                                  contentText: "\(city.weather?.rain?.mlPer3H ?? 0)")
    
    self.weatherAnalysisImage.image = WeatherManager
      .weatherImage(for: city.weather?.analysis?.main, at: city.weather?.dateTime)
  }

}
