//
//  AnalyticsDetailViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 13/12/21.
//

import UIKit
import CoreData

class AnalyticsDetailViewController: UIViewController {
  @IBOutlet weak var labelProgressStatus: UILabel!
  @IBOutlet weak var labelLastMonthComparison: UILabel!
  @IBOutlet weak var labelLastMonthKalimatIndah: UILabel!
  @IBOutlet weak var labelThisMonthComparison: UILabel!
  @IBOutlet weak var labelThisMonthKalimatIndah: UILabel!

  @IBOutlet weak var titleItem: UINavigationItem!
  @IBOutlet weak var lastMonthView: UIView!
  @IBOutlet weak var thisMonthView: UIView!

  var datePicker = UIDatePicker()
  var overBudget = 0

    override func viewDidLoad() {
        super.viewDidLoad()

      cardView(myView: lastMonthView)
      cardView(myView: thisMonthView)
      print(overBudget)

        // Do any additional setup after loading the view.
    }

  func cardView(myView: UIView) {
    myView.layer.cornerRadius = 10
    myView.layer.borderWidth = 1
    myView.layer.borderColor = CGColor(red: 225.0/255.0, green: 214.0/255.0, blue: 187.0/255.0, alpha: 1.0)
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
//    self.navigationController?.popViewController(animated: true)
  }






//  // MARK: - CORE DATA
//
//  func getData() {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<Expenses>(entityName: "Expenses")
//
//    // get the current calendar
//    let calendar = Calendar.current
//
//    let components = calendar.dateComponents([.year, .month], from: datePicker.date)
//    let startOfMonth = calendar.date(from: components)
//
//    // get the start of the day after the selected date
//    let endDate = calendar.date(byAdding: .month, value: 1, to: startOfMonth!)
//
//    let datePredicate = NSPredicate(format: "dateCreated >= %@ AND dateCreated < %@", startOfMonth! as NSDate, endDate! as NSDate)
//    fetchRequest.predicate = datePredicate
//
//    let sort = NSSortDescriptor(key: #keyPath(Expenses.dateCreated), ascending: false)
//    fetchRequest.sortDescriptors = [sort]
//
//    do {
//      try expenses = context.fetch(fetchRequest)
//    } catch {
//
//    }
//
//  }

}
