//
//  TabBarViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit

let tbh = tabbarHandler()

class TabBarViewController: UITabBarController {
  @IBOutlet weak var tabBars: UITabBar!

  let addViewController = AddViewController()


    override func viewDidLoad() {
        super.viewDidLoad()

      self.tabBarController?.delegate = tbh

      tabBars.tintColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
      tabBars.unselectedItemTintColor = UIColor(red: 166.0/255.0, green: 128.0/255.0, blue: 132.0/255.0, alpha: 1.0)

    }
  


  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

  }


}

class tabbarHandler:NSObject, UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let vcIndex = tabBarController.viewControllers!.index(of: viewController)!
        if  vcIndex == 2 {
            let button1 = UIButton()
            button1.setTitle("Cancel", for: .normal)
            button1.layer.cornerRadius = 5
            button1.setTitleColor(UIColor.white, for: .normal)
            button1.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
            button1.backgroundColor = UIColor.lightGray

            let button2 = UIButton()
            button2.setTitle("Settings", for: .normal)
            button2.layer.cornerRadius = 5
            button2.backgroundColor = UIColor.lightGray
            button2.setTitleColor(UIColor.white, for: .normal)
            button2.addTarget(self, action: #selector(settingButtonPresssed(_:)), for: .touchUpInside)

            let sv = UIStackView(arrangedSubviews: [button1,button2])
            sv.distribution = .equalSpacing

            let currentView = tabBarController.selectedViewController!.view!
            sv.frame = CGRect(x: currentView.bounds.midX - 80, y: currentView.bounds.midY + 150, width: 160, height: 40)
            currentView.addSubview(sv)
          currentView.bringSubviewToFront(sv)
            return false
        }else{
            return true
        }
    }

    @objc func cancelButtonPressed(_ sender:UIButton) {
        if let parentStackView = sender.superview as? UIStackView {
            parentStackView.removeFromSuperview()
        }
    }
    @objc func settingButtonPresssed(_ sender:UIButton){
        if let parentStackView = sender.superview as? UIStackView {
            parentStackView.removeFromSuperview()
            if let tabBC = UIApplication.shared.windows[0].rootViewController as? UITabBarController {
                tabBC.selectedIndex = 2
            }
        }
    }
}
