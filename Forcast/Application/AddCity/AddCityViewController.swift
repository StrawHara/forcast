//
//  AddCityViewController.swift
//  Forcast
//
//  Created by Romain Le Drogo on 22/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final class AddCityViewController: UIViewController, StoryboardBased {
  
  // MARK: IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
  
  static let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    formatter.formatterBehavior = .behavior10_4
    formatter.numberStyle = .currency
    
    return formatter
  }()
  
  // MARK: Properties
  private var citiesNotificationToken: NotificationToken?
  private var citiesResults: Results<FCCity>?
  private var dataSource: [FCCity] = []
  
  private var webServices: WebServices?
  
  private var query: String? {
    didSet {
      self.setupRealm()
    }
  }
  
  private let disposeBag = DisposeBag()
  
  private var footerView: FooterView?
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)),
                             for: UIControlEvents.valueChanged)
    refreshControl.tintColor = UIColor(named: .red)
    // TODO: Poeditor vv
    refreshControl.attributedTitle = NSAttributedString(string: "Refresh", attributes: nil)
    return refreshControl
  }()
  
  // MARK: Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupSearchBar()
    self.setupTableView()
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
  private func setupSearchBar() {
    self.searchBarTopConstraint.constant = -self.searchBar.bounds.height

    self.searchBar.delegate = self
    self.searchBar.tintColor = UIColor(named: .red)
    self.searchBar
      .rx.text
      .subscribe(onNext: { [weak self] query in
        self?.query = query
      })
      .disposed(by: self.disposeBag)
    
    let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.search))
    search.tintColor = UIColor(named: .blue)
    
    self.navigationItem.rightBarButtonItems = [search]
  }
  
  private func setupDataSource() {
    guard let cities = self.citiesResults else {
      log.error("Unable to unwrapp recents Results from Realm")
      return
    }
    
    self.dataSource = []
    self.dataSource.append(contentsOf: Array(cities))
    self.tableView.reloadData()
  }
  
  private func setupRealm() {
    
    if let query = self.query, !query.isEmpty {
      let predicate = NSPredicate(format: "%K contains[c] %@",
                                  FCCity.CodingKeys.name.rawValue,
                                  query)
      self.citiesResults = Realm.safeInstance().objects(FCCity.self).filter(predicate)
    } else {
      self.citiesResults = Realm.safeInstance().objects(FCCity.self)
    }
    
    self.citiesNotificationToken = self.citiesResults?.observe { [weak self] _ in
      self?.setupDataSource()
    }

  }
  
  private func setupTableView() {
    self.tableView.backgroundColor = UIColor.white
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.addSubview(self.refreshControl)
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 80
    self.tableView.allowsMultipleSelectionDuringEditing = true
    
    self.tableView.register(cellType: CityCell.self)
    
    let footerView = FooterView.loadFromNib()
    footerView.backgroundColor = UIColor.white
    self.footerView = footerView
    self.tableView.tableFooterView = self.footerView
  }
  
  // MARK: @objc
  @objc func search() {
    UIView.animate(withDuration: 0.6, animations: {
      if self.searchBarTopConstraint.constant == 0 {
        self.searchBar.resignFirstResponder()
        self.searchBarTopConstraint.constant = -self.searchBar.bounds.height
      } else {
        self.searchBar.becomeFirstResponder()
        self.searchBarTopConstraint.constant = 0
      }
      
      self.view.setNeedsLayout()
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  @objc
  func handleRefresh(_ refreshControl: UIRefreshControl) {
    self.webServices?.findCity(lon: 2.3522, lat: 48.8566)
    self.setupDataSource()
    self.refreshControl.endRefreshing()
  }
  
}

extension AddCityViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let city = dataSource[indexPath.row]
    
    let cityCell = self.tableView.dequeueReusableCell(for: indexPath) as CityCell
    cityCell.setup(cityID: city.identifier, name: city.name)
    return cityCell
  }
  
}

extension AddCityViewController: UITableViewDelegate {
  // TODO: Show details
}

extension AddCityViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.searchBar.resignFirstResponder()
  }
  
}
