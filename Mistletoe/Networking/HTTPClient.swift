//
//  HTTPClient.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

typealias HTTPResult = (Data?, Error?) -> Void

class HTTPClient {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session;
    }
    
    static func def() -> HTTPClient {
        return HTTPClient(session: URLSession.shared)
    }
    
    func get(url: String, completion: @escaping HTTPResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let u = URL(string: url)!
        
        let dataTask = session.dataTaskWithURL(with: u) { (data, response, error) in
            completion(data as Data?, error)
            UIHelper.executeInMainQueue {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        dataTask.resume()
        
    }
    
    func getImage(url: String, imageView: UIImageView?, completion: HTTPResult? = nil) {
        
        guard let imageView = imageView else { return }
        get(url: url) { (data, error) in
            guard let data = data else { return }
            UIHelper.executeInMainQueue {
                completion?(data, error)
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    func cancelAllRequests() {
        if (self.session is URLSession) {
            (self.session as! URLSession).getAllTasks(completionHandler: { (tasks) in
                for task in tasks {
                    task.cancel()
                }
            })
        }
    }
    
    
}
