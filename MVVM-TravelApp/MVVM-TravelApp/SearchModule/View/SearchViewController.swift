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
    @IBOutlet weak var noDataFound: UIImageView!
    
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
        searchVMInstance.didViewLoad()
        noDataFound.isHidden = true
        if enumType == .hotel {
            hotelClicked.setImage(UIImage(named: "home tab"), for: .normal) //full
            flightClicked.setImage(UIImage(named: "Group 1-1"), for: .normal) //empty
            searchTextField.text = ""
            searchData.removeAll()
        }else {
            hotelClicked.setImage(UIImage(named: "home tab-1"), for: .normal) //empty
            flightClicked.setImage(UIImage(named: "Group 1"), for: .normal) //full
            searchTextField.text = ""
            searchData.removeAll()
        }
    }
    //MARK: - Functions
    @IBAction func hotelButtonClicked(_ sender: UIButton) {
        enumType = .hotel
        searchVMInstance.vmEnumTpye = .hotel
        searchVMInstance.didViewLoad()
        sender.setImage(UIImage(named: "home tab"), for: .normal)
        flightClicked.imageView?.image = UIImage(named: "Group 1-1")
        searchTextField.text = ""
        searchData.removeAll()
    }
    @IBAction func flightButtonClicked(_ sender: UIButton) {
        enumType = .flight
        searchVMInstance.vmEnumTpye = .flight
        searchVMInstance.didViewLoad()
        sender.setImage(UIImage(named: "Group 1"), for: .normal)
        hotelClicked.imageView?.image = UIImage(named: "home tab-1")
        searchTextField.text = ""
        searchData.removeAll()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        //Todo
    }
    @IBAction func searchTextEdit(_ sender: UITextField) {
        self.noDataFound.isHidden = true
        if enumType == .hotel {
            didSearchForHotel(sender)
        }else {
            didSearchForFlight(sender)
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
    }
    func registerCell(){
        searchTableView.register(.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    func navigateDetail(_ index: Int){
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
            detailVC.allDataEntity = searchData[index] //pass to data DetailsVC from here
            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // search for the hotel
    func didSearchForHotel(_ sender: UITextField){
        let searchEntitiyHotel = searchVMInstance.getListHotel()
        if let searchText = sender.text{
            if searchText.count > 2{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in //delay 0.5 second for search
                    guard let self = self else {return}
                        self.searchData = searchEntitiyHotel.filter{
                            $0.title!.lowercased().contains(searchText.lowercased())
                        }
                    if self.searchData.count < 1 { //control is there data if no data shows image
                            self.searchTableView.isHidden = true
                            self.noDataFound.isHidden = false
                    }else {
                        self.searchTableView.isHidden = false
                        self.noDataFound.isHidden = true
                    }
                    self.searchTableView.reloadData()
                    }
            }else {
                searchData.removeAll()
                self.searchTableView.reloadData()
            }
        }
    }
    
    //search for the flight
    func didSearchForFlight(_ sender: UITextField){
        let searchEntitiyFlight = searchVMInstance.getListFlight()
        if let searchText = sender.text {
           if searchText.count > 2 {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                   guard let self = self else {return}
                    self.searchData = searchEntitiyFlight.filter{
                        $0.title!.lowercased().contains(searchText.lowercased())}
                   if self.searchData.count < 1 {
                            self.searchTableView.isHidden = true
                            self.noDataFound.isHidden = false
                    }else {
                        self.searchTableView.isHidden = false
                        self.noDataFound.isHidden = true
                    }
                    self.searchTableView.reloadData()
                }
            }else {
                searchData.removeAll()
                self.searchTableView.reloadData()
            }
        }
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
