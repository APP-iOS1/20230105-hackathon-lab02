//
//  BundleExtension.swift
//  AwesomeKoreanDictionary
//
//  Created by 박제균 on 2023/01/05.
//

import Foundation

extension Bundle {
    
    var CLIENT_ID: String {
        guard let file = self.path(forResource: "APIInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["CLIENT_ID"] as? String else { return "" }
        return key
    }
    
    var CLIENT_SECRET: String {
        guard let file = self.path(forResource: "APIInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["CLIENT_SECRET"] as? String else { return "" }
        return key
    }
    
}
