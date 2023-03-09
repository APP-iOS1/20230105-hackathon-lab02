//
//  ColorExtension.swift
//  AwesomeKoreanDictionary
//
//  Created by 이소영 on 2023/01/06.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
    
    
    static let AKDBlack = Color("AKDBlack")
    static let AKDWhite = Color("AKDWhite")
    static let AKDGray = Color("AKDGray")

}
