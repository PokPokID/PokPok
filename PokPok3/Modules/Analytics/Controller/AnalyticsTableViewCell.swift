//
//  AnalyticsTableViewCell.swift
//  PokPok3
//
//  Created by Dinaka Sadariskar on 05/12/21.
//

import UIKit

class AnalyticsTableViewCell: UITableViewCell {

  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var analyticsProgressBar: UIProgressView!
  @IBOutlet weak var categoryBudgetLabel: UILabel!
  @IBOutlet weak var categoryColor: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    analyticsProgressBar.transform = analyticsProgressBar.transform.scaledBy(x: 1, y: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
