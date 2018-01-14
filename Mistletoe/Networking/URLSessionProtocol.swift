//
//  URLSessionProtocol.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
    func dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task:URLSessionDataTask = dataTask(with: url, completionHandler: {
            (data:Data?, response:URLResponse?, error:Error?) in completionHandler(data,response,error) }) as URLSessionDataTask;
        return task
        
    }
    
}
