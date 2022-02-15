//
//  SceneDelegate.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit
import Then

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabViewArray = [HomeViewController(), ChatViewController(), VoomViewController(), CallViewController()]
        let navigationControllerArray = tabViewArray.map {
            CustomNavigationController(rootViewController: $0)
        }
        
        zip(tabViewArray, zip([
            "홈", "대화", "VOOM", "통화"
        ], [
            [UIImage(systemName: "house"), UIImage(systemName: "house.fill")],
            [UIImage(systemName: "message"), UIImage(systemName: "message.fill")],
            [UIImage(systemName: "play"), UIImage(systemName: "play.fill")],
            [UIImage(systemName: "phone"), UIImage(systemName: "phone.fill")],
        ].map {
            $0.map {
                $0!.forTabbarItem
            }
        }).map {
            UITabBarItem(title: $0, image: $1[0], selectedImage: $1[1]).then {
                $0.setTitleTextAttributes([.font : UIFont.forTabBarItemTitle], for: .normal)
            }
        }).forEach {
            $0.0.tabBarItem = $0.1
        }
        
        UITabBar.appearance().backgroundColor = .background
        
        let tabbarController = UITabBarController().then {
            $0.tabBar.tintColor = .white
            $0.tabBar.unselectedItemTintColor = .white
            $0.tabBar.barTintColor = .background
            $0.tabBar.isTranslucent = false
            
            $0.setViewControllers(navigationControllerArray, animated: false)
        }
        
        /*
         for test
         */
        test()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabbarController
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

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func test() {
        let imageArray = [
            UIImage(systemName: "flame.circle")!,
            UIImage(systemName: "person.circle")!,
            UIImage(systemName: "person.crop.circle")!,
            UIImage(systemName: "circle.circle")!,
            UIImage(systemName: "graduationcap.circle")!,
            UIImage(systemName: "drop.circle")!,
            UIImage(systemName: "stop.circle")!,
        ]
        
        [
            "권오승",
            "김민서소영",
            "김시본",
//            "깡견",
            "린파나요우",
            "맹돌이",
            "배현규",
            "성재혁",
            "소라",
            "신승철",
            "안지섭",
            "용현석",
            "유현준",
            "윤봉준",
            "이가연",
            "이건우",
            "이재봉",
            "진영",
            "휘창",
            "Amy Kim",
            "ash",
            "Baek Gayoung",
            "COKE",
            "DKDK",
            "Ejin",
            "English teacher",
            "H",
            "ht",
            "Jason",
            "JS",
            "Maria Alejandra Kwon",
            "TJ",
            "Yejin Jo",
            "YeongJaeKo",
            "..",
            "ウジュ",
            "😱😱😱",
        ].shuffled().map {
            Friend(image: imageArray.randomElement()!, name: $0)
        }.forEach {
            FriendList.shared.friendArray.append($0)
        }
        
        let friend1 = Friend(image: imageArray.randomElement()!, name: "일이삼사오육칠팔구십일이삼사오육칠팔구십")
        [
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Date().startOfDay, parent: friend1),
            Friend.CallHistory(type: .voice, from: .sender(.cancelled), date: Date(), parent: friend1),
            Friend.CallHistory(type: .voice, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!, parent: friend1),
            Friend.CallHistory(type: .voice, from: .sender(.cancelled), date: Date().previousDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .sender(.called(5)), date: Calendar.current.date(byAdding: .hour, value: 5, to: Date())!, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(71)), date: Date().previousDay.previousDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(31)), date: Date().previousDay.previousDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(100)), date: Date().previousDay.previousDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(1000)), date: Date().previousDay.previousDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(10000)), date: Date().previousDay.previousDay, parent: friend1),
            Friend.CallHistory(type: .voice, from: .receiver(.missed), date: Date().previousDay.previousDay.startOfDay, parent: friend1),
            Friend.CallHistory(type: .video, from: .receiver(.called(3700)), date: Date().previousDay.previousDay.previousDay, parent: friend1),
        ].forEach {
            friend1.callHistory.append($0)
        }
        FriendList.shared.friendArray.append(friend1)
        
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
            $0.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        }
        
        let friend2 = Friend(image: imageArray.randomElement()!, name: "동주")
        [
            Friend.CallHistory(type: .voice, from: .sender(.cancelled), date: dateFormatter.date(from: "2022-02-09 12:15:00")!, parent: friend2),
            Friend.CallHistory(type: .voice, from: .sender(.cancelled), date: dateFormatter.date(from: "2022-02-09 11:28:00")!, parent: friend2),
        ].forEach {
            friend2.callHistory.append($0)
        }
//        FriendList.shared.friendArray.append(friend2)
        
        let friend3 = Friend(image: imageArray.randomElement()!, name: "일이삼사오육칠팔구십일이삼사오육칠팔구십")
        [
            Friend.CallHistory(type: .video, from: .receiver(.missed), date: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!, parent: friend3),
        ].forEach {
            friend3.callHistory.append($0)
        }
        FriendList.shared.friendArray.append(friend3)
        
        let friend4 = Friend(image: imageArray.randomElement()!, name: "일이삼사오육칠팔구십일이삼사오육칠팔구십")
        [
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
            Friend.CallHistory(type: .video, from: .sender(.cancelled), date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, parent: friend4),
        ].forEach {
            friend4.callHistory.append($0)
        }
        FriendList.shared.friendArray.append(friend4)
    }
}
