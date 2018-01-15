//
//  InstagramUserSearchViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class InstagramUserSearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource {
    
    var searchContoller: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    var httpClient: HTTPClient!
    
    var instagramUserData: [InstagramUser] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.httpClient = HTTPClient(session: URLSession.shared)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.httpClient = HTTPClient(session: URLSession.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add new account"
        
        self.createSearchController()
    }

    func createSearchController(){
        searchContoller = UISearchController(searchResultsController: nil)
        searchContoller.searchResultsUpdater = self
        searchContoller.dimsBackgroundDuringPresentation = false
        
        searchContoller.searchBar.sizeToFit()
        
        navigationItem.titleView = searchContoller.searchBar
        searchContoller.hidesNavigationBarDuringPresentation = false
        
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchContoller.searchBar.text else {
            resetTable(cancelRequests: true)
            return
        }
        
        if (searchText.count == 0) {
            resetTable(cancelRequests: true)
        }
        else {
            executeAPISearch(query: searchText)
        }
        
    }
    
    func resetTable(cancelRequests: Bool) {
        if (cancelRequests) {
            self.httpClient.cancelAllRequests()
        }
        self.instagramUserData = []
        self.tableView.reloadData()
    }
    func executeAPISearch(query: String) {
        
        let token = InstagramAPI.getAccessToken()!
        let url = InstagramAPI.userSearch(query: query, token: token)
        
        self.httpClient.get(url: url) { [weak self] (data, error) in
            
            UIHelper.executeInMainQueue {
                self?.jsonParsing(data: data)
            }
        }
    }
    
    func jsonParsing(data: Data?) {
        self.instagramUserData = []
        guard let _ = data else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any] else {
            self.resetTable(cancelRequests: false)
            return
        }
        guard let igData = json["data"] as? [[String:Any]] else {
            self.resetTable(cancelRequests: false)
            return
            
        }
        
        for item in igData {
            let user = InstagramUser()
            user.bio = item["bio"] as! String
            user.fullName = item["full_name"] as! String
            user.id = item["id"] as! String
            user.isBusiness = item["is_business"] as! Bool
            user.profilePicture = item["profile_picture"] as! String
            user.username = item["username"] as! String
            user.website = item["website"] as! String
            instagramUserData.append(user)
        }
        
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as UITableViewCell?
        if (cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: "TableCell")
        }
        cell!.textLabel?.text = self.instagramUserData[indexPath.row].username
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.instagramUserData.count
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
