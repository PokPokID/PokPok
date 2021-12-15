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
  @IBOutlet weak var chevronImage: UIImageView!


  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.wishingWellView.layer.cornerRadius = 10
    self.wishingWellView.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.wishingWellView.layer.shadowColor = UIColor.black.cgColor
    self.wishingWellView.layer.shadowOpacity = 0.3
    self.wishingWellView.layer.shadowRadius = 2

    wishNameLabel.textColor = .white
    wishDateLabel.textColor = .white
    chevronImage.tintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1)

    self.wishingWellView.layer.backgroundColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor

    wishProgress.transform = wishProgress.transform.scaledBy(x: 1, y: 3)
    wishProgress.progressTintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1)
//    UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    wishProgress.trackTintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 0.5)
//    UIColor(red: 0.887, green: 0.828, blue: 0.833, alpha: 1)
    wishProgress.layer.cornerRadius = 3
    wishProgress.clipsToBounds = true




  }

  func commonInit(line: WishingWell) {
    wishNameLabel.text = line.name
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM yyyy"
    let selectedDate = dateFormatter.string(from: line.date!)
    wishDateLabel.text = "\(selectedDate)"
    wishProgress.progress = Float(line.saving)/Float(line.amount)

    if(line.date!.timeIntervalSinceNow < -86400 && !line.isCompleted){
      wishNameLabel.text = line.name! + " (Expired)"
      wishNameLabel.textColor = .darkGray
      wishDateLabel.textColor = .darkGray
      wishProgress.progressTintColor = .darkGray
      wishProgress.trackTintColor = .lightGray
      chevronImage.tintColor = .darkGray

      wishingWellView.layer.backgroundColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1).cgColor
      isUserInteractionEnabled = false
    } else if (line.isCompleted || !line.isCompleted) {
      if(line.isCompleted){
        wishNameLabel.text = line.name! + " (Completed)"
        wishNameLabel.textColor = .black
        wishDateLabel.textColor = .black
        chevronImage.tintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1)

        self.wishingWellView.layer.backgroundColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1).cgColor

        wishProgress.progressTintColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0)
//        wishProgress.trackTintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 0.5)
        isUserInteractionEnabled = false
      } else {
        wishNameLabel.text = line.name
        wishNameLabel.textColor = .white
        wishDateLabel.textColor = .white
        chevronImage.tintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1)

        self.wishingWellView.layer.backgroundColor = UIColor(red: 107.0/255.0, green: 46.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor

        wishProgress.progressTintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 1)
        wishProgress.trackTintColor = UIColor(red: 1, green: 0.984, blue: 0.946, alpha: 0.5)
        isUserInteractionEnabled = true
      }

    }


  }


  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
