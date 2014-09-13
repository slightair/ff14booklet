//
//  TabBarController.swift
//  ff14booklet
//
//  Created by slightair on 2014/09/13.
//  Copyright (c) 2014年 slightair. All rights reserved.
//

import UIKit

let TabBarItemIconFontSize: CGFloat = 32.0
let TabBarItemIconImageSize = CGSizeMake(32.0, 32.0)

protocol TabBarItemIconSupport {
    func tabBarItemImage() -> UIImage
}

class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()

        for (index, viewController) in enumerate(self.viewControllers as [UIViewController]) {
//            if viewController.conformsToProtocol(TabBarItemIconSupport) {
//                let image = viewController.tabBarItemImage?()
//                self.tabBar.items.image = image
//            }
        }
    }
}
