//
//  BookmarksViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class BookmarksViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    //MARK: - Properties
    private var  bookmarksVM = BookmarksViewModel()
    private var dataAll3 = [BookmarkData]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookmarksVM.bookmarksVMDelegate = self
        denemee()
    }
    
}

//MARK: - Extensions
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
    
    func navigateDetail(_ index: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        detailVC.allDataEntity = bookmarksVM.getDetailDataForAllData(at: index)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - Delegate
extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateDetail(indexPath.row)
    }
}


//MARK: - DataSource
extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksVM.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell", for: indexPath) as! BookmarksTableViewCell
        let selectedItem2 = bookmarksVM.getDetailDataForAllData(at: indexPath.row)
        cell.bookmarksDescLabel.text = selectedItem2.description
        cell.bookmarksTitleLabel.text = selectedItem2.title
        if let url = selectedItem2.images {
            let thisUrl = URL(string: url)
            cell.bookmarksImageView.kf.setImage(with: thisUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
//MARK: - Protocol
extension BookmarksViewController: BookmarksViewModelProtocol {
    func didCellFetchToDo(_ isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
            }
        }
    }
}
