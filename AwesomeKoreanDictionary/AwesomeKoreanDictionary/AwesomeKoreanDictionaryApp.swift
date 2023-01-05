//
//  AwesomeKoreanDictionaryApp.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AwesomeKoreanDictionaryApp: App {
    @StateObject var authManager = AuthManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {

            MainView()
            .environmentObject(VocabularyNetworkManager())
            .environmentObject(authManager)
            .environmentObject(UserInfoManager())

        }
    }
}
