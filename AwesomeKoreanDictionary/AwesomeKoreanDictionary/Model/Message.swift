//
//  Response.swift
//  AwesomeKoreanDictionary
//
//  Created by 박제균 on 2023/01/05.
//

import Foundation

struct Message: Decodable {

    let type: String
    let service: String
    let version: String
    let result: Result

    enum CodingKeys: String, CodingKey {
        case result
        case type = "@type"
        case service = "@service"
        case version = "@version"
    }
}

struct Result: Decodable {
    let translatedText: String
}

struct TranslateResponse: Decodable {
    let message: Message
}

