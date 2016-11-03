//
//  XKTabBarController.swift
//  TodayNews
//
//  Created by 星空浩 on 2016/10/26.
//  Copyright © 2016年 DFYG_YF3. All rights reserved.
//

import UIKit

class XKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addchildViewControllers()
        
    }
    override class func initialize(){
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.red
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addchildViewControllers(){
//        let homeVC = HomeViewController()
        addChildViewController(childController: XKScrollViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
        addChildViewController(childController: VideoViewContoller(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
        addChildViewController(childController: NewCareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
        addChildViewController(childController: MineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }
    func addChildViewController(childController: UIViewController,title:String, imageName:String,selectedImageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.tabBarItem.title = title
        let nav = XKNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    

}
