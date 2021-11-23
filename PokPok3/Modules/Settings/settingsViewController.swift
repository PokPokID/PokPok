//
//  settingsViewController.swift
//  PokPok3
//
//  Created by Michelle Aurelia on 20/10/21.
//

import UIKit

class settingsViewController: UIViewController{

//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 0
//
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    return budgetTableView
//  }


  @IBOutlet weak var budgetTableView: UITableView!


  override func viewDidLoad() {
        super.viewDidLoad()

//    budgetTableView.delegate = self
//    budgetTableView.dataSource = self

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

//extension ViewController: UITableViewDelegate {}
//
//
//extension ViewController: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 0
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    return 0
//  }
//}
