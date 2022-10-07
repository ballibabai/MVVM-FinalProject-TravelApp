//
//  ViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 3.10.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var enumType: whichButton?
    private let homeArticleViewModel = HomeArticleViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        homeArticleViewModel.viewDelegate = self
        homeArticleViewModel.didViewLoad()
    }
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

private extension HomeViewController {
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    func registerCell(){
        collectionView.register(.init(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCollectionViewCell")
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeArticleViewModel.didClickItem(at: indexPath.row)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeArticleViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as! ArticleCollectionViewCell
        cell.titleLabel.text = homeArticleViewModel.getArticle(at: indexPath.row).title
        cell.categoryLabel.text = homeArticleViewModel.getArticle(at: indexPath.row).category
        if let url = homeArticleViewModel.getArticle(at: indexPath.row).images {
                  let thisUrl = URL(string: url)
                  cell.imageView.kf.setImage(with: thisUrl) //KingFisher for url convert to image
              }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)
    }
    
}

extension HomeViewController: HomeArticleViewModelProtocol {
    func didCellItemFetch(_ isSuccess: Bool) {
        if isSuccess{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func navigateDetail(_ id: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        detailVC.allDataEntity = homeArticleViewModel.getArticle(at: id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

