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
    var hotels: HotelList?
    var flight: FlightList?
    var searchList: SearchEntity?
    
    var detailVM: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIHotel()
        setupUIFlight()
        searchToDetail()
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
    func setupUIHotel(){
        if let hotels = hotels {
            titleLabel.text = hotels.name
            descriptionText.text = hotels.description
            if let images = hotels.image {
                iamgeView.kf.setImage(with: URL(string: images))
            }
        }
    }
    func setupUIFlight(){
        if let flight = flight {
            titleLabel.text = flight.name
            descriptionText.text = flight.description
            if let images = flight.image {
                iamgeView.kf.setImage(with: URL(string: images))
            }
        }
    }
    
    func searchToDetail(){
        if let searchList = searchList {
            titleLabel.text = searchList.name
            descriptionText.text = searchList.description
            if let images = searchList.image {
                iamgeView.kf.setImage(with: URL(string: images))
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}
