//
//  AnalyticsViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 25/11/21.
//

import UIKit

class AnalyticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var analyticsMonthTextField: UITextField!
  @IBOutlet weak var rightButton: UIButton!

  @IBOutlet weak var analyticsTableView: UITableView!

  let datePicker = UIDatePicker()

  var cell = "cell"

  var categories = ["Bills","Entertainment","Fashion","Food","Groceries"]

  override func viewDidLoad() {
    super.viewDidLoad()

    datePicker.date = Date()

//    createDatePicker()
    selectedDate()

    analyticsTableView.dataSource = self
    analyticsTableView.delegate = self

    analyticsTableView.showsVerticalScrollIndicator = true
    analyticsTableView.separatorStyle = .none

    let nib = UINib.init(nibName: "AnalyticsTableViewCell", bundle: nil)
    analyticsTableView.register(nib, forCellReuseIdentifier: "analyticsCell")

    analyticsTableView.reloadData()

    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    datePicker.date = Date()

//    createDatePicker()
    selectedDate()

    analyticsTableView.dataSource = self
    analyticsTableView.delegate = self

    analyticsTableView.showsVerticalScrollIndicator = true
    analyticsTableView.separatorStyle = .none

    analyticsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    analyticsTableView.reloadData()
  }

  // MARK: - DATEPICKER

  func selectedDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    analyticsMonthTextField.text = "\(selectedDate)"
  }

//  func createDatePicker() {
//    createToolbar()
//    analyticsMonthTextField.inputView = datePicker
//    datePicker.preferredDatePickerStyle = .wheels
//    datePicker.datePickerMode = .date
//  }

  func createToolbar() {
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    toolbar.sizeToFit()
    toolbar.setItems([flexibleSpace, doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true

    analyticsMonthTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    analyticsMonthTextField.text = "\(selectedDate)"
    view.endEditing(true)
  }

  // MARK: - GO TO NEXT OR PREV
  @IBAction func goToPrevious(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .month, value: -1, to: datePicker.date)!
    selectedDate()
  }

  @IBAction func goToNext(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .month, value: 1, to: datePicker.date)!
    selectedDate()
  }


  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "analyticsCell", for: indexPath) as? AnalyticsTableViewCell

    // set the text from the data model
    cell?.categoryLabel.text = self.categories[indexPath.row]

    cell?.selectionStyle = .none

    return cell!
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 68
  }


}
