//
//  ArticleCollectionViewCell.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
    }

}
