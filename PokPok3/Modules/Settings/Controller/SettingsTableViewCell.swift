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

  let userDefault = UserDefaults.standard
  var categoryBudget: String = ""

  override func awakeFromNib() {
    super.awakeFromNib()

    self.budgetTextField.delegate = self
    budgetTextField.keyboardType = .decimalPad
    self.budgetTextField.text = userDefault.string(forKey: categoryBudget)

  }

  
 

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    userDefault.set(textField.text, forKey: categoryBudget)
    self.budgetTextField.text = userDefault.string(forKey: categoryBudget)
  }



}
