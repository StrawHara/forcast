//
//  CitiesViewController.swift
//  Forcast
//
//  Created by Romain Le Drogo on 22/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import RealmSwift

final class CitiesViewController: UIViewController, StoryboardBased {
  
  // MARK: IBOutlets
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  // MARK: Properties
  private var citiesNotificationToken: NotificationToken?
  private var citiesResults: Results<FCCity>?
  private var dataSource: [FCCity] = []
  
  private var webServices: WebServices?
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)),
                             for: UIControl.Event.valueChanged)
    refreshControl.tintColor = UIColor(named: .red)
    // TODO: Poeditor vv
    refreshControl.attributedTitle = NSAttributedString(string: "Refresh", attributes: nil)
    return refreshControl
  }()
  
  // MARK: Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = L10n.cities
    
    self.setupCollectionView()
    self.setupRealm()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.handleRefresh(self.refreshControl)
  }
  
  // MARK: Public
  func setup(webServices: WebServices) {
    self.webServices = webServices
  }
  
  // MARK: Private
  private func setupDataSource() {
    guard let cities = self.citiesResults else {
      log.error("Unable to unwrapp recents Results from Realm")
      return
    }
    
    self.dataSource = []
    self.dataSource.append(contentsOf: Array(cities.filter({
      UserDefaults.standard.favoriteCities.contains($0.identifier)
    })))
    self.collectionView.reloadData()
  }
  
  private func setupRealm() {
    
    self.citiesResults = Realm.safeInstance().objects(FCCity.self)
    
    self.citiesNotificationToken = self.citiesResults?.observe { [weak self] _ in
      self?.setupDataSource()
    }
  }
  
  private func setupCollectionView() {
    self.collectionView.backgroundColor = UIColor.white
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.collectionView.addSubview(self.refreshControl)
    
    self.collectionView.alwaysBounceVertical = true
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false

    self.collectionView.register(cellType: WeatherCell.self)
  }
  
  // MARK: @objc
  @objc
  func handleRefresh(_ refreshControl: UIRefreshControl) {
    // TODO: vv
//    self.webServices?.fetchFavedCities()
    self.setupDataSource()
    self.refreshControl.endRefreshing()
  }
  
}

extension CitiesViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let city = dataSource[indexPath.row]
    
    let weatherCell = self.collectionView.dequeueReusableCell(for: indexPath) as WeatherCell
    weatherCell.setup(city: city)
    return weatherCell
  }
  
}

extension CitiesViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.bounds.width, height: 380)
    
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

extension CitiesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // TODO: Push DetailsVC from AppCoord if time
    // or simple push instead
  }
  
}
