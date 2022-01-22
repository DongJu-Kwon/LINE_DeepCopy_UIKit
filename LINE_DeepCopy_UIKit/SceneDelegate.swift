//
//  SceneDelegate.swift
//  LINE_DeepCopy_UIKit
//
//  Created by 권동주 on 2022/01/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabbarController = UITabBarController()
        
        let tabViewArray = [HomeViewController(), ChatViewController(), VoomViewController(), CallViewController()]
        let navigationControllerArray = tabViewArray.map {
            CustomNavigationController(rootViewController: $0)
        }
        
        tabViewArray[0].tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        tabViewArray[1].tabBarItem = UITabBarItem(title: "대화", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        tabViewArray[2].tabBarItem = UITabBarItem(title: "VOOM", image: UIImage(systemName: "play"), selectedImage: UIImage(systemName: "play.fill"))
        tabViewArray[3].tabBarItem = UITabBarItem(title: "통화", image: UIImage(systemName: "phone"), selectedImage: UIImage(systemName: "phone.fill"))
        
        tabViewArray.forEach {
            $0.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.forTabBarItemTitle], for: .normal)
        }
        
        tabbarController.tabBar.tintColor = .white
        tabbarController.tabBar.unselectedItemTintColor = .white
        tabbarController.tabBar.barTintColor = .background
        tabbarController.tabBar.isTranslucent = false
        
        tabbarController.setViewControllers(navigationControllerArray, animated: false)
        
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


}

