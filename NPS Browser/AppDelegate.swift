//
//  AppDelegate.swift
//  NPS Browser
//
//  Created by JK3Y on 4/28/18.
//  Copyright © 2018 JK3Y. All rights reserved.
//

import Cocoa
import SwiftyBeaver
import RealmSwift
import SwiftyUserDefaults
import UserNotifications

let log = SwiftyBeaver.self

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    
    lazy var downloadManager: DownloadManager = DownloadManager()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        setupSwiftyBeaverLogging()
        // Helpers.setupDownloadsDirectory()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        downloadManager.stopAndStoreDownloadList()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func setupSwiftyBeaverLogging() {
        let console = ConsoleDestination()
        let file = FileDestination()

        log.addDestination(console)
        log.addDestination(file)
    }
    
    // MARK: - Notifications
    
    func showNotification(title: String, subtitle: String) {
      let content = UNMutableNotificationContent()
      content.title = title
      content.subtitle = subtitle
      content.sound = UNNotificationSound.default

      let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: nil) // You can also use UNTimeIntervalNotificationTrigger for timed notifications
      UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
          print("Error showing notification: \(error)")
        }
      }
    }
    
    // Delegate method for notification presentation (optional)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      // Customize notification presentation here
      completionHandler([.banner, .sound]) // Allow banner and sound
    }
}

