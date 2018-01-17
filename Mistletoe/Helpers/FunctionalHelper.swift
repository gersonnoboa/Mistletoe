//
//  FunctionalHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 17/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit
import WebKit

class FunctionalHelper {

    static func deleteCookies() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("instagram") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                    })
                }
            }
        }
    }
}
