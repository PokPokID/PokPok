//
//  AddViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit

class AddViewController: UIViewController {
  @IBOutlet weak var expenseAddButton: UIButton!
  @IBOutlet weak var wishingWellAddButton: UIButton!

  @IBAction func goToAddExpense(_ sender: UIButton) {
//    performSegue(withIdentifier: "addExpense", sender: nil)
  }

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
