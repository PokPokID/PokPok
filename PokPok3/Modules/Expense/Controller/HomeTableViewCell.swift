//
//  HomeTableViewCell.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 25/11/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

  @IBOutlet weak var expenseName: UILabel!
  @IBOutlet weak var expenseCategory: UILabel!
  @IBOutlet weak var expenseAmount: UILabel!
  @IBOutlet weak var cellView: UIView!


  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.cellView.layer.backgroundColor = UIColor.clear.cgColor
    self.contentView.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func commonInit(line: Expenses) {
    expenseName.text = line.name
    expenseCategory.text = line.category
    expenseAmount.text = "\(line.amount)"
  }

}
