//
//  AccountsViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TintedNavigationBar {

    var accounts: [String] = []
    @IBOutlet weak var logInStatusText: UILabel!
    @IBOutlet weak var logInStatusView: UIView!
    var logInStatusViewTapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Account";
        
        if let accs = InstagramAccountsHelper.getAccounts() {
            accounts = accs
        }
        
        configureLogInStatusView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineLogInStatus()
    }
    
    func configureLogInStatusView() {
        self.logInStatusViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapLogInStatusView(_:)))
        self.logInStatusView.addGestureRecognizer(self.logInStatusViewTapRecognizer)
    }
    
    @objc func handleTapLogInStatusView(_ tap: UITapGestureRecognizer){
        if (hasLoggedInToInstagram()) {
            logOutOfInstagram()
        }
        else {
            goToInstagramLogin()
        }
        
    }
    
    func logOutOfInstagram() {
        InstagramAPI.setAccessToken(token: nil)
        determineLogInStatus()
        UIHelper.showSuccessAlert(vc: self, message: nil)
    }
    func determineLogInStatus() {
        if hasLoggedInToInstagram() {
            self.logInStatusText.text = "You are logged in. Tap here to log out.";
            self.logInStatusText.textColor = UIColor.black
            self.logInStatusView.backgroundColor = UIColor.green
        }
        else {
            self.logInStatusText.text = "You are not logged in. Tap here to log in."
            self.logInStatusText.textColor = UIColor.white
            self.logInStatusView.backgroundColor = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0){
            return accounts.count;
        }
        else{
            return 1;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1) {
            let newAccountCellIdentifier = "newAccountCellIdentifier"
            var cell = tableView.dequeueReusableCell(withIdentifier: newAccountCellIdentifier)
            if (cell == nil){
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: newAccountCellIdentifier)
            }
            
            cell!.textLabel?.text = "Add new account...";
            
            return cell!;
        }
        else {
            let accountCellIdentifier = "accountCellIdentifier"
            var cell = tableView.dequeueReusableCell(withIdentifier: accountCellIdentifier)
            if (cell == nil){
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: accountCellIdentifier);
            }
            
            cell!.textLabel?.text = accounts[indexPath.row];
            
            return cell!;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 1){
            if (hasLoggedInToInstagram()) {
                self.performSegue(withIdentifier: SegueIdentifiers.AccountsToInstagramUserSearch.rawValue, sender: nil);
            }
            else{
                showInstagramLoginPrompt()
            }
        }
        else {
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func hasLoggedInToInstagram() -> Bool{
        
        if let _ = InstagramAPI.getAccessToken() {
            return true;
        }
        else {
            return false;
        }
    }
    
    func showInstagramLoginPrompt() {
        let alert = UIAlertController(title: "Attention", message: "In order to add a new user, you need to log in to Instagram. Continue?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelButton)
        let okButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { [weak self] (action) in
            self?.goToInstagramLogin()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToInstagramLogin(){
        self.performSegue(withIdentifier: SegueIdentifiers.AccountsToInstagramLogin.rawValue, sender: nil)
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
