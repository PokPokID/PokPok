//
//  DetailWishingWellViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 27/11/21.
//

import UIKit

class DetailWishingWellViewController: UIViewController {

  @IBOutlet weak var titleItem: UINavigationItem!

  override func viewDidLoad() {
    super.viewDidLoad()

//    self.navigationController?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//    self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.pageSheet

    // Do any additional setup after loading the view.
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }


}
