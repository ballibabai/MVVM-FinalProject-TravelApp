//
//  SearchViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UITextFieldDelegate {
    //MARK: - UI Elements
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var hotelClicked: UIButton!
    @IBOutlet weak var flightClicked: UIButton!
    
    //MARK: - Properties
    private let searchVMInstance = SearchViewModel()
    var enumType: whichButton = .hotel
    var searchData = [AllDataEntity]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        setupUI()
        searchVMInstance.searchViewModelDelegate = self
        view.largeContentTitle = "Deneme"
    }
    override func viewWillAppear(_ animated: Bool) {
        didload()
    }

    //MARK: - Functions

    @IBAction func hotelButtonClicked(_ sender: UIButton) {
        enumType = .hotel
        searchVMInstance.vmEnumTpye = .hotel
        didload()
        sender.setImage(UIImage(named: "home tab"), for: .normal)
        flightClicked.imageView?.image = UIImage(named: "Group 1-1")
        searchTextField.text = ""
        searchData.removeAll()
        searchTableView.reloadData()
    }
    @IBAction func flightButtonClicked(_ sender: UIButton) {
        enumType = .flight
        searchVMInstance.vmEnumTpye = .flight
        didload()
        sender.setImage(UIImage(named: "Group 1"), for: .normal)
        hotelClicked.imageView?.image = UIImage(named: "home tab-1")
        searchTextField.text = ""
        searchData.removeAll()
        searchTableView.reloadData()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        //Todo
    }
    @IBAction func searchTextEdit(_ sender: UITextField) {
        if enumType == .hotel {
            let searchEntitiyHotel = searchVMInstance.getListHotel()
            if let searchText = sender.text {
                if searchText.count > 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.searchData = searchEntitiyHotel.filter{
                            $0.title!.lowercased().contains(searchText.lowercased())}
                       // print(searchEntitiy)
                        self.searchTableView.reloadData()
                    }
                }else {
                    searchData.removeAll()
                    self.searchTableView.reloadData()
                }
            }
        }else {
            let searchEntitiyFlight = searchVMInstance.getListFlight()
            if let searchText = sender.text {
               if searchText.count > 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.searchData = searchEntitiyFlight.filter{
                            $0.title!.lowercased().contains(searchText.lowercased())}
                       // print(searchEntitiy)
                        self.searchTableView.reloadData()
                    }
                }else {
                    searchData.removeAll()
                    self.searchTableView.reloadData()
                }
            }
        
        }
    
    }
}
//MARK: - Extensions

private extension SearchViewController {
    func setupUI(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        registerCell()
        searchTableView.reloadData()
        didload()
    }
    func registerCell(){
        searchTableView.register(.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    func didload(){
        searchVMInstance.didViewLoad()
    }
    func navigateDetail(_ index: Int){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
            detailVC.allDataEntity = searchData[index] //pass to data DetailsVC from here
            navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - TableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateDetail(indexPath.row)
    }
}

//MARK: - TableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
       
           let selectedItem = searchData[indexPath.row]
            cell.searchTitleLabel.text = selectedItem.title
            cell.searchDescLabel.text = selectedItem.description
            if let url = selectedItem.images {
                let thisURL = URL(string: url)
                cell.searchImageView.kf.setImage(with: thisURL)
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

//MARK: - Protocol
extension SearchViewController: searchViewModelProtocol {
    
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
