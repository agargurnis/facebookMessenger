//
//  CustomTabBarController.swift
//  facebookMessenger
//
//  Created by Arvids Gargurnis on 03/04/2018.
//  Copyright © 2018 Arvids Gargurnis. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named:"recent")
        
        let callsController = createDummyNavControllerWithTitle(title: "Calls", imageName: "calls")
        let peopleController = createDummyNavControllerWithTitle(title: "People", imageName: "people")
        let groupsController = createDummyNavControllerWithTitle(title: "Groups", imageName: "groups")
        let settingsController = createDummyNavControllerWithTitle(title: "Settings", imageName: "settings")
        
        
        viewControllers = [recentMessagesNavController, callsController, peopleController, groupsController, settingsController]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
