//
//  HomeArticleViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

protocol HomeArticleViewModelProtocol: AnyObject {
    func didCellItemFetch(_ articles: [Article])
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
    
}

extension HomeArticleViewModel: HomeArticleModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let articles = homeArticleModel.articles
            print(articles)
            viewDelegate?.didCellItemFetch(articles)
        }else {
            print("erorr viewModel")
        }
    }
    
    
}
