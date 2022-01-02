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
  var overBudget:Int?
  var lastOverBudget:Int?

  var noTransaction = false
  var noTransactionThisMonth = false

  var quotes = ["“Small amounts saved daily add up to huge investments in the end.” ― Margo Vader", "“Never spend your money before you have it.“ – Thomas Jefferson"]

  var quotes2 = ["“Saving money Today secures, eases, and beautifies Tomorrow.“ ― Ehsan Sehgal", "“A budget is telling your money where to go, instead of wondering where it went.” — John C. Maxwell"]

    override func viewDidLoad() {
        super.viewDidLoad()

      labelThisMonthKalimatIndah.text = quotes.randomElement()
      labelLastMonthKalimatIndah.text = quotes2.randomElement()

      cardView(myView: lastMonthView)
      cardView(myView: thisMonthView)

      print(lastOverBudget!)

      if(overBudget == 0 || overBudget == 1) {
        labelProgressStatus.text = "EXCELLENT!"
      } else if(overBudget == 2 || overBudget == 3){
        labelProgressStatus.text = "WELL DONE!"
      } else if(overBudget == 4 || overBudget == 5 || overBudget == 6) {
        labelProgressStatus.text = "DO BETTER!"
      }

      if(overBudget! > 0) {
        labelThisMonthComparison.text = "\(overBudget!) of 6 categories were over your budget!"
      } else if(overBudget == 0 && noTransactionThisMonth == false) {
        labelThisMonthComparison.text = "All of your budgets were still within limits!"
      } else if(overBudget == 0 && noTransactionThisMonth == true) {
        labelThisMonthComparison.text = "There hasn't been any transactions/budgets this month!"
      }

      if(lastOverBudget! > 0) {
        labelLastMonthComparison.text = "\(lastOverBudget!) of 6 categories were over your budget!"
      } else if(lastOverBudget == 0 && noTransaction == false) {
        labelLastMonthComparison.text = "All of your budgets were still within limits!"
      } else if(lastOverBudget == 0 && noTransaction == true) {
        labelLastMonthComparison.text = "There hasn't been any transactions/budgets this month!"
      }



        // Do any additional setup after loading the view.
    }

  func cardView(myView: UIView) {
    myView.layer.cornerRadius = 10
    myView.layer.borderWidth = 1
    myView.layer.borderColor = CGColor(red: 225.0/255.0, green: 214.0/255.0, blue: 187.0/255.0, alpha: 1.0)
  }

  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popToRootViewController(animated: true)
  }



}
