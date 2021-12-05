//
//  SettingsTableViewCell.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 25/11/21.
//

import UIKit
import CoreData

class SettingsTableViewCell: UITableViewCell, UITextFieldDelegate {

  @IBOutlet weak var categoryNameLabel: UILabel!
  @IBOutlet weak var budgetTextField: UITextField!

  var budgets = [Category]()
  var categories = ["Bills","Entertainment","Fashion","Food","Groceries"]

  override func awakeFromNib() {
    super.awakeFromNib()

    self.budgetTextField.delegate = self
    budgetTextField.keyboardType = .decimalPad

    createToolbar()

  }

  func commonInit(line: Category) {
    budgetTextField.text = "\(line.categoryBudget)"
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func createToolbar() {
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    toolbar.sizeToFit()
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true

    budgetTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed(){
    self.endEditing(true)
//    saveData()
  }

  func saveData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let budgets = Category(context: context)
    budgets.categoryBudget = Int64(Int(budgetTextField.text!)!)
    budgets.categoryName = categories[0]
    budgets.categoryMonth = nil

    do {
      try context.save()
    } catch {
      print("error")
    }

//    budgetTextField.text = "\(budgets.categoryBudget)"

  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.endEditing(true)
  }

}
