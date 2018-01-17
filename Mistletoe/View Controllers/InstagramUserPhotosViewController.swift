//
//  InstagramUserPhotosViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 16/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class InstagramUserPhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var user: InstagramUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(user.username)'s Photos"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
