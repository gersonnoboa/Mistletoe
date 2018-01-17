//
//  InstagramMediaDetailViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 17/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit
import SDWebImage

class InstagramMediaDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var postedOn: UILabel!
    
    var instagramMedia: InstagramMedia!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Media"
        self.standarizeBackButtonItem()
        
        self.setUpView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView(){
        let url = URL(string: instagramMedia.url)
        self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Placeholder"))
        self.likes.text = "\(instagramMedia.likes) \(instagramMedia.likes == 1 ? "like" : "likes")"
        self.comments.text = "\(instagramMedia.comments) \(instagramMedia.comments == 1 ? "comment" : "comments")"
        if let interval = Double(instagramMedia.createdTime) {
            let date = Date(timeIntervalSince1970: TimeInterval(exactly: interval)!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            self.postedOn.text = "\(dateFormatter.string(from: date))"
        }
        else{
            self.postedOn.text = "Recently"
        }
        
    }

}
