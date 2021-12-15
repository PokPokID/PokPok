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
  @IBOutlet weak var expenseDateTextField: UITextField!
//  @IBOutlet weak var expenseNoteTextField: UITextField!
  @IBOutlet weak var saveExpenseButton: UIButton!


  var expenses = [Expenses]()
  var categories = ["Bills","Entertainment","Fashion","Food","Groceries","Transportation"]
  let datePicker = UIDatePicker()

  let categoryPickerView = UIPickerView()


  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    expenseNameTextField.keyboardType = .default
    amountTextField.keyboardType = .decimalPad
//    expenseNoteTextField.keyboardType = .default
    picker()
    createToolbar()
    checkAmount()
    createDatePicker()
    bottomBorderAll()
    selectedDate()

  }

  func checkAmount() {
    saveExpenseButton.layer.cornerRadius = 5
    saveExpenseButton.backgroundColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
    saveExpenseButton.tintColor = #colorLiteral(red: 0.4995350242, green: 0.2460623384, blue: 0.2599021196, alpha: 1)
    saveExpenseButton.isEnabled = false
    [amountTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
  }

  @objc func editingChanged(_ textField: UITextField) {
    guard let amount = amountTextField.text, !amount.isEmpty
    else {
      saveExpenseButton.backgroundColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
      saveExpenseButton.isEnabled = false

      return
    }

    saveExpenseButton.backgroundColor = UIColor(red: 107.0/255.0, green: 56.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    saveExpenseButton.tintColor = .white
    saveExpenseButton.isEnabled = true
  }
  
  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
  }

  @IBAction func saveExpensePressed(_ sender: Any) {

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let newExpenses = Expenses(context: context)
    newExpenses.name = expenseNameTextField.text
    newExpenses.category = categoryTextField.text
    newExpenses.amount = Int64(Int(amountTextField.text!)!)
    newExpenses.note = nil
    newExpenses.dateCreated = datePicker.date

    do {
      try context.save()
    } catch {
      print("error")
    }

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
//    expenseNoteTextField.inputAccessoryView = toolbar
    expenseDateTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    expenseDateTextField.text = "\(selectedDate)"
    view.endEditing(true)
  }

  // MARK: - DATE PICKER

  func createDatePicker() {
    createToolbar()
    expenseDateTextField.inputView = datePicker
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date
  }

  func selectedDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    expenseDateTextField.text = "\(selectedDate)"
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

  //MARK: - BOTTOM BORDER

  func bottomBorder(myTextField: UITextField) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 3, width: myTextField.frame.width, height: 1.0)
    bottomLine.backgroundColor = UIColor.gray.cgColor
    myTextField.borderStyle = UITextField.BorderStyle.none
    myTextField.layer.addSublayer(bottomLine)
  }

  func bottomBorderAll() {
    bottomBorder(myTextField: expenseNameTextField)
    bottomBorder(myTextField: categoryTextField)
    bottomBorder(myTextField: amountTextField)
    bottomBorder(myTextField: expenseDateTextField)
//    bottomBorder(myTextField: expenseNoteTextField)
  }


}
