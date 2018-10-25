//
//  CityViewController.swift
//  Forcast
//
//  Created by Romain Le Drogo on 24/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import RealmSwift

final class CityViewController: UIViewController, StoryboardBased {
  
  // MARK: IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var emptyLabel: UILabel! {
    didSet {
      self.emptyLabel.text = "Please select a city first"
    }
  }
  
  // MARK: Properties
  private var citiesNotificationToken: NotificationToken?
  private var citiesResults: Results<FCCity>?
  private var city: FCCity? {
    return self.citiesResults?.first
  }
  
  private var cityID: String?
  
  private var webServices: WebServices?
  
  private var footerView: FooterView?
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)),
                             for: UIControl.Event.valueChanged)
    refreshControl.tintColor = UIColor(named: .blue)
    refreshControl.attributedTitle = NSAttributedString(string: L10n.refresh,
                                                        attributes: [.foregroundColor: UIColor(named: .blue)])
    return refreshControl
  }()
  
  private enum CellType: Int {
    case header = 0
    case wind
    case temp
    case rain
    case forecast
  }
  
  private var cells: [CellType] = [
    .header, .wind, .temp, .rain, .forecast
  ]
  
  // MARK: Init
  override func viewDidLoad() {
    super.viewDidLoad()

    let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissVC))
    done.tintColor = UIColor(named: .red)
    self.navigationItem.rightBarButtonItem = done

    self.setupTableView()
    self.setupRealm()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.handleRefresh(self.refreshControl)
  }
  
  // MARK: Public
  func setup(webServices: WebServices?, cityID: String?) {
    self.webServices = webServices
    self.cityID = cityID
  }
  
  // MARK: Privates
  private func setupRealm() {
    guard let cityID = self.cityID else {
      log.error("Unable to unwrapp cityID")
      return
    }
    
    let predicate = NSPredicate(format: "%K == %@",
                                "identifier",
                                cityID)
    
    self.citiesResults = Realm.safeInstance().objects(FCCity.self).filter(predicate)
    
    self.citiesNotificationToken = self.citiesResults?.observe { [weak self] _ in
      self?.title = self?.city?.name
      self?.tableView.reloadData()
    }
    
  }
  
  private func setupTableView() {
    self.tableView.backgroundColor = UIColor.white
    
    self.tableView.dataSource = self
    
    self.tableView.addSubview(self.refreshControl)
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 80
    self.tableView.allowsMultipleSelectionDuringEditing = true
    
    self.tableView.register(cellType: CityHeaderCell.self)
    self.tableView.register(cellType: CityStatsCell.self)
    self.tableView.register(cellType: CityForecastCell.self)
    
    let footerView = FooterView.loadFromNib()
    footerView.backgroundColor = UIColor.white
    self.footerView = footerView
    self.tableView.tableFooterView = self.footerView
  }
  
  // MARK: @objc
  @objc
  func handleRefresh(_ refreshControl: UIRefreshControl) {
    guard let cityID = self.cityID else { return }
    self.webServices?.fetchCity(cityID: cityID)
    self.refreshControl.endRefreshing()
  }
  
  @objc
  func dismissVC() {
    self.navigationController?.dismiss(animated: true, completion: nil)
  }
  
}

extension CityViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    guard let city = self.city else { return cell }

    switch self.cells[indexPath.row] {
    case .header:
      let headerCell = self.tableView.dequeueReusableCell(for: indexPath) as CityHeaderCell
      headerCell.setup(timestamp: self.city?.weather?.dateTime,
                       analysis: self.city?.weather?.analysis?.main,
                       analysisDescription: self.city?.weather?.analysis?.analysisDescription)
      cell = headerCell
    case .temp:
      let tempCell = self.tableView.dequeueReusableCell(for: indexPath) as CityStatsCell
      tempCell.setup(weatherInfoType: .temp, city: city)
      cell = tempCell
    case .wind:
      let windCell = self.tableView.dequeueReusableCell(for: indexPath) as CityStatsCell
      windCell.setup(weatherInfoType: .wind, city: city)
      cell = windCell
    case .rain:
      let rainCell = self.tableView.dequeueReusableCell(for: indexPath) as CityStatsCell
      rainCell.setup(weatherInfoType: .rain, city: city)
      cell = rainCell
    case .forecast:
      let forecastCell = self.tableView.dequeueReusableCell(for: indexPath) as CityForecastCell
      forecastCell.setup(cityID: city.identifier)
      cell = forecastCell
    }
    
    return cell
  }
  
}
