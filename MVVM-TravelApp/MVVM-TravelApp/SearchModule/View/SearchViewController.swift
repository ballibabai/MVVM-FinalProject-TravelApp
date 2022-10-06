//
//  SearchViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var hotelClicked: UIButton!
    @IBOutlet weak var flightClicked: UIButton!
    
    private let searchVMInstance = SearchViewModel()
    var enumType: whichButton? = .hotel
    var searchEntitiy = [SearchEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        setupUI()
        searchVMInstance.searchViewModelDelegate = self
        didload()
        view.largeContentTitle = "Deneme"
    }

    private func setupUI(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        registerCell()
        searchTableView.reloadData()
    }
    
    func didload(){
        if enumType == .hotel {
            searchVMInstance.didViewLoad()
        }else {
            searchVMInstance.didViewLoadFlight()
        }
    }
    
    func registerCell(){
        searchTableView.register(.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    @IBAction func hotelButtonClicked(_ sender: UIButton) {
        enumType = .hotel
        searchVMInstance.vmEnumTpye = .hotel
        didload()
        sender.setImage(UIImage(named: "home tab"), for: .normal)
        flightClicked.imageView?.image = UIImage(named: "Group 1-1")
        searchTableView.reloadData()
    }
    @IBAction func flightButtonClicked(_ sender: UIButton) {
        enumType = .flight
        searchVMInstance.vmEnumTpye = .flight
        didload()
        sender.setImage(UIImage(named: "Group 1"), for: .normal)
        hotelClicked.imageView?.image = UIImage(named: "home tab-1")
        searchTableView.reloadData()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        //Todo
    }
    @IBAction func searchTextEdit(_ sender: UITextField) {
        if enumType == .hotel {
            let searchEntitiyHotel = searchVMInstance.getListHotel()
            if let searchText = sender.text {
                self.searchEntitiy = searchEntitiyHotel.filter{
                    $0.name!.lowercased().contains(searchText.lowercased())}
                print(searchEntitiy)
                searchTableView.reloadData()
            }
    
    
        }else {
            let searchEntitiyFlight = searchVMInstance.getListFlight()
            if let searchText = sender.text {
                self.searchEntitiy = searchEntitiyFlight.filter{
                    $0.name!.lowercased().contains(searchText.lowercased())}
                print(searchEntitiy)
                searchTableView.reloadData()
            }
        
        }
    
    }
}
//MARK: - Extensions

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
            detailVC.searchList = searchEntitiy[indexPath.row] //pass to data DetailsVC from here
            navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchEntitiy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
       
           let selectedItem = searchEntitiy[indexPath.row]
            cell.searchTitleLabel.text = selectedItem.name
            cell.searchDescLabel.text = selectedItem.description
            if let url = selectedItem.image {
                let thisURL = URL(string: url)
                cell.searchImageView.kf.setImage(with: thisURL)
               // self.searchTableView.reloadData()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension SearchViewController: searchViewModelProtocol {
//    func navigateDetail(_ id: Int) {
//        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
//        if enumType == .flight {
//            detailVC.searchList = searchVMInstance.getListFlightToDetail(at: id)
//            navigationController?.pushViewController(detailVC, animated: true)
//        }else {
//            detailVC.searchList = searchVMInstance.getListHotelToDetail(at: id)
//            navigationController?.pushViewController(detailVC, animated: true)
//        }
//    }
    
    func didCellItemFetch(_ isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }else{
            print("eerorrr searchVC")
        }
    }
    
    
}
