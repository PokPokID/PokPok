//
//  WishingWellTableViewCell.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 25/11/21.
//

import UIKit

class WishingWellTableViewCell: UITableViewCell {

  @IBOutlet weak var wishingWellView: UIView!
  @IBOutlet weak var wishNameLabel: UILabel!
  @IBOutlet weak var wishDateLabel: UILabel!
  @IBOutlet weak var wishProgress: UIProgressView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.wishingWellView.layer.cornerRadius = 10
    self.wishingWellView.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.wishingWellView.layer.shadowColor = UIColor.black.cgColor
    self.wishingWellView.layer.shadowOpacity = 0.3
    self.wishingWellView.layer.shadowRadius = 2

    self.wishingWellView.layer.backgroundColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1).cgColor

    wishProgress.transform = wishProgress.transform.scaledBy(x: 1, y: 3)
    wishProgress.progressTintColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    wishProgress.trackTintColor = UIColor(red: 0.887, green: 0.828, blue: 0.833, alpha: 1)
    wishProgress.layer.cornerRadius = 3
    wishProgress.clipsToBounds = true



  }

  func commonInit(line: WishingWell) {
    wishNameLabel.text = line.name
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: line.date!)
    wishDateLabel.text = "\(selectedDate)"
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
