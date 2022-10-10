//
//  BookmarksTableViewCell.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 7.10.2022.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    @IBOutlet weak var bookmarksContainerView: UIView!
    @IBOutlet weak var bookmarksImageView: UIImageView!
    @IBOutlet weak var bookmarksTitleLabel: UILabel!
    @IBOutlet weak var bookmarksDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
