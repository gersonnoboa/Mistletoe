//
//  AccountsViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit
import SDWebImage

class AccountsViewController: UIViewController, TintedNavigationBar {

    let accountsCellIdentifier = "Accounts"
    let addNewAccountCellIdentifier = "AddNewAccount"
    
    var accounts: [InstagramUser] = []
    @IBOutlet weak var logInStatusText: UILabel!
    @IBOutlet weak var logInStatusView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var logInStatusViewTapRecognizer: UITapGestureRecognizer!
    
    let httpClient = HTTPClient.def()
    
    private var presentingInstagramUser: InstagramUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mistletoe";
        self.standarizeBackButtonItem()
        
        configureLogInStatusView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineLogInStatus()
        loadAccounts()
    }
    
    func loadAccounts() {
        if let accs = InstagramAccountsHelper.getAccounts() {
            self.accounts = accs
        }
        else{
            self.accounts = []
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func hasLoggedInToInstagram() -> Bool{
        
        if let _ = InstagramAPI.getAccessToken() {
            return true;
        }
        else {
            return false;
        }
    }
    
    func logOutOfInstagram() {
        
        UIHelper.Alert.confirmation(vc: self, message: "Are you sure you want to log out?") { [weak self] in
            self?.executeLogOutOfInstagram()
        }
    }
    
    func executeLogOutOfInstagram() {
        InstagramAPI.setAccessToken(token: nil)
        self.determineLogInStatus()
        UIHelper.Alert.success(vc: self, message: nil)
        FunctionalHelper.deleteCookies()
        InstagramAccountsHelper.deleteAccounts()
        self.loadAccounts()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == SegueIdentifiers.AccountsToInstagramUserPhotos.rawValue) {
            let vc = segue.destination as! InstagramUserPhotosViewController
            vc.user = self.presentingInstagramUser
        }
    }
    
    @IBAction func deleteAccount(_ sender: UIImageView?) {
        UIHelper.Alert.confirmation(vc: self, message: "Are you sure you want to delete this account?") { [weak self] in
            self?.executeDeleteAccount(senderTag: sender?.tag)
        }
    }
    
    func executeDeleteAccount(senderTag: Int?) {
        guard let tag = senderTag else {
            UIHelper.Alert.error(vc: self)
            return
        }
        
        let account = self.accounts[tag]
        guard let index = self.accounts.index(of: account) else {
            UIHelper.Alert.error(vc: self)
            return
        }
        
        self.accounts.remove(at: index)
        InstagramAccountsHelper.setAccounts(accounts: self.accounts)
        loadAccounts()
        UIHelper.Alert.success(vc: self, message: nil)
    }
    
}

extension AccountsViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.addNewAccountCellIdentifier)
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.accountsCellIdentifier) as! AccountsTableViewCell
            let user = accounts[indexPath.row]
            cell.title?.text = user.username;
            cell.subtitle?.text = user.fullName
            
            let url = URL(string: user.profilePicture)
            cell.profilePicture?.sd_setImage(with: url, placeholderImage: UIImage(named: "Placeholder"))
            cell.delete.tag = indexPath.row
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && self.accounts.count > 0 {
            return "Accounts you are following"
        }
        else if section == 1 {
            return "Operations"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 && self.accounts.count == 0 {
            return 1
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension AccountsViewController: UITableViewDelegate {
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
            self.presentingInstagramUser = self.accounts[indexPath.row]
            self.performSegue(withIdentifier: SegueIdentifiers.AccountsToInstagramUserPhotos.rawValue, sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
