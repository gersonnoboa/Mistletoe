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
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        filteredData = data
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
            tableView.reloadData()
            return
        }
        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as UITableViewCell?
        if (cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: "TableCell")
        }
        cell!.textLabel?.text = filteredData[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
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
