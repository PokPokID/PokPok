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
  @IBOutlet weak var addSavingButton: UIButton!

  @IBOutlet weak var topBackgroundView: UIView!

  var currentWish: WishingWell!

  var detailWishingWell = [WishingWellSavings]()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.navigationBar.backgroundColor = .clear

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    getData()
    self.hideKeyboardWhenTappedAround()
    bottomBorder(myTextField: inputSavingTextfield)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: currentWish.date!)
    displayTargetDate.text = "\(selectedDate)"

    inputSavingTextfield.keyboardType = .decimalPad

    let amount = currentWish.amount
    let saving = currentWish.saving
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currencyAccounting
    formatter.locale = Locale(identifier: "id")
    formatter.currencyCode = "idr"
    let amountStr = formatter.string(from: amount as NSNumber)
    let savingStr = formatter.string(from: saving as NSNumber)

    displayTotalSaving.text = savingStr
    displayTargetSaving.text = "out of " + amountStr!
    displayWishNote.text = currentWish.note

    let imageURL = URL(string: currentWish.image!)
    do{
    let imageData = try Data(contentsOf:imageURL!)
      wishImage.image = UIImage(data: imageData)
    }catch{

    }


  }

  @objc func keyboardWillShow(notification: NSNotification) {

    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 180
            }
        }

  }

  @objc func keyboardWillHide(notification: NSNotification) {
    if self.view.frame.origin.y != 0 {
      self.view.frame.origin.y = 0
    }
  }

  @IBAction func addSavingButtonPress(_ sender: Any) {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    if(inputSavingTextfield.text!.isEmpty) {
      currentWish.saving = currentWish.saving
    } else {
      currentWish.saving = currentWish.saving + Int64(Int(inputSavingTextfield.text!)!)
    }
    if(currentWish.saving >= currentWish.amount){
      currentWish.isCompleted = true
    }

    do {
      try context.save()
    } catch {
      print("error")
    }

    inputSavingTextfield.text = nil

    let saving = currentWish.saving
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currencyAccounting
    formatter.locale = Locale(identifier: "id")
    formatter.currencyCode = "idr"
    let savingStr = formatter.string(from: saving as! NSNumber)

    displayTotalSaving.text = savingStr

    getData()

    if(currentWish.isCompleted) {
      addSavingButton.isUserInteractionEnabled = false
    }

    
  }


  @IBAction func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }

  func bottomBorder(myTextField: UITextField) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 3, width: myTextField.frame.width-20, height: 1.0)
    bottomLine.backgroundColor = UIColor.gray.cgColor
    myTextField.borderStyle = UITextField.BorderStyle.none
    myTextField.layer.addSublayer(bottomLine)
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
