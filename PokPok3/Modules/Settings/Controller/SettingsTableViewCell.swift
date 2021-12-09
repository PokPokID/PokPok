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


  override func awakeFromNib() {
    super.awakeFromNib()

    self.budgetTextField.delegate = self
    budgetTextField.keyboardType = .decimalPad

  }

  func commonInit(line: Category) {
    budgetTextField.text = "\(line.categoryBudget)"

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }



}
