//
//  AddExpenseViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit

class AddExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var expenseNameTextField: UITextField!
  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var expenseNoteTextField: UITextField!


  var expenses = [Expenses]()
  var categories = ["Bills","Entertainment","Fashion","Food","Groceries"]

  let categoryPickerView = UIPickerView()

//  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
//    navigationController?.popViewController(animated: true)
//  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    expenseNameTextField.keyboardType = .default
    amountTextField.keyboardType = .decimalPad
    expenseNoteTextField.keyboardType = .default
    picker()
    createToolbar()

//      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: nil)
        // Do any additional setup after loading the view.
    }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
  }

  @IBAction func saveExpensePressed(_ sender: Any) {

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//    expenses.append(Expenses(expenseName: expenseNameTextField.text, category: categoryTextField.text, amount: amountTextField.text, expenseNote: expenseNoteTextField.text))
    let destVC = segue.destination as! HomeViewController
    destVC.expenses.append(Expenses(expenseName: expenseNameTextField.text, category: categoryTextField.text, amount: amountTextField.text, expenseNote: expenseNoteTextField.text))

    print(destVC.expenses.count)
    print(destVC.expenses)
  }


  //MARK: - PICKER
  func picker() {
      categoryPickerView.delegate = self
      categoryPickerView.delegate?.pickerView?(categoryPickerView, didSelectRow: 0, inComponent: 0)
      categoryTextField.inputView = categoryPickerView

  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return categories.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return categories[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      if pickerView == categoryPickerView {
          categoryTextField.text = categories[row]
      }
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func createToolbar() {
      let toolbar = UIToolbar()
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
      let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

      toolbar.sizeToFit()
      toolbar.setItems([flexibleSpace, doneButton], animated: false)
      toolbar.isUserInteractionEnabled = true

      categoryTextField.inputAccessoryView = toolbar
    expenseNameTextField.inputAccessoryView = toolbar
    amountTextField.inputAccessoryView = toolbar
    expenseNoteTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
      view.endEditing(true)
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


}
