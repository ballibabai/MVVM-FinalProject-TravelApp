//
//  ListViewController.swift
//  MVVM-TravelApp
//
//  Created by İbrahim Ballıbaba on 4.10.2022.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var enumLabel: UILabel!
    
    private let listViewModelInstance = ListViewModel()
    var enumType: whichButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        listViewModelInstance.ListViewModelDelegate = self
        listViewModelInstance.didViewLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
 
}

private extension ListViewController {
    func setupUI(){
        if enumType == .flight {
            enumLabel.text = "Flight"
        }else {
            enumLabel.text = "Hotel"
        }
        listTableView.delegate = self
        listTableView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        listTableView.register(.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewModelInstance.didClickItem(at: indexPath.row)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if enumType == .flight {
            return listViewModelInstance.numberOfItemsFlight()
        }else {
            return listViewModelInstance.numberOfItems()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if enumType == .flight {
            cell.hotelFlightDesc.text = listViewModelInstance.getListFlight(at: indexPath.row).description
            cell.hotelFlightName.text = listViewModelInstance.getListFlight(at: indexPath.row).name
            if let url = listViewModelInstance.getListFlight(at: indexPath.row).image {
                let thisUrl = URL(string: url)
                cell.hotelFlightImageView.kf.setImage(with: thisUrl)
            }
        }else {
            cell.hotelFlightDesc.text = listViewModelInstance.getList(at: indexPath.row).description
            cell.hotelFlightName.text = listViewModelInstance.getList(at: indexPath.row).name
            if let url = listViewModelInstance.getList(at: indexPath.row).image {
                let thisUrl = URL(string: url)
                cell.hotelFlightImageView.kf.setImage(with: thisUrl)
            }
        }
        

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
}

extension ListViewController: ListViewModelProtocol {
    func didCellItemFetch(_ isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    func navigateDetail(_ id: Int) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "toDetailVC") as! DetailViewController
        if enumType == .flight {
            detailVC.flight = listViewModelInstance.getListFlight(at: id)
            navigationController?.pushViewController(detailVC, animated: true)
        }else {
            detailVC.hotels = listViewModelInstance.getList(at: id)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    
}
