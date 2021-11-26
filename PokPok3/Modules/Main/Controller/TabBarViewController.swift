//
//  TabBarViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit

class TabBarViewController: UITabBarController {
  @IBOutlet weak var tabBars: UITabBar!

  let addViewController = AddViewController()


    override func viewDidLoad() {
        super.viewDidLoad()

      tabBars.tintColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
      tabBars.unselectedItemTintColor = UIColor(red: 166.0/255.0, green: 128.0/255.0, blue: 132.0/255.0, alpha: 1.0)

      addViewController.modalPresentationStyle = .popover
      // Do any additional setup after loading the view.
    }


  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item == tabBars.items?[2] {
      addViewController.modalPresentationStyle = .popover
    } else {

    }
  }


}
