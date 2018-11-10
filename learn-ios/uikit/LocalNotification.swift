/*
 
 1. 需要到 AppDelegate 中注册通知
 https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649527-requestauthorization
 Always call this method before scheduling any local notifications and before registering with the Apple Push Notification service.
 Typically, you call this method at launch time when configuring your app's notification support.
 
 2. 通知只有在应用处于后台时才会发生，前台激活状态时不会发生
 
 UNTimeIntervalNotificationTrigger 在一个指定的时间内，发起推送
 UNCalendarNotificationTrigger 在指定的日期时间发起推送，比如 周一 8:30 发起一个通知，去上班；或者每周一都通知，此时 repeats:true
 UNLocationNotificationTrigger 在到达某个地方时，发起推送，比如高德地图到达目的地
 */

import UIKit
import UserNotifications

class LocalNotification: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // 示例 1
        registerUserNotification()

        // 简单事件
        self.simpleDemo()
        // 示例 2 更新图标
        self.updateApplicationIconBadgeNumber()
    }
    
    deinit {
        removeNotification()
    }
}

//extension LocalNotification {
//    func uiLocalDemo() {
//        // 在 ios10 之后， UILocalNotification 就被 UserNotifications 框架替换
//        // 在 ios12 中使用下面的代码，提示 "MGIsDeviceOneOfType is not supported on this platform"
//        let notification = UILocalNotification()
//        notification.alertBody = "通知内容"
//        notification.soundName = UILocalNotificationDefaultSoundName
//        notification.alertAction = "打开应用(可选)"
//        notification.applicationIconBadgeNumber = 2 // 应用程序图标右上角显示的消息数
//        notification.userInfo = ["id":"1"] // 通知上绑定的信息
//        // 立即显示通知
//        UIApplication.shared.presentLocalNotificationNow(notification)
//        // 10s 后再显示
//        notification.fireDate = NSDate().addingTimeInterval(10) as Date
//        //        UIApplication.shared.scheduleLocalNotification(notification)
//    }
//}

extension LocalNotification {
    
    func updateApplicationIconBadgeNumber() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Elon said", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello Tom!Get up, let's play with Jerry!", arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        content.categoryIdentifier = "com.localNotification"
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10.0, repeats: false)
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print("updateApplicationIconBadgeNumber:\(String(describing: error))")
        }
    }
}


extension LocalNotification : UNUserNotificationCenterDelegate {
    
    func registerUserNotification() {
        //  授权必须在 AppDelegate 中完成
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("有授权")
            } else {
                // For example, if authorization was denied, you might notify a remote notification server not to send notifications to the user’s device.
                // 通知远程服务器不要向用户发送通知
                print("没有授权:\(String(describing: error))")
            }
        }
        center.getNotificationSettings { (settings) in
            // https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649524-getnotificationsettings
            // settings https://developer.apple.com/documentation/usernotifications/unnotificationsettings
            // 检测用户对通知所作用的修改
            print("notification settings:\(settings)")
        }
    }
    
    func notificationId() -> String {
        return "hello"
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationId()])
    }
    
    func scheduleNotification() {
        removeNotification()
        
        let content = UNMutableNotificationContent()
        content.title = "标题:"
        content.body = "这里是通知的正文"
        content.sound = UNNotificationSound.default
        
        let calender = Calendar(identifier: .gregorian)
        // todo 这里的时间没有设置好
        let dueDate = Date()
        let components = calender.dateComponents([.month, .day, .hour, .minute], from:dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest.init(identifier: notificationId(), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    
    func simpleDemo() {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "I am a local notification"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: notificationId(), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Received local notification")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Open setting for")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("will Present")
    }
}
