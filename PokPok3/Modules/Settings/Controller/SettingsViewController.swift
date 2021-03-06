//
//  settingsViewController.swift
//  PokPok3
//
//  Created by Michelle Aurelia on 20/10/21.
//

import UIKit
import CoreData
import NotificationCenter

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{


  @IBOutlet weak var budgetTableView: UITableView!
  @IBOutlet weak var timePickerTextfield: UITextField!

  var cell = "cell"

  var budgets = [Category]()
  var wishes = [WishingWell]()

  let timePicker = UIDatePicker()

  var categories = ["Bills","Entertainment","Fashion","Food","Groceries","Transportation"]


  override func viewDidLoad() {
    super.viewDidLoad()

    self.hideKeyboardWhenTappedAround()

    getData()
    getWishData()

    print(wishes)

    createDatePicker()

    selectedDate()

    if(timePickerTextfield.text == "") {
      let dateFormatterTime = DateFormatter()
      dateFormatterTime.dateFormat = "hh:mm a"
      let selected = dateFormatterTime.string(from: timePicker.date)
      let time = dateFormatterTime.date(from: selected)!

      dateFormatterTime.dateFormat = "HH:mm"
      let selectedTime = dateFormatterTime.string(from: time)

      timePickerTextfield.text? = selectedTime
    }

    budgetTableView.dataSource = self
    budgetTableView.delegate = self

    budgetTableView.showsVerticalScrollIndicator = false
    budgetTableView.isScrollEnabled = false

    let nib = UINib.init(nibName: "SettingsCell", bundle: nil)
    budgetTableView.register(nib, forCellReuseIdentifier: "settingsCell")

    budgetTableView.reloadData()

  }

  override func viewWillAppear(_ animated: Bool) {
//    print(budgets)
    getData()
    getWishData()
    budgetTableView.reloadData()
  }

  func selectedDate() {
    let dateFormatterTime = DateFormatter()

    dateFormatterTime.dateFormat = "hh:mm a"
    let selected = dateFormatterTime.string(from: timePicker.date)
    let time = dateFormatterTime.date(from: selected)!

    dateFormatterTime.dateFormat = "HH:mm"
    let selectedTime = dateFormatterTime.string(from: time)

    timePickerTextfield.text? = selectedTime
//    UserDefaults.standard.set(selectedTime, forKey: "notificationTime")
    timePickerTextfield.text = UserDefaults.standard.string(forKey: "notificationTime")
  }

  func createDatePicker() {
    createToolbar()
    timePickerTextfield.inputView = timePicker
    timePicker.preferredDatePickerStyle = .wheels
    timePicker.datePickerMode = .time
  }

  func createToolbar() {
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    toolbar.sizeToFit()
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true

    timePickerTextfield.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
    view.endEditing(true)
    let dateFormatterTime = DateFormatter()

    dateFormatterTime.dateFormat = "hh:mm a"
    let selected = dateFormatterTime.string(from: timePicker.date)
    let time = dateFormatterTime.date(from: selected)!

    dateFormatterTime.dateFormat = "HH:mm"
    let selectedTime = dateFormatterTime.string(from: time)
    UserDefaults.standard.set(selectedTime, forKey: "notificationTime")
    selectedDate()

    print(wishes)

//    print(rand)

    if !wishes.isEmpty {
      let rand = wishes.randomElement()
      LocalNotificationManager.setNotification(timePicker.date, title: "PokPok", body: "Do you still want to buy " + rand!.name! + "? Save your money now!", userInfo: ["aps" : ["hello" : "world"]])
    } else {
      let bodies = ["What did you buy today?", "How much did you spend today?", "Don???t forget to write down your transactions!", "Don't forget to save money!"]
      LocalNotificationManager.setNotification(timePicker.date, title: "PokPok", body: bodies.randomElement()!, userInfo: ["aps" : ["hello" : "world"]])
    }

  }


  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<Category>(entityName: "Category")

    do {
      try budgets = context.fetch(fetchRequest)
    } catch {

    }

  }

  func getWishData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<WishingWell>(entityName: "WishingWell")
    let notComplete = NSPredicate(format: "isCompleted == 0")
    let notExpired = NSPredicate(format: "isExpired == 0")
    fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [notComplete, notExpired])

    do {
      try wishes = context.fetch(fetchRequest)
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
    let userDefault = UserDefaults.standard
    cell?.categoryNameLabel.text = self.categories[indexPath.row]

    if(userDefault.string(forKey: self.categories[indexPath.row]) == nil || userDefault.string(forKey: self.categories[indexPath.row]) == ""){
      cell?.budgetTextField.text = ""
    } else {
      let budget = Int(userDefault.string(forKey: self.categories[indexPath.row])!)
      let formatter = NumberFormatter()
      formatter.numberStyle = NumberFormatter.Style.currencyAccounting
      formatter.locale = Locale(identifier: "IN")
      formatter.currencyCode = "idr"
      let string = formatter.string(from: budget as! NSNumber)

      cell?.budgetTextField.text = string
    }

    cell?.categoryBudget = self.categories[indexPath.row]

    cell?.selectionStyle = .none

    return cell!
  }


  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }


}
