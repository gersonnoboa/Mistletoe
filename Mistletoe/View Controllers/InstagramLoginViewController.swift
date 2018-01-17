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

class InstagramLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.navigationDelegate = self
        loadWebView()
        definesPresentationContext = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadWebView() {
        let url = URL(string: InstagramAPI.authURL)
        //let url = URL(string: "http:pizza")
        let request = URLRequest(url: url!)
        self.webView.load(request)
        UIHelper.Loading.show()
        
    }

}

extension InstagramLoginViewController: WKNavigationDelegate {
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
        
        if let url = navigationAction.request.url {
            let stringURL = url.absoluteString
            if stringURL.hasPrefix(InstagramAPI.redirectURL){
                UIHelper.Loading.hide()
                webView.stopLoading()
                webView.navigationDelegate = nil
                decisionHandler(.cancel)
                let range: Range<String.Index> = stringURL.range(of: "#access_token=")!
                let authToken = stringURL[range.upperBound...]
                
                InstagramAPI.setAccessToken(token: String(authToken))
                UIHelper.showSuccessAlert(vc: self, message: nil, successBlock: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                })
            }
            else {
                decisionHandler(.allow);
            }
        }
        else{
            decisionHandler(.allow)
        }
    }
}
