//
//  ContentView.swift
//  trry
//
//  Created by sumayah on 12/05/1444 AH.
//

import SwiftUI
import UserNotifications

class NotificationManager{
    static let instance = NotificationManager()
    
    
    func scheduleNotification(hour: Int,minute: Int){
        
        let center = UNUserNotificationCenter.current()
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (success, error)in
            guard error != nil else { return }
        }
        let content = UNMutableNotificationContent()
        content.title = "تذكير بموعد الدواء"
        content.subtitle = "حان وقت الدواء  "
        content.sound = .default
        content.badge = 0
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
struct ContentView: View {
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack (spacing : 40) {
            DatePicker("Select a Date" , selection: $selectedDate)
            
            
            Button("Schedule Notification"){
                let components = Calendar.current.dateComponents([.hour , .minute], from: selectedDate)
                
                print(selectedDate)
                let hours = components.hour ?? 0
                let minute = components.minute ?? 0
                print(hours)
                print(minute)
                
                NotificationManager.instance.scheduleNotification(hour: hours, minute: minute)
                
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
