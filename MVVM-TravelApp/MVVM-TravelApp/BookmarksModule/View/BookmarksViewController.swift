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
    private var dataAll3 = [BookmarkData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        bookmarksVM.bookmarksVMDelegate = self
        denemee()
        
    }
    
}

private extension BookmarksViewController {
    func setupUI(){
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        bookmarksTableView.register(.init(nibName: "BookmarksTableViewCell", bundle: nil), forCellReuseIdentifier: "BookmarksTableViewCell")
    }
    func denemee(){
        dataAll3 = bookmarksVM.didViewLoad()
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarksVM.didClickItem(at: indexPath.row)
    }
}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksVM.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell", for: indexPath) as! BookmarksTableViewCell
        //let selectedItem = bookmarksVM.getDetailData(indexPath.row)
        let selectedItem2 = bookmarksVM.getDetailDataForAllData(at: indexPath.row)
        cell.bookmarksDescLabel.text = selectedItem2.description
        cell.bookmarksTitleLabel.text = selectedItem2.title
        if let url = selectedItem2.images {
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
    func didCellFetchToDo(_ isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
            }
        }
    }
    
    func navigateDetail(_ id: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        detailVC.allDataEntity = bookmarksVM.getDetailDataForAllData(at: id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
//    func didCellFetchToDo(_ bookData: [BookmarkData]) {
//        self.dataAll3 = bookData
//       // self.dataAll2 = bookData
//        DispatchQueue.main.async {
//                    self.bookmarksTableView.reloadData()
//                }
//    }
//
    
}
