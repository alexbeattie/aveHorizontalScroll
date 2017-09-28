//
//  CutstomTabBar.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/28/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: homeController)
        navigationController.title = "Home"
//        homeController.hidesBottomBarWhenPushed = true
//        homeController.hidesBottomBarWhenPushed = false
//        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let allListingsMapVC = AllListingsMapVC()
        let allListingsNavigationController = UINavigationController(rootViewController: allListingsMapVC)
        allListingsNavigationController.title = "All Listings"
//        secondNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
//        let messengerVC = UIViewController()
//        let messengerNavigationController = UINavigationController(rootViewController: messengerVC)
//        messengerNavigationController.title = "Messenger"
//        messengerNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        
//        let notificationsNavController = UINavigationController(rootViewController: UIViewController())
//        notificationsNavController.title = "Notifications"
//        notificationsNavController.tabBarItem.image = UIImage(named: "globe_icon")
        
//        let moreNavController = UINavigationController(rootViewController: UIViewController())
//        moreNavController.title = "More"
//        moreNavController.tabBarItem.image = UIImage(named: "more_icon")
        
//        viewControllers = [navigationController, secondNavigationController, messengerNavigationController, notificationsNavController, moreNavController]
        viewControllers = [navigationController, allListingsNavigationController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
//        topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
    }
}

