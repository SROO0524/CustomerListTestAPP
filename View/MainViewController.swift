//
//  MainViewController.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

class MainViewController: UIViewController {

//    MARK: Properties
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

}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomerListTableViewCell.identifier, for: indexPath) as!
                CustomerListTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        return cell
        
    }
    
    
}

extension MainViewController : TopDefaultViewDelegate {
    func tapButtonpressed() {
        print("클린된다")
    }
    
    
}

