//
//  URLSessionProtocol.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

typealias DataTaskResult = (NSData?, URLResponse?, NSError?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(url: URL, completionHandler: (NSData?, URLResponse?, NSError?) -> Void) -> URLSessionDataTask {
        return dataTaskWithURL(url: url, completionHandler: completionHandler)
    }
}
