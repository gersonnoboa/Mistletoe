//
//  InstagramUserPhotosViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 16/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit
import SDWebImage

class InstagramUserPhotosViewController: UIViewController {

    let photosCellIdentifier = "Photos"
    let cellPadding: CGFloat = 2
    let itemsPerRow: CGFloat = 3
    
    let httpClient = HTTPClient(session: URLSession.shared)
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var website: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: InstagramUser!
    
    var instagramMedia: [InstagramMedia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(user.username)'s Photos"
        setUpViews()
        executeAPIImageFetch()
    }
    
    func setUpViews() {
        let url = URL(string: user.profilePicture)
        self.name.text = user.fullName.isEmpty ? "Anonymous" : user.fullName
        self.bio.text = user.bio.isEmpty ? "No bio" : user.bio
        self.website.text = user.website.isEmpty ? "No website" : user.website
        self.profilePicture.sd_setImage(with: url, placeholderImage: UIImage(named: "Placeholder"))
        
        self.profilePicture.layer.cornerRadius = 10
        self.profilePicture.clipsToBounds = true
    }
    
    func executeAPIImageFetch() {
        let id = self.user.id
        let token = InstagramAPI.getAccessToken()!
        
        let url = InstagramAPI.userMedia(id: id, token: token)
        self.httpClient.get(url: url) {[weak self] (data, error) in
            UIHelper.executeInMainQueue {
                if (error != nil) {
                    UIHelper.showNetworkingError(vc: self, retryBlock: {[weak self] () -> (Void) in
                        self?.executeAPIImageFetch()
                    })
                }
                else {
                    self?.jsonParsing(data: data)
                }
            }
        }
    }
    
    func jsonParsing(data: Data?) {
        guard let data = data else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any] else { return }
        guard let igData = json["data"] as? [[String:Any]] else { return }
        
        for item in igData {
            let media = InstagramMedia()
            
            let images = item["images"] as! [String:Any]
            let lowResolution = images["low_resolution"] as! [String:Any]
            media.url = lowResolution["url"] as! String
            
            self.instagramMedia.append(media)
        }
        
        self.collectionView.reloadData()
        //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension InstagramUserPhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.instagramMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.photosCellIdentifier, for: indexPath) as! PictureCollectionViewCell
        let media = self.instagramMedia[indexPath.row]
        let url = URL(string: media.url)
        cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Placeholder"))
        return cell;
    }
}

extension InstagramUserPhotosViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.collectionView.frame.size.width
        let padding = self.cellPadding * (itemsPerRow + 1)
        let remainingWidth = collectionViewWidth - padding
        let widthPerItem = remainingWidth / (itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellPadding + 1
    }
}
