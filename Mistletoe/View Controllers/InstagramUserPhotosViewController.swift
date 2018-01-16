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
    var user: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(user)'s Photos"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
