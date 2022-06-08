//
//  TabBarController.swift
//  Find movies
//
//  Created by admin on 08.06.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()

    }

    override func viewDidLayoutSubviews() {
        tabBar.frame = CGRect(x: 0,y: (UIScreen.main.bounds.height - tabBar.frame.height) ,width: UIScreen.main.bounds.width,height: 100)
    }

    private func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeScreenViewController())
        homeVC.navigationBar.prefersLargeTitles = true
        let bookmarkVC = UINavigationController(rootViewController: BookmarkScreenViewController())
        let categoriesVC = UINavigationController(rootViewController: CategoriesScreenViewController())
        let bookmarkIcon: UIImage = .bookmarkIcon
        let userIcon: UIImage = .userIcon
        let homeIcon: UIImage = .homeIcon
        let images = [homeIcon, userIcon, bookmarkIcon]
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 60, y: self.tabBar.bounds.minY + 5, width: self.tabBar.bounds.width - 120, height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.customRed.cgColor
        tabBar.layer.insertSublayer(layer, at: 0)
        if let items = self.tabBar.items {
            items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }

        tabBar.itemWidth = 50.0
        tabBar.itemPositioning = .centered
        self.setViewControllers([homeVC, categoriesVC, bookmarkVC], animated: true)
        self.tabBar.tintColor = .customWhite
        self.tabBar.unselectedItemTintColor = .customGray
        self.tabBar.backgroundColor = .clear
        guard let items = self.tabBar.items else { return }

        for x in 0..<images.count {
            items[x].image = images[x]
        }
    }
}
