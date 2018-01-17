//
//  InstagramUserSearchViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class InstagramUserSearchViewController: UIViewController{
    
    var httpClient: HTTPClient! = HTTPClient.def()
    
    var searchContoller: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    var instagramUserData: [InstagramUser] = []
    
    var presentingInstagramUser: InstagramUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add new account"
        self.standarizeBackButtonItem()
        
        self.createSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func resetTable(cancelRequests: Bool) {
        if (cancelRequests) {
            httpClient.cancelAllRequests()
        }
        self.instagramUserData = []
        self.tableView.reloadData()
    }
    
    func executeAPISearch(query: String) {
        
        let token = InstagramAPI.getAccessToken()!
        let url = InstagramAPI.userSearch(query: query, token: token)
        self.httpClient.get(url: url) { [weak self] (data, error) in
            
            UIHelper.executeInMainQueue {
                if (error != nil) {
                    //UIHelper.showNetworkingError(vc: self, retryBlock: nil)
                }
                else {
                    self?.jsonParsing(data: data)
                }
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
    
    func addUser(user: InstagramUser){
        if (InstagramAccountsHelper.addAccount(account: user)){
            decideUserSelectNavigation(user: user)
        }
        else {
            displayDuplicationError(user: user)
        }
    }
    
    func displayDuplicationError(user: InstagramUser) {
        UIHelper.showAlert(vc: self, title: "Error", message: "User \(user.username) has already been added")
    }
    
    func decideUserSelectNavigation(user: InstagramUser) {
        let alert = UIAlertController(title: "Success", message: "User added successfully. What would you like to do next?", preferredStyle: UIAlertControllerStyle.alert)
        let viewPictures = UIAlertAction(title: "View user's pictures", style: UIAlertActionStyle.default) { [weak self] (action) in
            self?.presentingInstagramUser = user
            self?.performSegue(withIdentifier: SegueIdentifiers.InstagramUserSearchToInstagramUserPhotos.rawValue, sender: nil)
        }
        alert.addAction(viewPictures)
        
        let searchForAnotherUser = UIAlertAction(title: "Search for another user", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(searchForAnotherUser)
        let goToTheHomeScreen = UIAlertAction(title: "Go to the home screen", style: UIAlertActionStyle.cancel) { [weak self](action) in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(goToTheHomeScreen)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueIdentifiers.InstagramUserSearchToInstagramUserPhotos.rawValue) {
            let vc = segue.destination as! InstagramUserPhotosViewController
            vc.user = self.presentingInstagramUser
        }
    }
    
}

extension InstagramUserSearchViewController: UISearchResultsUpdating {
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
}

extension InstagramUserSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as UITableViewCell?
        if (cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        }
        
        let user = self.instagramUserData[indexPath.row]
        cell!.textLabel?.text = user.username
        cell!.detailTextLabel?.text = user.fullName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.instagramUserData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.instagramUserData.count == 0) {
            return "No results"
        }
        else {
            return "Results"
        }
    }
}

extension InstagramUserSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = self.instagramUserData[indexPath.row]
        self.addUser(user: user)
    }
}
