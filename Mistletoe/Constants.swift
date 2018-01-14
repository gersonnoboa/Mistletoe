//
//  Keys.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

struct InstagramAPI {
    static private let clientID = "97f487ad1b254d408856f58ceb1d69f2"
    static let redirectURL = "http://www.heavenlapse.com"
    static let authURL = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURL)&response_type=token"
}
