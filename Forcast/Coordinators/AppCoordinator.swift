//
//  AppCoordinator.swift
//  Forcast
//
//  Created by Romain Le Drogo on 22/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate:class {
  func showDetails(cityID: String)
}

class AppCoordinator: NSObject {
  
  private enum TabbarItem: Int {
    case cities = 0
    case addCity
  }
  
  private var window: UIWindow?
  
  private var splitViewController: UISplitViewController
  private var tabbarController: UITabBarController
  
  private var citiesNav: UINavigationController
  private var citiesVC: CitiesViewController
  
  private var addCityNav: UINavigationController
  private var addCityVC: AddCityViewController

  private var webServices = WebServices()
  
  init(window: UIWindow?) {
    self.window = window
    
    // MARK: Navigation Controllers
    self.citiesVC = CitiesViewController.instantiate()
    self.citiesNav = UINavigationController(rootViewController: self.citiesVC)
    self.citiesNav.tabBarItem = UITabBarItem(title: L10n.cities,
                                             image: UIImage(asset: Asset.Tabbar.city),
                                             tag: TabbarItem.cities.rawValue)

    self.addCityVC = AddCityViewController.instantiate()
    self.addCityNav = UINavigationController(rootViewController: self.addCityVC)
    self.addCityNav.tabBarItem = UITabBarItem(title: L10n.addCity,
                                              image: UIImage(asset: Asset.Tabbar.plus),
                                              tag: TabbarItem.addCity.rawValue)
    
    let cityVC = CityViewController.instantiate()
    cityVC.setup(webServices: self.webServices,
                 cityID: UserDefaults.standard.favedCities.first)
    let cityNav = UINavigationController(rootViewController: cityVC)
    
    // MARK: Tabbar
    self.tabbarController = UITabBarController()
    self.tabbarController.viewControllers = [citiesNav, addCityNav]
    self.tabbarController.tabBar.contentMode = .scaleAspectFill
    self.tabbarController.tabBar.clipsToBounds = false
    self.tabbarController.tabBar.tintColor = UIColor(named: .blue)
    
    // MAR: SplitViewController
    self.splitViewController = UISplitViewController()
    self.splitViewController.viewControllers = [self.tabbarController, cityNav]
    
    self.window?.rootViewController = self.splitViewController
  }
  
  // MARK: Coordinator implementation
  func start() {
    self.webServices.fetchFavedCities()

    self.citiesVC.setup(webServices: self.webServices, delegate: self)
    self.addCityVC.setup(webServices: self.webServices, delegate: self)

    if UserDefaults.standard.favedCities.isEmpty {
      UserDefaults.standard.favedCities = ["2988507"]
    }
    
    self.launch()
  }
  
  fileprivate func launch() {
  }
  
}

extension AppCoordinator: AppCoordinatorDelegate {
  
  func showDetails(cityID: String) {
    let cityVC = CityViewController.instantiate()
    cityVC.setup(webServices: self.webServices,
                 cityID: cityID)
    let cityNav = UINavigationController(rootViewController: cityVC)
    self.splitViewController.showDetailViewController(cityNav, sender: self)
  }
  
}
