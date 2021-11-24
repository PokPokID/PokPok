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

  let datePicker = UIDatePicker()

  var wishes = [Wishes]()

    override func viewDidLoad() {
        super.viewDidLoad()
      createDatePicker()
      self.hideKeyboardWhenTappedAround()

      wishingWellNameTextField.keyboardType = .default
      amountWishingWellTextField.keyboardType = .decimalPad
      noteWishingWellTextField.keyboardType = .default

        // Do any additional setup after loading the view.
    }

  @IBAction func backButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    wishes.append(Wishes(wishImage: nil, wishName: wishingWellNameTextField.text, wishDate: dateAchieveTextField.text, wishAmount: amountWishingWellTextField.text, wishNote: noteWishingWellTextField.text))

    print(wishes)
    let destVC = segue.destination as! WishingWellViewController
    destVC.wishes = wishes
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
