//
//  InstagramLoginViewController.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class InstagramLoginViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        loadWebView()
        // Do any additional setup after loading the view.
    }

    func loadWebView() {
        let url = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(AccessKeys.InstagramClientID)&redirect_uri=REDIRECT-URI&response_type=code")
        //let url = URL(string: "http:pizza")
        let request = URLRequest(url: url!)
        self.webView.load(request)
        UIHelper.Loading.show()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIHelper.Loading.hide()
        UIHelper.showNetworkingError(vc: self, shouldPop: true) { [weak self] () -> (Void) in
            self?.loadWebView()
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIHelper.Loading.hide()
        UIHelper.showNetworkingError(vc: self, shouldPop: true) { [weak self] () -> (Void) in
            self?.loadWebView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIHelper.Loading.hide()
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
