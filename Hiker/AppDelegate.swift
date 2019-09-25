//
//  AppDelegate.swift
//  Hiker
//
//  Created by 张驰 on 2019/9/9.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import EachNavigationBar

import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        let rootVc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
//        UIApplication.shared.keyWindow?.rootViewController = rootVc
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
        if getToken() != nil {
            let mainTabVar = self.mainTabBar()
            window?.rootViewController = mainTabVar
            window?.makeKeyAndVisible()
            print("已经拥有账号")
        }else {
        
            let rootViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateInitialViewController()!
            let loginVC = MainNavigationController.init(rootViewController: rootViewController)
            loginVC.navigation.configuration.isEnabled = true
            self.window!.rootViewController = loginVC
            
            print("没有,进入登录界面初始化")
        }
        
        


        
//        UIApplication.shared.keyWindow?.rootViewController = rootVc
//        UIApplication.shared.keyWindow?.makeKeyAndVisible()

//         window?.rootViewController = rootVc
//         window?.makeKeyAndVisible()
//        let mainTabVar = mainTabBar()
//        window?.rootViewController = mainTabVar
//        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    func mainTabBar() -> UITabBarController {
        let homeVC = HKHomeViewController()
        let noteVC = UIViewController()
        let mineVC = HKMineViewController()
        
        homeVC.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "home_tab_unselected"), selectedImage: UIImage(named: "home_tab_selected"))
        

        mineVC.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "mine_tab_unselected"), selectedImage: UIImage(named: "mine_tab_selected"))
        
        noteVC.tabBarItem = ESTabBarItem.init(CenterTabBarItem(), title: nil, image: UIImage(named: "add_tab"), selectedImage: UIImage(named: "add_tab"))
       

        let homeNav = MainNavigationController.init(rootViewController: homeVC)
        let mineNav = MainNavigationController.init(rootViewController: mineVC)
        let noteNav = MainNavigationController.init(rootViewController: noteVC)
        
        
        homeNav.navigation.configuration.isEnabled = true
        homeNav.navigation.configuration.barTintColor = backColor
        homeNav.navigation.configuration.tintColor = backColor
        
        mineNav.navigation.configuration.isEnabled = true
        mineNav.navigation.configuration.barTintColor = .white
        mineNav.navigation.configuration.tintColor = .white
        
        
        
        if #available(iOS 11.0, *) {
            homeNav.navigation.prefersLargeTitles()
        }
        if #available(iOS 11.0, *) {
            mineNav.navigation.prefersLargeTitles()
        }


         let tabBarController = ESTabBarController()
        tabBarController.tabBar.shadowImage = UIImage(named: "tabbarColor")
        tabBarController.tabBar.backgroundImage = UIImage(named: "tabColor")
        tabBarController.tabBar.backgroundColor = .white
        

        
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let notesVC = TitleController()
                let noteNav = MainNavigationController.init(rootViewController: notesVC)
                noteNav.navigation.configuration.isEnabled = true
                noteNav.navigation.configuration.barTintColor = .white
                noteNav.navigation.configuration.tintColor = .white
                tabBarController?.present(noteNav, animated: true, completion: nil)
            }
        }
        tabBarController.viewControllers = [homeNav,noteNav,mineNav]
        tabBarController.viewControllers?.first?.tabBarItem.imageInsets =  UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        tabBarController.viewControllers?.last?.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        return tabBarController
    }
    

}

