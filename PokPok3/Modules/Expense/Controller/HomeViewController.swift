//
//  HomeViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var expenseTableView: UITableView!
  @IBOutlet weak var dateTextField: UITextField!

  var expenses = AddExpenseViewController().expenses

  let cellReuseIdentifier = "cell"
  let datePicker = UIDatePicker()

  override func viewDidLoad() {
        super.viewDidLoad()
    createDatePicker()

    print(expenses)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    dateTextField.text = "\(selectedDate)"
    self.hideKeyboardWhenTappedAround()
    
    expenseTableView.dataSource = self
    expenseTableView.delegate = self

    expenseTableView.showsVerticalScrollIndicator = true
    expenseTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    expenseTableView.reloadData()

  }

  override func viewWillAppear(_ animated: Bool) {
    createDatePicker()

    print(expenses)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    dateTextField.text = "\(selectedDate)"
    self.hideKeyboardWhenTappedAround()

    expenseTableView.dataSource = self
    expenseTableView.delegate = self

    expenseTableView.showsVerticalScrollIndicator = true
    expenseTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    expenseTableView.reloadData()
  }

// MARK: - GO TO NEXT OR PREV
  @IBAction func goToPrevious(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .day, value: -1, to: datePicker.date)!
    selectedDate()
  }

  @IBAction func goToNext(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .day, value: 1, to: datePicker.date)!
    selectedDate()
  }

// MARK: - DATEPICKER

  func selectedDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    dateTextField.text = "\(selectedDate)"
  }

  func createDatePicker() {
    createToolbar()
    dateTextField.inputView = datePicker
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date
  }

  func createToolbar() {
      let toolbar = UIToolbar()
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
      let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

      toolbar.sizeToFit()
      toolbar.setItems([flexibleSpace, doneButton], animated: false)
      toolbar.isUserInteractionEnabled = true

      dateTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    dateTextField.text = "\(selectedDate)"
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

  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return expenses.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // create a new cell if needed or reuse an old one
    let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

    cell.textLabel?.text = expenses[indexPath.row].expenseName

    return cell
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

          if editingStyle == .delete {

              // remove the item from the data model
            expenses.remove(at: indexPath.row)

              // delete the table view row
              tableView.deleteRows(at: [indexPath], with: .fade)
            expenseTableView.reloadData()

          } else if editingStyle == .insert {
              // Not used in our example, but if you were adding a new row, this is where you would do it.
          }
      }

}
