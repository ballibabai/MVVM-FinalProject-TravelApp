//
//  DetailModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

final class DetailModel {
    
    weak var detailVM: DetailViewModel?
    private var id: Int
    
    var deneme: ArticleEntity?
    
    init(id: Int){
        self.id = id
    }
 
    func trySome(_ article: ArticleEntity) {
        deneme = article
    }
}
