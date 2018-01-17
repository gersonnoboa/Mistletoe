//
//  Keys.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 13/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

struct InstagramAPI {
    static let accessTokenIdentifier = "AccessTokenIdentifier"
    
    static private let clientID = "97f487ad1b254d408856f58ceb1d69f2"
    static let redirectURL = "https://www.heavenlapse.com"
    static let authURL = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURL)&response_type=token&scope=public_content"
}

extension InstagramAPI {
    static func userSearch(query: String, token: String) -> String {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
        return "https://api.instagram.com/v1/users/search?q=\(encodedQuery)&access_token=\(token)&count=10"
    }
    
    static func getAccessToken() -> String? {
        return UserDefaultsHelper.getString(key: accessTokenIdentifier)
    }
    
    static func setAccessToken(token: String?) {
        UserDefaultsHelper.setString(key: accessTokenIdentifier, value: token)
    }
}
