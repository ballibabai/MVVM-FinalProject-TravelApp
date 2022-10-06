//
//  DetailViewModel.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import Foundation
import UIKit

final class DetailViewModel {
    
    private let detailModelInstance = DetailModel()
    
    func saveButtonTapped(titleText: String, descriptionText: String, imageView: String){
        
        detailModelInstance.fetchData(titleText: titleText, descriptionText: descriptionText, imageView: imageView)
    }
    
}
