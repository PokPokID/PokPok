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
