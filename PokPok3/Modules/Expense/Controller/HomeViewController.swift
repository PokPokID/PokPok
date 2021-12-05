//
//  HomeViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 06/11/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet weak var expenseTableView: UITableView!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var selectedDay: UILabel!

  var expenses = [Expenses]()
//  var filteredExpenses: []

  let cellReuseIdentifier = "cell"
  let datePicker = UIDatePicker()

  override func viewDidLoad() {
    super.viewDidLoad()

    getData()
    datePicker.date = Date()
    
    createDatePicker()

    selectedDate()
    
    expenseTableView.dataSource = self
    expenseTableView.delegate = self

    expenseTableView.showsVerticalScrollIndicator = true

    let nib = UINib.init(nibName: "HomeCell", bundle: nil)
    expenseTableView.register(nib, forCellReuseIdentifier: "homeCell")

    expenseTableView.reloadData()

  }

  override func viewWillAppear(_ animated: Bool) {
    getData()

    datePicker.date = Date()

    createDatePicker()

    selectedDate()

    expenseTableView.dataSource = self
    expenseTableView.delegate = self

    expenseTableView.showsVerticalScrollIndicator = true

    let nib = UINib.init(nibName: "HomeCell", bundle: nil)
    expenseTableView.register(nib, forCellReuseIdentifier: "homeCell")

    expenseTableView.reloadData()
  }

  @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {}

  // MARK: - CORE DATA

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<Expenses>(entityName: "Expenses")
    let sort = NSSortDescriptor(key: #keyPath(Expenses.dateCreated), ascending: false)
    fetchRequest.sortDescriptors = [sort]

    do {
      try expenses = context.fetch(fetchRequest)
    } catch {

    }

    self.expenseTableView.reloadData()

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
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "EEEE"
    let selectedDays = dateFormatter2.string(from: datePicker.date)
    selectedDay.text = "\(selectedDays)"

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

  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return expenses.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell
    let line = expenses[indexPath.row]

    cell?.commonInit(line: line)
    cell?.selectionStyle = .none

    return cell!
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 68
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    if editingStyle == .delete {

      // remove the item from the data model
      context.delete(expenses[indexPath.row])
      expenses.remove(at: indexPath.row)

      // delete the table view row
      tableView.deleteRows(at: [indexPath], with: .fade)
      do {
        try context.save()
      } catch {
        print("Error")
      }

    }

    getData()

  }

}
