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
    @IBOutlet weak var onOffButton: UIButton!
    

    var allDataEntity: AllDataEntity?
    
    var detailVM = DetailViewModel()
    var bookmarksVMInstance = BookmarksViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        backButton.layer.cornerRadius = 8
        allDataUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        for i in bookmarksVMInstance.didViewLoad(){
            if i.dataTitle == titleLabel.text {
                onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
            }
        }
    }
    
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
    
    @IBAction func addButtonTapped(_ sender: UIButton) {

        if !bookmarksVMInstance.didViewLoad().isEmpty{
            for i in bookmarksVMInstance.didViewLoad(){
                if i.dataTitle == titleLabel.text {
                    detailVM.didDeleteDataFromCoreData(titleLabel.text!)
                    onOffButton.setImage(UIImage(named: "Button-0"), for: .normal)
                    print("silindi")
                    break
                }else {
                    detailVM.saveButtonTapped(titleText: (allDataEntity?.title)!,
                                              descriptionText: (allDataEntity?.description)!,
                                              imageView: (allDataEntity?.images)!)
                    onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
                    print("çok eklendi")
                    break
                }
            }
        }else {
            detailVM.saveButtonTapped(titleText: (allDataEntity?.title)!,
                                      descriptionText: (allDataEntity?.description)!,
                                      imageView: (allDataEntity?.images)!)
            onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
            print("ilk eklendi")
        }
        
//
//        if bookmarksVMInstance.didViewLoad().isEmpty {
//               detailVM.saveButtonTapped(titleText: (allDataEntity?.title)!,
//                                         descriptionText: (allDataEntity?.description)!,
//                                         imageView: (allDataEntity?.images)!)
//               onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
//               print("ilk eklendi")
//           }else{
//               for i in bookmarksVMInstance.didViewLoad(){
//                   if i.dataTitle == titleLabel.text{
//                       detailVM.didDeleteDataFromCoreData(titleLabel.text!)
//                       onOffButton.setImage(UIImage(named: "Button-0"), for: .normal)
//                       print("silindi")
//                       break
//                   }else if i.dataTitle != titleLabel.text{
//                       detailVM.saveButtonTapped(titleText: (allDataEntity?.title)!,
//                                                 descriptionText: (allDataEntity?.description)!,
//                                                 imageView: (allDataEntity?.images)!)
//                       onOffButton.setImage(UIImage(named: "Button-1"), for: .normal)
//                       print("çok eklendi")
//                       break
//                   }
//               }
//           }

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

}

//extension DetailViewController: DetailViewModelProtocol {
//    func didFetchDataFromCoreData(_ isSuccess: Bool) {
//        if isSuccess {
//         //   detailVM.didFetchCoreData(true)
//        }
//    }
//
    

