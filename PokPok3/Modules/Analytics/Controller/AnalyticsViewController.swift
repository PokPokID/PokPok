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
  @IBOutlet weak var emptyChartLabel: UILabel!

  @IBOutlet weak var analyticsTableView: UITableView!
  @IBOutlet weak var progressButton: UIButton!

  let datePicker = UIDatePicker()

  var expenses = [Expenses]()
  var lastExpenses = [Expenses]()

  var total = 0
  var categoryTotal = [0,0,0,0,0,0]

  var lastMonthTotal = 0
  var lastCategoryTotal = [0,0,0,0,0,0]

  var arr = [0.0,0.0,0.0,0.0,0.0,0.0]

  var overBudget = 0
  var lastOverBudget = 0

  var noTransaction = false
  var noTransactionThisMonth = false

  var categories = ["Bills","Entertainment","Fashion","Food","Groceries","Transportation"]

  override func viewDidLoad() {

    super.viewDidLoad()

    emptyChartLabel.isHidden = true

    datePicker.date = Date()

//    createDatePicker()
    selectedDate()

    getData()
    getLastMonthData()

    analyticsMonthTextField.isUserInteractionEnabled = false

    pieChartCalculateAll()

    analyticsTableView.dataSource = self
    analyticsTableView.delegate = self

    analyticsTableView.showsVerticalScrollIndicator = true
    analyticsTableView.separatorStyle = .none

    analyticsTableView.isScrollEnabled = false

    let nib = UINib.init(nibName: "AnalyticsTableViewCell", bundle: nil)
    analyticsTableView.register(nib, forCellReuseIdentifier: "analyticsCell")

    analyticsTableView.reloadData()



  }



  override func viewWillDisappear(_ animated: Bool) {
    total = 0
    categoryTotal = [0,0,0,0,0,0]

    lastMonthTotal = 0
    lastCategoryTotal = [0,0,0,0,0,0]
  }

  //MARK: - CALCULATE

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

  //MARK: - PIE CHART

  func pieChartModels() {
    analyticsPieChart.clear()
    analyticsPieChart.models = [
      PieSliceModel(value: arr[0], color: UIColor(red: 0.561, green: 0.373, blue: 0.192, alpha: 1)),
      PieSliceModel(value: arr[1], color: UIColor(red: 0.278, green: 0.192, blue: 0.098, alpha: 1)),
      PieSliceModel(value: arr[2], color: UIColor(red: 0.671, green: 0.58, blue: 0.459, alpha: 1)),
      PieSliceModel(value: arr[3], color: UIColor(red: 0.879, green: 0.702, blue: 0.524, alpha: 1)),
      PieSliceModel(value: arr[4], color: UIColor(red: 0.921, green: 0.759, blue: 0.61, alpha: 1)),
      PieSliceModel(value: arr[5], color: UIColor(red: 0.792, green: 0.537, blue: 0.287, alpha: 1))
    ]
    analyticsPieChart.isUserInteractionEnabled = false
    emptyChartLabel.isHidden = true

    progressButton.layer.cornerRadius = 5
    progressButton.tintColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
    progressButton.backgroundColor = #colorLiteral(red: 0.4995350242, green: 0.2460623384, blue: 0.2599021196, alpha: 1)
    progressButton.isEnabled = true
  }

  func pieChartModelsEmpty() {
    analyticsPieChart.clear()
    analyticsPieChart.models = [
      PieSliceModel(value: 1, color: UIColor.clear)
    ]
    analyticsPieChart.isUserInteractionEnabled = false
    emptyChartLabel.isHidden = false

    progressButton.layer.cornerRadius = 5
    progressButton.backgroundColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
    progressButton.tintColor = #colorLiteral(red: 0.4995350242, green: 0.2460623384, blue: 0.2599021196, alpha: 1)
    progressButton.isEnabled = false
  }

  func pieChartCalculateAll() {
    if(!expenses.isEmpty){
      total = 0
      categoryTotal = [0,0,0,0,0,0]
      overBudget = 0
      calculateData()
      calculateCategory()
      var count = 0
      repeat{
        arr[count] = Double(categoryTotal[count])/Double(total)
        arr[count] = (arr[count]*100).rounded()/100
        if let budget = UserDefaults.standard.string(forKey: self.categories[count]) {
          if(!expenses.isEmpty) {
            if(Float(categoryTotal[count]) >= Float(budget)!) {
              overBudget = overBudget + 1
            }
          }
        }
        count = count + 1
      }while(count < 6)
      pieChartModels()
    } else if (expenses.isEmpty) {
      pieChartModelsEmpty()
      noTransactionThisMonth = true
    }
  }

  // MARK: - CORE DATA

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Expenses>(entityName: "Expenses")

    // get the current calendar
    let calendar = Calendar.current

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

  func getLastMonthData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Expenses>(entityName: "Expenses")

    // get the current calendar
    let calendar = Calendar.current

    let lastMonth = calendar.date(byAdding: .month, value: -1, to: datePicker.date)
    let components = calendar.dateComponents([.year, .month], from: lastMonth!)
    let startOfLastMonth = calendar.date(from: components)

    // get the start of the day after the selected date
    let endDate = calendar.date(byAdding: .month, value: 1, to: startOfLastMonth!)

    let datePredicate = NSPredicate(format: "dateCreated >= %@ AND dateCreated < %@", startOfLastMonth! as NSDate, endDate! as NSDate)
    fetchRequest.predicate = datePredicate

    let sort = NSSortDescriptor(key: #keyPath(Expenses.dateCreated), ascending: false)
    fetchRequest.sortDescriptors = [sort]

    do {
      try lastExpenses = context.fetch(fetchRequest)
      print(lastExpenses)
    } catch {

    }

    func calculateLastData() {
      var count = 0
      repeat {
        lastMonthTotal = total + Int(lastExpenses[count].amount)
        count = count + 1
      } while(count < lastExpenses.count)
    }

    func calculateLastCategory() {
      var count = 0

      repeat {
        if(lastExpenses[count].category == "Bills") {
          lastCategoryTotal[0] = lastCategoryTotal[0] + Int(lastExpenses[count].amount)
          count = count + 1
        } else if(lastExpenses[count].category == "Entertainment") {
          lastCategoryTotal[1] = lastCategoryTotal[1] + Int(lastExpenses[count].amount)
          count = count + 1
        } else if(lastExpenses[count].category == "Fashion") {
          lastCategoryTotal[2] = lastCategoryTotal[2] + Int(lastExpenses[count].amount)
          count = count + 1
        } else if(lastExpenses[count].category == "Food") {
          lastCategoryTotal[3] = lastCategoryTotal[3] + Int(lastExpenses[count].amount)
          count = count + 1
        } else if(lastExpenses[count].category == "Groceries") {
          lastCategoryTotal[4] = lastCategoryTotal[4] + Int(lastExpenses[count].amount)
          count = count + 1
        } else if(lastExpenses[count].category == "Transportation") {
          lastCategoryTotal[5] = lastCategoryTotal[5] + Int(lastExpenses[count].amount)
          count = count + 1
        }
      } while(count < lastExpenses.count)

    }

    if(!lastExpenses.isEmpty) {
      calculateLastData()
      calculateLastCategory()
    } else {
      noTransaction = true
    }

    var count = 0
    repeat{
      if let budget = UserDefaults.standard.string(forKey: self.categories[count]) {
        if(!lastExpenses.isEmpty) {
          if(Float(lastCategoryTotal[count]) >= Float(budget)!) {
            lastOverBudget = lastOverBudget + 1
          }
        } else {
          lastOverBudget = 0
        }
      }
      count = count + 1
    }while(count < 6)

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
    getData()
    pieChartCalculateAll()

    analyticsTableView.reloadData()
    view.endEditing(true)
  }

  // MARK: - GO TO NEXT OR PREV
  @IBAction func goToPrevious(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .month, value: -1, to: datePicker.date)!
    selectedDate()
    getData()
    getLastMonthData()
    pieChartCalculateAll()
    analyticsTableView.reloadData()
  }

  @IBAction func goToNext(_ sender: UIButton) {
    datePicker.date = datePicker.calendar.date(byAdding: .month, value: 1, to: datePicker.date)!
    selectedDate()
    getData()
    getLastMonthData()
    pieChartCalculateAll()
    analyticsTableView.reloadData()
  }


  @IBAction func progressButtonPressed(_ sender: Any) {
    let storyboard = UIStoryboard(name: "AnalyticsDetail", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "analyticsDetail") as! AnalyticsDetailViewController

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)

    vc.titleItem.title = selectedDate
    vc.datePicker = datePicker
    vc.overBudget = overBudget
    vc.lastOverBudget = lastOverBudget
    vc.noTransaction = noTransaction
    vc.noTransactionThisMonth = noTransactionThisMonth

    self.navigationController?.pushViewController(vc, animated: true)

  }


  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "analyticsCell", for: indexPath) as? AnalyticsTableViewCell

    cell?.categoryLabel.text = self.categories[indexPath.row]


    if (categories[indexPath.row] == "Bills") {
      cell?.categoryColor.tintColor = UIColor(red: 0.561, green: 0.373, blue: 0.192, alpha: 1)
    }else if (categories[indexPath.row] == "Entertainment") {
      cell?.categoryColor.tintColor = UIColor(red: 0.278, green: 0.192, blue: 0.098, alpha: 1)
    }else if (categories[indexPath.row] == "Food") {
      cell?.categoryColor.tintColor = UIColor(red: 0.671, green: 0.58, blue: 0.459, alpha: 1)    }
    else if (categories[indexPath.row] == "Fashion") {
      cell?.categoryColor.tintColor = UIColor(red: 0.879, green: 0.702, blue: 0.524, alpha: 1)
    }else if (categories[indexPath.row] == "Groceries") {
      cell?.categoryColor.tintColor = UIColor(red: 0.921, green: 0.759, blue: 0.61, alpha: 1)
    }else if (categories[indexPath.row] == "Transportation") {
      cell?.categoryColor.tintColor = UIColor(red: 0.792, green: 0.537, blue: 0.287, alpha: 1)
    }

    if(UserDefaults.standard.string(forKey: self.categories[indexPath.row]) == nil || UserDefaults.standard.string(forKey: self.categories[indexPath.row]) == ""){
      cell?.categoryBudgetLabel.text = ""
    } else {
      let budget = Int(UserDefaults.standard.string(forKey: self.categories[indexPath.row])!)
      let formatter = NumberFormatter()
      formatter.numberStyle = NumberFormatter.Style.currencyAccounting
      formatter.locale = Locale(identifier: "IN")
      formatter.currencyCode = "idr"
      let string = formatter.string(from: budget! as NSNumber)

      cell?.categoryBudgetLabel.text = string
    }

    if let budget = UserDefaults.standard.string(forKey: self.categories[indexPath.row]) {

      let catTotal = Float(categoryTotal[indexPath.row])
      let budgetTotal = Float(budget)!

      if (!expenses.isEmpty && !budget.isEmpty){
        cell?.analyticsProgressBar.progress = catTotal/budgetTotal

        if(catTotal >= budgetTotal) {
          cell?.analyticsProgressBar.progressTintColor = .red
        }
        else if (catTotal/budgetTotal >= 0.75) {
          cell?.analyticsProgressBar.progressTintColor = UIColor(red: 1, green: 0.521, blue: 0.521, alpha: 1)
        }
        else if(catTotal < budgetTotal) {
          cell?.analyticsProgressBar.progressTintColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        }
      } else {
        cell?.analyticsProgressBar.progress = 0/1
      }
    }
    else {
      cell?.analyticsProgressBar.progress = 0/1

    }

    cell?.selectionStyle = .none

//    analyticsTableView.reloadData()

    return cell!
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 68
  }

//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    <#code#>
//  }


}
