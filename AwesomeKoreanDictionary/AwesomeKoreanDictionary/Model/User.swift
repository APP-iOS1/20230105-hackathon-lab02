//
//  User.swift
//  AwesomeKoreanDictionary
//
//  Created by 추현호 on 2023/01/05.
//

import Foundation

struct User {
    var id: String
    var isAdmin: Bool // 관리자페이지에서 로그인할 때 필요한 프로퍼티
    var userNickname: String // 단어 등록할 때 보여줄 닉네임
    var userEmail: String // gmail
}
