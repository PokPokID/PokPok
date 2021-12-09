//
//  AnalyticsViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 25/11/21.
//

import UIKit
import PieCharts
import CoreData

class AnalyticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var analyticsMonthTextField: UITextField!
  @IBOutlet weak var rightButton: UIButton!

  @IBOutlet weak var analyticsPieChart: PieChart!

  @IBOutlet weak var analyticsTableView: UITableView!

  let datePicker = UIDatePicker()

  var expenses = [Expenses]()

  var total = 0
  var categoryTotal = [0,0,0,0,0,0]

  var arr = [0.0,0.0,0.0,0.0,0.0,0.0]

  var categories = ["Bills","Entertainment","Fashion","Food","Groceries","Transportation"]

  override func viewDidLoad() {
    super.viewDidLoad()
    getData()

    datePicker.date = Date()

    createDatePicker()
    selectedDate()

    analyticsTableView.dataSource = self
    analyticsTableView.delegate = self

    analyticsTableView.showsVerticalScrollIndicator = true
    analyticsTableView.separatorStyle = .none

    analyticsTableView.isScrollEnabled = false

    let nib = UINib.init(nibName: "AnalyticsTableViewCell", bundle: nil)
    analyticsTableView.register(nib, forCellReuseIdentifier: "analyticsCell")

    analyticsTableView.reloadData()

    var count = 0
    repeat{
      arr[count] = Double(categoryTotal[count])/Double(total)
      arr[count] = (arr[count]*100).rounded()/100
      count = count + 1
    }while(count < 6)

    analyticsPieChart.models = [
      PieSliceModel(value: arr[0], color: UIColor.yellow),
      PieSliceModel(value: arr[1], color: UIColor.blue),
      PieSliceModel(value: arr[2], color: UIColor.green),
      PieSliceModel(value: arr[3], color: UIColor.red),
      PieSliceModel(value: arr[4], color: UIColor.orange),
      PieSliceModel(value: arr[5], color: UIColor.purple)
    ]


//    WHY DOESNT THIS WORK HONESTLY?!?!?! IT'S EXACTLY THE SAME AS THE ONE UNDER IT?!?
//      analyticsPieChart.models = [
//        PieSliceModel(value: Double(categoryTotal[0])/Double(total), color: UIColor.yellow),
//        PieSliceModel(value: Double(categoryTotal[1])/Double(total), color: UIColor.blue),
//        PieSliceModel(value: Double(categoryTotal[2])/Double(total), color: UIColor.green),
//        PieSliceModel(value: Double(categoryTotal[3])/Double(total), color: UIColor.red),
//        PieSliceModel(value: Double(categoryTotal[4])/Double(total), color: UIColor.orange),
//        PieSliceModel(value: Double(categoryTotal[5])/Double(total), color: UIColor.purple)
//      ]


//    analyticsPieChart.models = [
//      PieSliceModel(value: 0.15789473684210525, color: UIColor.yellow),
//      PieSliceModel(value: 0.5263157894736842, color: UIColor.blue),
//      PieSliceModel(value: 0.15789473684210525, color: UIColor.green),
//      PieSliceModel(value: 0.07894736842105263, color: UIColor.red),
//      PieSliceModel(value: 0.05263157894736842, color: UIColor.orange),
//      PieSliceModel(value: 0.02631578947368421, color: UIColor.purple)
//    ]

  }

  override func viewWillAppear(_ animated: Bool) {

    getData()
    if(!expenses.isEmpty){
      total = 0
      categoryTotal = [0,0,0,0,0,0]
      calculateData()
      calculateCategory()
    }

    datePicker.date = Date()

    createDatePicker()
    selectedDate()

    analyticsTableView.reloadData()

    var count = 0
    repeat{
      arr[count] = Double(categoryTotal[count])/Double(total)
      arr[count] = (arr[count]*100).rounded()/100
      count = count + 1
    }while(count < 6)

    for i in 0..<6 {
//      print(Double(categoryTotal[i])/Double(total))
      print(arr[i])
    }

    
  }

  override func viewWillDisappear(_ animated: Bool) {
    total = 0
    categoryTotal = [0,0,0,0,0,0]
  }

  func calculateData() {
    var count = 0
    repeat {
      total = total + Int(expenses[count].amount)
      count = count + 1
    } while(count < expenses.count)

    print(total)
  }

  func calculateCategory() {
    var count = 0

    repeat {
      if(expenses[count].category == "Bills") {
        categoryTotal[0] = categoryTotal[0] + Int(expenses[count].amount)
        count = count + 1
      } else if(expenses[count].category == "Entertainment") {
        categoryTotal[1] = categoryTotal[1] + Int(expenses[count].amount)
        count = count + 1
      } else if(expenses[count].category == "Fashion") {
        categoryTotal[2] = categoryTotal[2] + Int(expenses[count].amount)
        count = count + 1
      } else if(expenses[count].category == "Food") {
        categoryTotal[3] = categoryTotal[3] + Int(expenses[count].amount)
        count = count + 1
      } else if(expenses[count].category == "Groceries") {
        categoryTotal[4] = categoryTotal[4] + Int(expenses[count].amount)
        count = count + 1
      } else if(expenses[count].category == "Transportation") {
        categoryTotal[5] = categoryTotal[5] + Int(expenses[count].amount)
        count = count + 1
      }
    } while(count < expenses.count)

    print(categoryTotal)
  }
  

  // MARK: - CORE DATA

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Expenses>(entityName: "Expenses")

    // get the current calendar
    let calendar = Calendar.current

    // get the start of the day of the selected date
//    let startDate = calendar.startOfDay(for: datePicker.date)
    let components = calendar.dateComponents([.year, .month], from: datePicker.date)
    let startOfMonth = calendar.date(from: components)

    // get the start of the day after the selected date
    let endDate = calendar.date(byAdding: .month, value: 1, to: startOfMonth!)

    let datePredicate = NSPredicate(format: "dateCreated >= %@ AND dateCreated < %@", startOfMonth! as NSDate, endDate! as NSDate)
    fetchRequest.predicate = datePredicate

    let sort = NSSortDescriptor(key: #keyPath(Expenses.dateCreated), ascending: false)
    fetchRequest.sortDescriptors = [sort]

    do {
      try expenses = context.fetch(fetchRequest)
    } catch {

    }

  }

  // MARK: - DATEPICKER

  func selectedDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    analyticsMonthTextField.text = "\(selectedDate)"
  }

    func createDatePicker() {
      createToolbar()
      analyticsMonthTextField.inputView = datePicker
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
    getData()
    if(!expenses.isEmpty){
      total = 0
      categoryTotal = [0,0,0,0,0,0]
      calculateData()
      calculateCategory()
    }
  }

  @IBAction func goToNext(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .month, value: 1, to: datePicker.date)!
    selectedDate()
    getData()
    if(!expenses.isEmpty){
      total = 0
      categoryTotal = [0,0,0,0,0,0]
      calculateData()
      calculateCategory()
    }
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
