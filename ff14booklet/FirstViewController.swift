//
//  FirstViewController.swift
//  ff14booklet
//
//  Created by slightair on 2014/09/13.
//  Copyright (c) 2014年 slightair. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabBarItemImage() -> UIImage {
        let cloudIcon = FAKFoundationIcons.cloudIconWithSize(TabBarItemIconFontSize)
        return cloudIcon.imageWithSize(TabBarItemIconImageSize)
    }
}

