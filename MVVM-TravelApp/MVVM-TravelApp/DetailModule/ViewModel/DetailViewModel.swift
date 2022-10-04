//
//  DetailViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

final class DetailViewModel {
    
    var detailModel: DetailModel?
    
    init(detailModel: DetailModel){
        self.detailModel = detailModel
    }
    
    func dataTry(_ article: ArticleEntity){
        detailModel?.trySome(article)
    }
}
