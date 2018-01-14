//
//  HTTPClient.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

typealias HTTPResult = (NSData?, Error?) -> Void

class HTTPClient {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession()) {
        self.session = session;
    }
    
    func get(url: URL, completion: HTTPResult) {
        let dataTask = session.dataTaskWithURL(url: url) { (data, response, error) in
            completion(data, error)
        }
        dataTask.resume()
        
    }
    
    
}
