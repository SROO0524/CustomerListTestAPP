//
//  MainViewController.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

class MainViewController: UIViewController {

//    MARK: Properties
    let url = "http://crm-staging.gongbiz.kr/app/v2020/cust"
    var loading = false
    var isEnded = false
    var customerInfos : [CustomerInfo] = [] {
        didSet{
            tableView.reloadData()
            loading = false
        }
    }
    var page = 1

//    private let dataFetch = DataFetch()
    private let topDefaultView = TopDefaultView()
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(CustomerListTableViewCell.self, forCellReuseIdentifier: CustomerListTableViewCell.identifier)
        return table
    }()
    
    
    
    private let searchController : UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.clipsToBounds = true
        search.searchBar.layer.cornerRadius = 30
        return search
    }()
    
    private let button : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btnLineUp"), for: .normal)
        return button
    }()
    

    
    
//    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        congigureNavigation()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        topDefaultView.delegate = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = 100
        view.backgroundColor = .white
//        dataFetch.customerListDataFetch()
        configureStoreInfo(page)
        configure()
        

    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        showButton()
//    }
//
//    private func showButton() {
//        if searchController.isEditing {
//                self.button.alpha = 0
//            } else {
//                self.button.alpha = 1
//        }
//    }
        
//    MARK: func
    private func configure() {

    }
    
    // Navigation Bar 설정
    private func congigureNavigation() {
        //Title
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "고객 리스트"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        //Button
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.trailing.equalTo(navigationBar.snp.trailing).offset(-Const.ImageRightMargin)
            make.centerY.equalTo(navigationBar.snp.centerY).offset(-Const.ImageBottomMarginForLargeState)

        }
        
        // Search Controller
//        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요")

    }
    
    private func congifureLayout() {
        

    }
    
    private func configureStoreInfo(_ page: Int) {
        loading = true
        storeInfoService(selfVC: self, page: page)
    }

}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customerInfos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomerListTableViewCell.identifier, for: indexPath) as!
                CustomerListTableViewCell
        cell.update(self.customerInfos[indexPath.row])
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = scrollView.frame.size.height
        let contentYOffset: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                  
        if distanceFromBottom < height && !loading && !isEnded {
            page += 1
            configureStoreInfo(page)
        }
    }
}

extension MainViewController : TopDefaultViewDelegate {
    func tapButtonpressed() {
        print("클린된다")
    }
}


