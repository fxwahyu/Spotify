//
//  HomeVC.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class TabbarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTabbar() {
        self.tabBar.backgroundColor = .black
        
        delegate = self

        let tabbarHome = HomeVC()
        let tabbarSearch = SearchVC()
        let tabbarLibrary = LibraryVC()
        
        tabbarHome.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        tabbarSearch.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), selectedImage: #imageLiteral(resourceName: "search"))
        tabbarLibrary.tabBarItem = UITabBarItem(title: "Your Library", image: #imageLiteral(resourceName: "library"), selectedImage: #imageLiteral(resourceName: "library"))
        
        self.viewControllers = [tabbarHome, tabbarSearch, tabbarLibrary]
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        
        self.selectedIndex = 2
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex != 2 {
            return false
        }
        return true
    }
}
