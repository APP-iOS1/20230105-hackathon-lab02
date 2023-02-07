//
//  AwesomeKoreanDictionaryApp.swift
//  AwesomeKoreanDictionary
//
//  Created by Yooj on 2023/01/05.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      
      do {
          //             Configure and activate the AVAudioSession
          try AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.duckOthers
          )
          
          try AVAudioSession.sharedInstance().setActive(true)
          
      }
      catch {
          // Handle error
      }

    return true
  }
}

@main
struct AwesomeKoreanDictionaryApp: App {
    // TODO: - auth+userInfo
    @StateObject private var dataController = DataController()
    @StateObject var authManager = AuthManager()
    @StateObject var userInfoManager = UserInfoManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(VocabularyNetworkManager())
            .environmentObject(authManager)
            .environmentObject(userInfoManager)
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
