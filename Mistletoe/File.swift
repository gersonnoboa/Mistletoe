//
//  File.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

protocol TintedNavigationBar {
    func tintNavigationBarColor()
}

extension TintedNavigationBar where Self: UIViewController {
    func tintNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
}

