//
//  WishingWellViewController.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 23/11/21.
//

import UIKit
import CoreData

class WishingWellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var wishingWellTableView: UITableView!
  @IBOutlet var emptyView: UIView!
  @IBOutlet weak var addAWish: UIButton!

  var wishes = [WishingWell]()
  let cellReuseIdentifier = "cell"


  override func viewDidLoad() {
    super.viewDidLoad()

    getData()

    isViewEmpty()

    wishingWellTableView.dataSource = self
    wishingWellTableView.delegate = self

    wishingWellTableView.showsVerticalScrollIndicator = true
    wishingWellTableView.separatorStyle = .none

    let nib = UINib.init(nibName: "WishingWellCell", bundle: nil)
    wishingWellTableView.register(nib, forCellReuseIdentifier: "wishingWellCell")

    wishingWellTableView.reloadData()
  }

  override func viewWillAppear(_ animated: Bool) {

    getData()
    
    isViewEmpty()

    wishingWellTableView.dataSource = self
    wishingWellTableView.delegate = self

    wishingWellTableView.showsVerticalScrollIndicator = true
    wishingWellTableView.separatorStyle = .none

    let nib = UINib.init(nibName: "WishingWellCell", bundle: nil)
    wishingWellTableView.register(nib, forCellReuseIdentifier: "wishingWellCell")

    wishingWellTableView.reloadData()
  }

  @IBAction func addAWishButtonPressed(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "AddWishingWell", bundle: nil)
    let addWishingWellViewController = storyboard.instantiateViewController(withIdentifier: "addWishingWell") as! AddWishingWellViewController
    self.present(addWishingWellViewController, animated: true, completion: nil)
  }

  @IBAction func unwindToWishingWell(_ sender: UIStoryboardSegue) {}

  func isViewEmpty() {
    if wishes.count == 0 {
      wishingWellTableView.backgroundView = emptyView
    } else {
      wishingWellTableView.backgroundView = nil
    }

  }

  // MARK: - CORE DATA

  func getData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<WishingWell>(entityName: "WishingWell")
    let sort = NSSortDescriptor(key: #keyPath(WishingWell.date), ascending: true)
    fetchRequest.sortDescriptors = [sort]

    do {
      try wishes = context.fetch(fetchRequest)
    } catch {

    }

  }

  // MARK: - TABLE VIEW

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wishes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "wishingWellCell", for: indexPath) as? WishingWellTableViewCell
    let line = wishes[indexPath.row]

    cell?.commonInit(line: line)
    cell?.selectionStyle = .none

    return cell!

  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 132
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    isViewEmpty()

    if editingStyle == .delete {

      wishes.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)

      isViewEmpty()

      wishingWellTableView.reloadData()

    } else if editingStyle == .insert {
      // Not used in our example, but if you were adding a new row, this is where you would do it.
    }
  }


}
