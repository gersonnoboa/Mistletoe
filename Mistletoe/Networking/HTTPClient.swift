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
    
    func get(url: String, completion: @escaping HTTPResult) {
        let u = URL(string: url)!
        
        let dataTask = session.dataTaskWithURL(with: u) { (data, response, error) in
            completion(data as Data?, error)
        }
        dataTask.resume()
        
    }
    
    
}
