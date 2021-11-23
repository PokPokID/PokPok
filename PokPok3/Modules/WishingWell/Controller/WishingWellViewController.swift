//
//  WishingWellViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 23/11/21.
//

import UIKit

class WishingWellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var wishingWellTableView: UITableView!
  @IBOutlet var emptyView: UIView!
  @IBOutlet weak var addAWish: UIButton!

  var dummyData = ["satu"]
  let cellReuseIdentifier = "cell"


    override func viewDidLoad() {
        super.viewDidLoad()

      if dummyData.count == 0 {
          wishingWellTableView.backgroundView = emptyView
      } else {
          wishingWellTableView.backgroundView = nil
      }

      wishingWellTableView.dataSource = self
      wishingWellTableView.delegate = self

      wishingWellTableView.showsVerticalScrollIndicator = true
      wishingWellTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

      wishingWellTableView.reloadData()
    }

  override func viewWillAppear(_ animated: Bool) {
    if dummyData.count == 0 {
        wishingWellTableView.backgroundView = emptyView
    } else {
        wishingWellTableView.backgroundView = nil
    }

    wishingWellTableView.dataSource = self
    wishingWellTableView.delegate = self

    wishingWellTableView.showsVerticalScrollIndicator = true
    wishingWellTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
  }

  @IBAction func addAWishButtonPressed(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "AddWishingWell", bundle: nil)
    let addWishingWellViewController = storyboard.instantiateViewController(withIdentifier: "addWishingWell") as! AddWishingWellViewController
    self.present(addWishingWellViewController, animated: true, completion: nil)
  }

  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dummyData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // create a new cell if needed or reuse an old one
    let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!

    cell.textLabel?.text = dummyData[indexPath.row]

    return cell
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    if dummyData.count == 0 {
        wishingWellTableView.backgroundView = emptyView
    } else {
        wishingWellTableView.backgroundView = nil
    }

          if editingStyle == .delete {

              // remove the item from the data model
              dummyData.remove(at: indexPath.row)

              // delete the table view row
              tableView.deleteRows(at: [indexPath], with: .fade)

            wishingWellTableView.reloadData()
            if dummyData.count == 0 {
                wishingWellTableView.backgroundView = emptyView
            } else {
                wishingWellTableView.backgroundView = nil
            }

          } else if editingStyle == .insert {
              // Not used in our example, but if you were adding a new row, this is where you would do it.
          }
      }


}
