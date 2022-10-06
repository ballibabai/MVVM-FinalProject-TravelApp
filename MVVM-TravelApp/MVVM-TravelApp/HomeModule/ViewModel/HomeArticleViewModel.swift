//
//  HomeArticleViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

protocol HomeArticleViewModelProtocol: AnyObject {
    func didCellItemFetch(_ isSuccess: Bool)
    func navigateDetail(_ id: Int)
}

final class HomeArticleViewModel {
    
    weak var viewDelegate: HomeArticleViewModelProtocol?
    private let homeArticleModel = HomeArticleModel()

    init(){
          homeArticleModel.delegate = self
      }
    
    func didViewLoad(){
        homeArticleModel.fetchData() //raw data
    }
    
    func numberOfSections() -> Int {1}
    
    func numberOfItems() -> Int {
        return homeArticleModel.articles.count
    }
    
    func getArticle(at index: Int) -> ArticleEntity {
        return transfromArticleToArticleEntity(homeArticleModel.articles[index])
    }
        
    func didClickItem(at index: Int){
        let selectedItem = homeArticleModel.articles[index]
        viewDelegate?.navigateDetail(selectedItem.id!)
        print(selectedItem)
      }
    
     func transfromArticleToArticleEntity(_ article: Article) -> ArticleEntity{
        
        return .init(id: article.id, category: article.category, images: article.images, description: article.description, title: article.title)
    }
    
}
extension HomeArticleViewModel: HomeArticleModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(true)
            
        }else {
            print("erorr viewModel")
            viewDelegate?.didCellItemFetch(false)
        }
    }
    
    
}
