//
//  ViewController.swift
//  LocalPushNotification
//
//  Created by Neosoft on 11/10/23.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkForPermission()
    }
    
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert,.sound]) { didAllow, error in
                    if didAllow{
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }

    func dispatchNotification(){
        let identifier = "Greeting"
        let title = "Mai Bola"
        let body = "Kaisa hai Bro"
        let isDaily = true

        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body

        let hour = 11
        let minutes = 35
        let calender = Calendar.current
        var dateComponents = DateComponents(calendar: calender,timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minutes

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier:identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }

    @IBAction func btnTapped(_ sender: UIButton) {
//        checkForPermission()
    }
}

