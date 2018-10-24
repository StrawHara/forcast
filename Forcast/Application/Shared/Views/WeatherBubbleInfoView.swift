//
//  WeatherBubbleInfoView.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable

final class WeatherBubbleInfoView: UIView, NibOwnerLoadable {

  // MARK: Outlets
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var contentLabel: UILabel!

  // MARK: Properties
  private var icon: UIImage?
  private var contentText: String?
  
  // MARK: Init
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = UIColor.white
    self.layer.cornerRadius = 20
    self.alpha = 0.7
    
    self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.setupview()
  }
  
  // MARK: Public
  func setup(icon: UIImage, contentText: String) {
    log.info("Yahou")
    self.icon = icon
    self.contentText = contentText
    self.setupview()
    
  }
  
  // MARK: Privates
  func setupview() {
    self.iconImage.image = self.icon
    self.contentLabel.text = self.contentText
  }
  
}
