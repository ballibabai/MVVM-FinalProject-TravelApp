//
//  DetailViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var iamgeView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var onOffButton: UIButton!
    
    //MARK: - Properties
    var allDataEntity: AllDataEntity?
    private let detailVM = DetailViewModel()
    var buttonType: ButtonType = .add
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 8
        allDataUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        for i in detailVM.didViewLoad(){
            if i.dataTitle == titleLabel.text {
                onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
                buttonType = .remove
                break
            }
        }
    }
    //MARK: - Functions
    @IBAction func addButtonTapped(_ sender: UIButton) {
       saveAndDeleteCoreData()
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions
private extension DetailViewController {
    func allDataUI(){
        if let allDataEntity = allDataEntity {
            categoryLabel.text = allDataEntity.category
            titleLabel.text = allDataEntity.title
            descriptionText.text = allDataEntity.description
            if let images = allDataEntity.images {
                iamgeView.kf.setImage(with: URL(string: images))
            }
        }
    }
    func saveAndDeleteCoreData(){
        if buttonType == .add {
            detailVM.saveButtonTapped(titleText: (allDataEntity?.title)!,
                                      descriptionText: (allDataEntity?.description)!,
                                      imageView: (allDataEntity?.images)!)
            onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
            buttonType = .remove
            print("Added")
        }else{
            detailVM.didDeleteDataFromCoreData(titleLabel.text!)
            onOffButton.setImage(UIImage(named: "Button-0"), for: .normal)
            buttonType = .add
            print("Deleted")
        }

    }
}
