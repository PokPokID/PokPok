//
//  DetailWishingWellViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 27/11/21.
//

import UIKit
import CoreData

class DetailWishingWellViewController: UIViewController {

  @IBOutlet weak var titleItem: UINavigationItem!
  @IBOutlet weak var wishImage: UIImageView!
  @IBOutlet weak var inputSavingTextfield: UITextField!
  @IBOutlet weak var displayTotalSaving: UILabel!
  @IBOutlet weak var displayTargetSaving: UILabel!
  @IBOutlet var displayTargetDate: UILabel!
  @IBOutlet weak var displayWishNote: UILabel!

  var currentWish: WishingWell!

  var detailWishingWell = [WishingWellSavings]()

  override func viewDidLoad() {
    super.viewDidLoad()

    getData()
    self.hideKeyboardWhenTappedAround()

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: currentWish.date!)
    displayTargetDate.text = "\(selectedDate)"

    inputSavingTextfield.keyboardType = .decimalPad

    displayTotalSaving.text = "\(currentWish.saving)"
    displayTargetSaving.text = "out of \(currentWish.amount)"
    displayWishNote.text = currentWish.note

    let imageURL = URL(string: currentWish.image!)
    do{
    let imageData = try Data(contentsOf:imageURL!)
      wishImage.image = UIImage(data: imageData)
    }catch{

    }


  }

  @IBAction func addSavingButtonPress(_ sender: Any) {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    currentWish.saving = currentWish.saving + Int64(Int(inputSavingTextfield.text!)!)
    if(currentWish.saving >= currentWish.amount){
      currentWish.isCompleted = true
    }

    do {
      try context.save()
    } catch {
      print("error")
    }

    inputSavingTextfield.text = nil

    displayTotalSaving.text = "\(currentWish.saving)"

    getData()
  }


  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }

  // MARK: - CORE DATA

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<WishingWellSavings>(entityName: "WishingWellSavings")

    do {
      try detailWishingWell = context.fetch(fetchRequest)
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



}
