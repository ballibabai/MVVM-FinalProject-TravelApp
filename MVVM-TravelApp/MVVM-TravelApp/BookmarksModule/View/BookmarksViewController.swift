//
//  BookmarksViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class BookmarksViewController: UIViewController {
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    private var  bookmarksVM = BookmarksViewModel()
   // private var dataAll2 = [AllDataEntity]()
    private var dataAll3 = [BookmarkData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        bookmarksVM.bookmarksVMDelegate = self
        denemee()
        
    }
    
    func denemee(){
        dataAll3 = bookmarksVM.didViewLoad()
    }
    
    func setupUI(){
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        bookmarksTableView.register(.init(nibName: "BookmarksTableViewCell", bundle: nil), forCellReuseIdentifier: "BookmarksTableViewCell")
    }
    
}

extension BookmarksViewController: UITableViewDelegate {
    
}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAll3.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell", for: indexPath) as! BookmarksTableViewCell
        cell.bookmarksDescLabel.text = dataAll3[indexPath.row].dataDescription
        cell.bookmarksTitleLabel.text = dataAll3[indexPath.row].dataTitle
        if let url = dataAll3[indexPath.row].dataImage {
            let thisUrl = URL(string: url)
            cell.bookmarksImageView.kf.setImage(with: thisUrl)
        }
        return cell
    }
}

extension BookmarksViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension BookmarksViewController: BookmarksViewModelProtocol {
    func didCellFetchToDo(_ bookData: [BookmarkData]) {
        self.dataAll3 = bookData
       // self.dataAll2 = bookData
        DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
                }
    }
    
    
}
