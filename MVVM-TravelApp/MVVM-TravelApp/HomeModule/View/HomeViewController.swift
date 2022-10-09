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
    private let bookMarkViewModel = BookmarksViewModel()
    private let detailVC = DetailViewController()
    private let detailVM = DetailViewModel()
    var buttonType: ButtonType = .add
    var coreData = [BookmarkData]()
    var data1 = [BookmarkData]()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        homeArticleViewModel.viewDelegate = self
        //homeArticleViewModel.didViewLoad()
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
        
        for i in bookMarkViewModel.didViewLoad(){
            if i.dataTitle == selectedItem.title {
                cell.bookmarkButton.setImage(UIImage(named: "Vector"), for: .normal)
                //buttonType = .remove
                print(index)
                print("deneme1")
            }
        }
        self.collectionView.reloadItems(at: [indexPath])
        cell.row = indexPath.row
        cell.onTappedButton = { [self] index in
            
            for i in bookMarkViewModel.didViewLoad(){
                if i.dataTitle == selectedItem.title {
                    cell.bookmarkButton.setImage(UIImage(named: "Vector"), for: .normal)
                    buttonType = .remove
                    print("deneme2")
                    print(index)
                }
            }
            if buttonType == .add {
                detailVM.saveButtonTapped(titleText: selectedItem.title!, descriptionText: selectedItem.description!, imageView: selectedItem.images!)
                cell.bookmarkButton.setImage(UIImage(named: "Vector"), for: .normal)
                buttonType = .remove
                
                print(index)
                print("Added")
            }else{
                detailVM.didDeleteDataFromCoreData(selectedItem.title!)
                cell.bookmarkButton.setImage(UIImage(named: "Bookmark"), for: .normal)
                buttonType = .add
                print(index)
                print("Deleted")
            }
          //  self.collectionView.reloadItems(at: [indexPath])
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

