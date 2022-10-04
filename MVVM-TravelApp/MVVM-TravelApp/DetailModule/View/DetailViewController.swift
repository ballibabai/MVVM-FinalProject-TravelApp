//
//  DetailViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var backButton: UIButton!
    
    var articles: ArticleEntity?
    
    var detailVM: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        //iamgeView.image = articles?.images
        backButton.layer.cornerRadius = 8
        
    }
    
    func setupUI(){
        if let articles = articles {
            categoryLabel.text = articles.category
            titleLabel.text = articles.title
            descriptionText.text = articles.description
            if let images = articles.images {
                iamgeView.kf.setImage(with: URL(string: images))
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}
