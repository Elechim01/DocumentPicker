//
//  DocumentPickerApp.swift
//  DocumentPicker
//
//  Created by Michele Manniello on 14/08/21.
//

import SwiftUI
import Firebase

@main
struct DocumentPickerApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class Delegate: NSObject,UIApplicationDelegate{
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Needed For Phone Auth
    }
}
