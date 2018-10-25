//
//  AppCoordinator.swift
//  Forcast
//
//  Created by Romain Le Drogo on 22/10/2018.
//  Copyright © 2018 Romain Le Drogo. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
  
  private enum TabbarItem: Int {
    case cities = 0
    case addCity
  }
  
  private var window: UIWindow?
  private var tabbarController: UITabBarController
  
  private var citiesNav: UINavigationController
  private var addCityNav: UINavigationController
  
  private var webServices = WebServices()
  
  init(window: UIWindow?) {
    self.window = window
    
    // MARK: Navigation Controllers
    let citiesVC = CitiesViewController.instantiate()
//    citiesVC.setup(webServices: self.webServices)
    self.citiesNav = UINavigationController(rootViewController: citiesVC)
    self.citiesNav.tabBarItem = UITabBarItem(title: L10n.cities,
                                             image: UIImage(asset: Asset.Tabbar.city),
                                             tag: TabbarItem.cities.rawValue)

    let addCityVC = AddCityViewController.instantiate()
    addCityVC.setup(webServices: self.webServices)
    self.addCityNav = UINavigationController(rootViewController: addCityVC)
    self.addCityNav.tabBarItem = UITabBarItem(title: L10n.addCity,
                                              image: UIImage(asset: Asset.Tabbar.plus),
                                              tag: TabbarItem.addCity.rawValue)

    // MARK: Tabbar
    self.tabbarController = UITabBarController()
    self.tabbarController.viewControllers = [self.citiesNav, self.addCityNav]
    self.tabbarController.tabBar.contentMode = .scaleAspectFill
    self.tabbarController.tabBar.clipsToBounds = false
    self.tabbarController.tabBar.tintColor = UIColor(named: .blue)

    self.window?.rootViewController = self.tabbarController
  }
  
  // MARK: Coordinator implementation
  func start() {
    self.tabbarController.delegate = self

    self.webServices.fetchFavedCities()

    // TODO: vv
    // Check if favorites or paris as first one -> Mean default db or default nsuserdefault
    // Favorites sotred in userDefault
    // Store Paris if no one setted
    
    // Load app on list with only paris
    // empty view -> redirect to add City
    
    self.launch()
  }
  
  fileprivate func launch() {
    
  }
  
}

extension AppCoordinator: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
  }
  
}
