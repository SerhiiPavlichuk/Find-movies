//
//  HomeScreenViewController.swift
//  Find movies
//
//  Created by admin on 08.06.2022.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .customBlack
        let logo = UIImage.logoTitle
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 182, height: 95))
        container.backgroundColor = UIColor.clear

        let imageView = UIImageView(frame:  CGRect(x: -80, y: 2, width: 182, height: 95))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo

        container.addSubview(imageView)

        self.navigationItem.titleView = container
    }
}
