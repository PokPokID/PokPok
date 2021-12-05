//
//  settingsViewController.swift
//  PokPok3
//
//  Created by Michelle Aurelia on 20/10/21.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


  @IBOutlet weak var budgetTableView: UITableView!

  var cell = "cell"

  var budgets = [Category]()

  var categories = ["Bills","Entertainment","Fashion","Food","Groceries"]


  override func viewDidLoad() {
        super.viewDidLoad()

    self.hideKeyboardWhenTappedAround()

    getData()

    budgetTableView.dataSource = self
    budgetTableView.delegate = self

    budgetTableView.showsVerticalScrollIndicator = false

    let nib = UINib.init(nibName: "SettingsCell", bundle: nil)
    budgetTableView.register(nib, forCellReuseIdentifier: "settingsCell")

    budgetTableView.reloadData()

    }

  override func viewWillAppear(_ animated: Bool) {
    print(budgets)
  }

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<Category>(entityName: "Category")

    do {
      try budgets = context.fetch(fetchRequest)
    } catch {

    }

  }

  //MARK: - KEYBOARD
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }


  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsTableViewCell
//    let line = budgets[indexPath.row]

//    cell?.commonInit(line: line)
    cell?.categoryNameLabel.text = self.categories[indexPath.row]


    cell?.selectionStyle = .none

    return cell!
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }


}
