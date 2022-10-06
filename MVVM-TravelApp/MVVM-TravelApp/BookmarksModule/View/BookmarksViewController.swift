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
    private var dataAll2 = [SearchEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        bookmarksVM.bookmarksVMDelegate = self
        bookmarksVM.didViewLoad()
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
        return dataAll2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell", for: indexPath) as! BookmarksTableViewCell
        cell.bookmarksDescLabel.text = dataAll2[indexPath.row].description
        cell.bookmarksTitleLabel.text = dataAll2[indexPath.row].name
        if let url = dataAll2[indexPath.row].image {
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
    func didCellFetchToDo(_ bookData: [SearchEntity]) {
        self.dataAll2 = bookData
        DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
                }
    }
    
    
}
