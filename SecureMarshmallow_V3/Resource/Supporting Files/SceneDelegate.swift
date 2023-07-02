//import UIKit
//import IOSSecuritySuite
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        self.window = window
//
//        let viewController = TapBarViewController()
//        window.rootViewController = BaseNC(rootViewController: viewController)
//        window.makeKeyAndVisible()
//
//        let jailbreakStatus = IOSSecuritySuite.amIJailbrokenWithFailMessage()
//        if jailbreakStatus.jailbroken {
//            print("디바이스가 탈옥되어있습니다.")
//
//            let alert = UIAlertController(title: "탈옥", message: "이 기기는 탈옥되었습니다.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "닫기", style: .default) { _ in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    exit(0)
//                }
//            })
//
//            //탈옥 장치 판별
//            let jailbreakStatus = IOSSecuritySuite.amIJailbrokenWithFailedChecks()
//            if jailbreakStatus.jailbroken {
//                if (jailbreakStatus.failedChecks.contains { $0.check ==
//                    .existenceOfSuspiciousFiles }) && (jailbreakStatus.failedChecks.contains
//                                                       { $0.check == .suspiciousFilesCanBeOpened }) {
//                    print("이것은 실제 탈옥 장치입니다")
//                }
//            }
//
//            viewController.present(alert, animated: true, completion: nil)
//            print("사유: \(jailbreakStatus.failedChecks)")
//        } else if IOSSecuritySuite.amIRunInEmulator() {
//            print("시뮬레이터 입니다.")
//        } else {
//            print("이 디바이스는 안전합니다.")
//        }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        callBackgroundImage(false)
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        callBackgroundImage(true)
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        callBackgroundImage(false)
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        callBackgroundImage(true)
//        removeClocksInPast()
//        unscheduleAllClocks()
//        setNextClocks()
////        writeToFile(location: subUrl!) 보류
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }
//
//    func callBackgroundImage(_ isBackground: Bool) {
//
//            let TAG_BG_IMG = -101
//            let backgroundView = window?.viewWithTag(TAG_BG_IMG)
//
//            if isBackground {
//
//                if backgroundView == nil {
//
//                    let bgView = UIView()
//                    bgView.frame = UIScreen.main.bounds
//                    bgView.tag = TAG_BG_IMG
//                    bgView.backgroundColor = .secondarySystemBackground
//
//                    let appIcon = UIImageView()
//                    appIcon.frame = CGRect(x: bgView.layer.bounds.midX - 90, y: bgView.layer.bounds.midY - 90, width: 180, height: 180)
//                    appIcon.image = UIImage(named: "logo1")
//                    bgView.addSubview(appIcon)
//
//                    window?.addSubview(bgView)
//                }
//            } else {
//
//                if let backgroundView = backgroundView {
//                    backgroundView.removeFromSuperview()
//                }
//            }
//        }
//
//    // MARK: Functions
//
//    private func setNextClocks() {
//        for clock in clocks {
//            if (clock.isActivated) {
//                scheduleClock(clockId: clock.id)
//            }
//        }
//    }
//
//    private func registerLocal() {
//        let center = UNUserNotificationCenter.current()
//
//        center.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in
//            if granted {
//                print("User notifications were granted")
//            } else {
//                print("User notifications not granted")
//            }
//        }
//    }
//
//    private func unscheduleAllClocks() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//    }
//
//    private func findNextRingDate(ringDates: [DateComponents]) -> DateComponents {
//        var nextDate = ringDates[0]
//        for date in ringDates {
//            if (date < nextDate) {
//                nextDate = date
//            }
//        }
//        print("next date \(nextDate)")
//
//        return nextDate
//    }
//
//    private func scheduleClock(clockId: UUID) {
//        let clockIndex = clocks.firstIndex(where: {$0.id == clockId})
//        let clock = clocks[clockIndex!]
//        let center = UNUserNotificationCenter.current()
//
//
//        if (clock.ringDays.isEmpty) { return }
//        let nextDate = findNextRingDate(ringDates: clock.ringDays)
//        let ringDate = DateComponents(calendar: Calendar.current, year: nextDate.year, month: nextDate.month, day: nextDate.day, hour: clock.ringTime.hour, minute: clock.ringTime.minute)
//        print(ringDate)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: ringDate, repeats: false)
//
//        let content = UNMutableNotificationContent()
//        content.title = clock.name
//        content.body = "get ready for a great new day"
//        content.categoryIdentifier = "myIdentifier"
//        content.userInfo = ["Id": 7]
//
//        if (clock.selectedRingtone[0] == true) {
//            content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName(rawValue: "bell.mp3"))
//        }
//        else if (clock.selectedRingtone[1] == true) {
//            content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName(rawValue: "tickle.mp3"))
//        }
//
//        clocks[clockIndex!].notificationId = UUID().uuidString
//
//        let request = UNNotificationRequest(identifier: clock.notificationId, content: content, trigger: trigger)
//        center.add(request)
//    }
//
//
//}
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        registerLocal()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = BaseNC(rootViewController: TapBarViewController())
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    // MARK: Functions

    private func setNextClocks() {
        for clock in clocks {
            if (clock.isActivated) {
                scheduleClock(clockId: clock.id)
            }
        }
    }
    
    private func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in
            if granted {
                print("User notifications were granted")
            } else {
                print("User notifications not granted")
            }
        }
    }
    
    private func unscheduleAllClocks() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    private func findNextRingDate(ringDates: [DateComponents]) -> DateComponents {
        var nextDate = ringDates[0]
        for date in ringDates {
            if (date < nextDate) {
                nextDate = date
            }
        }
        print("next date \(nextDate)")

        return nextDate
    }
    
    private func scheduleClock(clockId: UUID) {
        let clockIndex = clocks.firstIndex(where: {$0.id == clockId})
        let clock = clocks[clockIndex!]
        let center = UNUserNotificationCenter.current()
        

        if (clock.ringDays.isEmpty) { return }
        let nextDate = findNextRingDate(ringDates: clock.ringDays)
        let ringDate = DateComponents(calendar: Calendar.current, year: nextDate.year, month: nextDate.month, day: nextDate.day, hour: clock.ringTime.hour, minute: clock.ringTime.minute)
        print(ringDate)

        let trigger = UNCalendarNotificationTrigger(dateMatching: ringDate, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = clock.name
        content.body = "get ready for a great new day"
        content.categoryIdentifier = "myIdentifier"
        content.userInfo = ["Id": 7]
        
        if (clock.selectedRingtone[0] == true) {
            content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName(rawValue: "bell.mp3"))
        }
        else if (clock.selectedRingtone[1] == true) {
            content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName(rawValue: "tickle.mp3"))
        }
        
        clocks[clockIndex!].notificationId = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: clock.notificationId, content: content, trigger: trigger)
        center.add(request)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        removeClocksInPast()
        unscheduleAllClocks()
        setNextClocks()
        writeToFile(location: subUrl!)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


