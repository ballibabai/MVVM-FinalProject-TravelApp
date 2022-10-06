//
//  ListTableViewCell.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hotelFlightImageView: UIImageView!
    @IBOutlet weak var hotelFlightName: UILabel!
    @IBOutlet weak var hotelFlightDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
