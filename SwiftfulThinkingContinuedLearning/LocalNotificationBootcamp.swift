//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Ifeanyi Ahumareze on 01/10/2023.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { succes, err in
            //do something
            if let err = err{
                print("Error: \(err)")
            }else{
                print("Success: \(succes)")
            }
        }
    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was so easy"
        content.sound = .defaultRingtone
        content.badge = 1
        
        //time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 29
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true);
        
        //location
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
