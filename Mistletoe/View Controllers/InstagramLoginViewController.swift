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
        let url = URL(string: InstagramAPI.authURL)
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else { return }
        NSLog("url \(url)")
        
        let stringURL = url.absoluteString
        if stringURL.hasPrefix(InstagramAPI.redirectURL){
            let range: Range<String.Index> = stringURL.range(of: "#access_token=")!
            let authToken = stringURL[range.upperBound...]
            NSLog(String(authToken))
            
            UserDefaultsHelper.saveAccessToken(token: String(authToken))
            UIHelper.showSuccessAlert(vc: self)
        }
        decisionHandler(.allow);
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