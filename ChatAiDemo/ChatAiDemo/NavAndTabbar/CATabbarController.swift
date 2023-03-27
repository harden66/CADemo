//
//  CATabbarController.swift
//  ChatAiDemo
//
//  Created by JC Harden on 2023/3/22.
//

import UIKit

class CATabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabbar()
    }
    
    func initTabbar() {
        let chatNav = UINavigationController(rootViewController: ViewController())
        chatNav.tabBarItem.title = "聊天"
        chatNav.tabBarItem.image = UIImage(named: "icon_tabbar_chat_normal")
        
        let creationNav = UINavigationController(rootViewController: ViewController())
        creationNav.tabBarItem.title = "创作"
        creationNav.tabBarItem.image = UIImage(named: "icon_tabbar_creation_normal")
        
        viewControllers = [chatNav, creationNav]
        
        setTabBarItemAttributes(bgColor: UIColor.black/*UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)*/)
    }
    
    func setTabBarItemAttributes(fontName: String = "Courier",
                                 fontSize: CGFloat = 14,
                                 normalColor: UIColor = .gray,
                                 selectedColor: UIColor = .red,
                                 bgColor: UIColor = .black) {
        // tabBarItem 文字大小
        var attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: fontSize)!]
        
        // tabBarItem 文字默认颜色
        attributes[.foregroundColor] = normalColor
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
        // tabBarItem 文字选中颜色
        attributes[.foregroundColor] = selectedColor
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        
        // tabBar 文字、图片 统一选中高亮色
        tabBar.tintColor = selectedColor
        
        // tabBar 背景色
//        tabBar.barTintColor = bgColor
        
        let tabbarAppearance = UITabBarAppearance()
           tabbarAppearance.configureWithOpaqueBackground()
           tabbarAppearance.backgroundColor = .black
        self.tabBar.standardAppearance = tabbarAppearance
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
//        UITabBar.appearance().standardAppearance = tabbarAppearance
    }
}
