//
//  ListViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var enumLabel: UILabel!
    
    //MARK: - Properties
    private let listViewModelInstance = ListViewModel()
    var enumType: whichButton?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        listViewModelInstance.ListViewModelDelegate = self
        //listViewModelInstance.didViewLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listViewModelInstance.didViewLoad()
    }
    
    //MARK: - Functions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions
private extension ListViewController {
    func setupUI(){
        if enumType == .flight {
            enumLabel.text = "Flight"
            listViewModelInstance.vmEnumType = .flight
        }else {
            enumLabel.text = "Hotel"
            listViewModelInstance.vmEnumType = .hotel
        }
        listTableView.delegate = self
        listTableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        listTableView.register(.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
    
    func navigateDetail(_ index: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        if enumType == .flight {
            detailVC.allDataEntity = listViewModelInstance.getListFlight(at: index)
            navigationController?.pushViewController(detailVC, animated: true)
        }else {
            detailVC.allDataEntity = listViewModelInstance.getListHotel(at: index)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: - Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateDetail(indexPath.row)
    }
}

//MARK: - DataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if enumType == .flight {
            return listViewModelInstance.numberOfItemsFlight()
        }else {
            return listViewModelInstance.numberOfItemsHotel()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if enumType == .flight {
            let selectedItem = listViewModelInstance.getListFlight(at: indexPath.row)
            cell.hotelFlightDesc.text = selectedItem.description
            cell.hotelFlightName.text = selectedItem.title
            if let url = selectedItem.images {
                let thisUrl = URL(string: url)
                cell.hotelFlightImageView.kf.setImage(with: thisUrl)
            }
        }else {
            let selectedItem = listViewModelInstance.getListHotel(at: indexPath.row)
            cell.hotelFlightDesc.text = selectedItem.description
            cell.hotelFlightName.text = selectedItem.title
            if let url = selectedItem.images {
                let thisUrl = URL(string: url)
                cell.hotelFlightImageView.kf.setImage(with: thisUrl)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

//MARK: - Protocol
extension ListViewController: ListViewModelProtocol {
    func didCellItemFetch(_ isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
}
