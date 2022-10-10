//
//  ArticleCollectionViewCell.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    //MARK: - UI Elements
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    //MARK: - Properties
    var row: Int!
    var onTappedButton: ((Int) -> ())?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
        imageView.layer.cornerRadius = 8
    }
    
    //MARK: - Functions
    @IBAction func addArticleToBookmark(_ sender: UIButton) {
        onTappedButton?(row)
    }
}

