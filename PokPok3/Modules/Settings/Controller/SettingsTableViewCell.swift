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

  //hello

  
 

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    budgetTextField.text = ""
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    userDefault.set(textField.text, forKey: categoryBudget)

    if(userDefault.string(forKey: categoryBudget) == nil || userDefault.string(forKey: categoryBudget) == "") {
      budgetTextField.text = ""
    } else {
      let budget = Int(userDefault.string(forKey: categoryBudget)!)
      let formatter = NumberFormatter()
      formatter.numberStyle = NumberFormatter.Style.currencyAccounting
      formatter.locale = Locale(identifier: "IN")
      formatter.currencyCode = "idr"
      let string = formatter.string(from: budget as! NSNumber)

      budgetTextField.text = string
    }
  }



}
