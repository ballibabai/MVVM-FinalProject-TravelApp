//
//  ViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 3.10.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties/Instance
    var enumType: whichButton?
    private let homeArticleViewModel = HomeArticleViewModel()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        homeArticleViewModel.viewDelegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        homeArticleViewModel.didViewLoad()
        collectionView.reloadData()
        
    }
    
    //MARK: - Functions
    @IBAction func hotelFlightClicked(_ sender: UIButton) {
        if sender.tag == 0 {
                let flight = storyboard?.instantiateViewController(withIdentifier: "toListVC") as! ListViewController
                flight.enumType = .flight
                navigationController?.pushViewController(flight, animated: true)
        }else {
                let hotel = storyboard?.instantiateViewController(withIdentifier: "toListVC") as! ListViewController
                hotel.enumType = .hotel
                navigationController?.pushViewController(hotel, animated: true)
        }
    }
}

//MARK: - Extensions
private extension HomeViewController {
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    func registerCell(){
        collectionView.register(.init(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
    }
    
    func navigateDetail(_ index: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        detailVC.allDataEntity = homeArticleViewModel.getArticle(at: index)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func clickedButtonForClosure(at selectedItem: AllDataEntity){
        var buttonType: ButtonType = .add
        for i in homeArticleViewModel.didViewLoad2(){
            if i.dataTitle == selectedItem.title {
                buttonType = .remove
                print("try")
            }
        }
        if buttonType == .add {
            homeArticleViewModel.saveButtonTapped(titleText: selectedItem.title!, descriptionText: selectedItem.description!, imageView: selectedItem.images!)
            print("Added")
        }else{
            homeArticleViewModel.didDeleteDataFromCoreData(selectedItem.title!)
            print("Deleted")
        }
    }
}
//MARK: - Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateDetail(indexPath.row)
    }
}
//MARK: - DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeArticleViewModel.numberOfItems()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as! ArticleCollectionViewCell
        let selectedItem = homeArticleViewModel.getArticle(at: indexPath.row)
        
        cell.titleLabel.text = selectedItem.title
        cell.categoryLabel.text = selectedItem.category
        if let url = selectedItem.images {
                  let thisUrl = URL(string: url)
                  cell.imageView.kf.setImage(with: thisUrl) //KingFisher for url convert to image
              }
        
        cell.bookmarkButton.setImage(UIImage(named: "Bookmark"), for: .normal)

        for i in homeArticleViewModel.didViewLoad2(){
            if i.dataTitle == selectedItem.title {
                cell.bookmarkButton.setImage(UIImage(named: "Vector"), for: .normal)
            }
        }
        cell.row = indexPath.row
        cell.onTappedButton = { [weak self] index in
            guard let self = self else {return}
            self.clickedButtonForClosure(at: selectedItem)
            print(index)
          collectionView.reloadItems(at: [indexPath])
        }
        return cell
    }
}

//MARK: - FlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
    }
    
}

//MARK: - Protocol
extension HomeViewController: HomeArticleViewModelProtocol {
    func didCellItemFetch(_ isSuccess: Bool) {
        if isSuccess{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

