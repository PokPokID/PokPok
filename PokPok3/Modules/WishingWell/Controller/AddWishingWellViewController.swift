//
//  AddWishingWellViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 23/11/21.
//

import UIKit

class AddWishingWellViewController: UIViewController {
  @IBOutlet weak var addImageButton: UIButton!
  @IBOutlet weak var wishingWellNameTextField: UITextField!
  @IBOutlet weak var amountWishingWellTextField: UITextField!
  @IBOutlet weak var dateAchieveTextField: UITextField!
  @IBOutlet weak var noteWishingWellTextField: UITextField!
  @IBOutlet weak var saveWishButton: UIButton!

  let datePicker = UIDatePicker()

  var wishes = [WishingWell]()

  override func viewDidLoad() {
    super.viewDidLoad()

    bottomBorderAll()
    checkAmount()
    createDatePicker()
    self.hideKeyboardWhenTappedAround()
//
//    navigationController?.title = "Wishing Well"
//    navigationController?.isNavigationBarHidden = false

    wishingWellNameTextField.keyboardType = .default
    amountWishingWellTextField.keyboardType = .decimalPad
    noteWishingWellTextField.keyboardType = .default

    // Do any additional setup after loading the view.
  }

  

  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
  }

  func checkAmount() {
    saveWishButton.layer.cornerRadius = 5
    saveWishButton.backgroundColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
    saveWishButton.tintColor = #colorLiteral(red: 0.4995350242, green: 0.2460623384, blue: 0.2599021196, alpha: 1)
    saveWishButton.isEnabled = false
    [amountWishingWellTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
  }

  @objc func editingChanged(_ textField: UITextField) {
    guard let amount = amountWishingWellTextField.text, !amount.isEmpty
    else {
      saveWishButton.backgroundColor = #colorLiteral(red: 0.8988185525, green: 0.8248531818, blue: 0.8305549026, alpha: 1)
      saveWishButton.isEnabled = false

      return
    }

    saveWishButton.backgroundColor = UIColor(red: 107.0/255.0, green: 56.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    saveWishButton.tintColor = .white
    saveWishButton.isEnabled = true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let newWishes = WishingWell(context: context)
    newWishes.name = wishingWellNameTextField.text
    newWishes.image = nil
    newWishes.date = datePicker.date
    newWishes.note = noteWishingWellTextField.text
    newWishes.amount = Int64(Int(amountWishingWellTextField.text!)!)
    newWishes.isCompleted = false

    //ganti jadi datePicker.date
    do {
      try context.save()
    } catch {
      print("error")
    }

  }
  

  func bottomBorder(myTextField: UITextField) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 3, width: myTextField.frame.width-20, height: 1.0)
    bottomLine.backgroundColor = UIColor.gray.cgColor
    myTextField.borderStyle = UITextField.BorderStyle.none
    myTextField.layer.addSublayer(bottomLine)
  }

  func bottomBorderAll() {
    bottomBorder(myTextField: wishingWellNameTextField)
    bottomBorder(myTextField: amountWishingWellTextField)
    bottomBorder(myTextField: dateAchieveTextField)
    bottomBorder(myTextField: noteWishingWellTextField)
  }
  // MARK: - DATE PICKER

  func createDatePicker() {
    createToolbar()
    dateAchieveTextField.inputView = datePicker
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

    dateAchieveTextField.inputAccessoryView = toolbar
    wishingWellNameTextField.inputAccessoryView = toolbar
    amountWishingWellTextField.inputAccessoryView = toolbar
    noteWishingWellTextField.inputAccessoryView = toolbar
  }

  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: datePicker.date)
    dateAchieveTextField.text = "\(selectedDate)"
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

}
