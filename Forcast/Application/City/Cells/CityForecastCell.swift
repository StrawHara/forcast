//
//  CityForecastCell.swift
//  Forcast
//
//  Created by Romain Le Drogo on 25/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import Reusable
import RealmSwift

final class CityForecastCell: UITableViewCell, NibReusable {
  
  // MARK: IBOutlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  // MARK: Properties
  private var cityNotificationToken: NotificationToken?
  private var cityResults: Results<FCCity>?
  private var city: FCCity? {
    return self.cityResults?.first
  }
  private var dataSource: [FCWeather] = []
  
  private var cityID: String?
  
  // MARK: Init
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.setupCollectionView()
  }
  
  // MARK: Public
  func setup(cityID: String) {
    log.verbose(cityID)
    self.cityID = cityID
    self.setupRealm()
  }
  
  // MARK: Private
  private func setupDataSource() {
    guard let city = self.city else {
      log.error("Unable to unwrapp recents Results from Realm")
      return
    }
    
    self.dataSource = []
    self.dataSource.append(contentsOf: Array(city.forecast))
    self.collectionView.reloadData()
  }
  
  private func setupRealm() {
    guard let cityID = self.cityID else { return }

    let predicate = NSPredicate(format: "%K == %@", "identifier", cityID)
    self.cityResults = Realm.safeInstance().objects(FCCity.self).filter(predicate)
    
    self.cityNotificationToken = self.cityResults?.observe { [weak self] _ in
      self?.setupDataSource()
    }
  }
  
  private func setupCollectionView() {
    self.collectionView.backgroundColor = UIColor.white
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.collectionView.alwaysBounceHorizontal = true
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    self.collectionView.register(cellType: WeatherCell.self)
  }
  
}

extension CityForecastCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    log.info(self.dataSource.count)
    return self.dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let weather = dataSource[indexPath.row]
    
    let weatherCell = self.collectionView.dequeueReusableCell(for: indexPath) as WeatherCell
    weatherCell.setup(city: nil, weather: weather)
    log.warning(weather)
    return weatherCell
  }
  
}

extension CityForecastCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 400, height: 380)
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1.0
  }
  
}
