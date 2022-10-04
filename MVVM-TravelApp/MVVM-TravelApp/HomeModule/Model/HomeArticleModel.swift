//
//  HomeArticleModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation

protocol HomeArticleModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class HomeArticleModel {
    
    weak var delegate: HomeArticleModelProtocol?
    var articles = [Article]()
    
    func fetchData(){
        guard let path = Bundle.main.path(forResource: "HomeArticledata", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(ArticleRecord.self, from: data)
            if let array = result.abc{
                articles = array
                delegate?.didDataFetchProcessFinish(true)
                print("deenemeee")
            }
            
        }catch {
            print("eerorrr model")
            delegate?.didDataFetchProcessFinish(false)
        }
    }
    
}
