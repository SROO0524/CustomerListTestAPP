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
    var isFilteringOrOrdering = false
    var customerInfos: [CustomerInfo] = [] {
        didSet{
            self.customerInfosForTable = self.customerInfos
            self.tableView.reloadData()
            self.loading = false
        }
    }
    
    var customerInfosForTable: [CustomerInfo] = []
    
    var page = 1
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
    
    private let sortedButtonImage = UIImage(named: "btnLineUp")?.withRenderingMode(.alwaysOriginal)

//    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        congigureNavigation()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .white
        configureStoreInfo(page)
        configure()
        

    }
//    MARK: func
    private func configure() {

    }
        
    // Navigation Bar 설정
    private func congigureNavigation() {
        //Navigation Title
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "고객 리스트"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        //Navigation Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: sortedButtonImage, style: .plain, target: self, action: #selector(sortButtonTaped(_:)))

                                               
        // Search Controller in Navigation Controller
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요")
    }
    
    
    private func configureStoreInfo(_ page: Int) {
        loading = true
        customerInfoService(selfVC: self, page: page)
    }

}

//    MARK: Extension

//TableViewDelegate extension
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerInfosForTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomerListTableViewCell.identifier, for: indexPath) as!
                CustomerListTableViewCell
        cell.update(self.customerInfosForTable[indexPath.row])
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    //ScrollEvent Catch
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = scrollView.frame.size.height
        let contentYOffset: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                  
        if distanceFromBottom < height && !loading && !isEnded && !isFiltering() {
            page += 1
            configureStoreInfo(page)
        }
    }
}

// SearchController extension
extension MainViewController : UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
      }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // 필터링된 컨텐츠를 보여 줄때.
    private func filterContentForSearchText(_ searchText: String) {
        customerInfosForTable = customerInfos.filter({ (customerinfo : CustomerInfo) -> Bool in
            if (searchText.isEmpty) {
                return true
            }
            return customerinfo.name.lowercased().contains(searchText.lowercased())
            || customerinfo.contact.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // 필터링 결과 사용할지 아닐지 결정하기 위한 메소드
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
        
    }
    
    // 검색창 검색결과 업데이트
    internal func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        print("\(searchController.searchBar.text!)")
    }
    

}


// AlerController extension
extension MainViewController  {
    @objc func sortButtonTaped(_ sender: UIButton) {
        alertSheet(style: .actionSheet)
        print("버튼이 눌리나😄😄😄😄")
    }
    
    private func alertSheet(style : UIAlertController.Style) {
        //alertTitle
        let alertTitle = UIAlertController(title: nil,
                                           message: "정렬방식을 선택해주세요.",
                                           preferredStyle: .actionSheet)
        //alertoptions
        let nameSorted = UIAlertAction(title: "이름순",
                                       style: .default) { (UIAlertAction) in
            self.sortedByName()
        }
        
        let dateSorted = UIAlertAction(title: "날짜순",
                                       style: .default) { (UIAlertAction) in
            self.sorterByRedate()
        }
        
        //cancle
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        //alertsheet 에 action 추가
        alertTitle.addAction(nameSorted)
        alertTitle.addAction(dateSorted)
        alertTitle.addAction(cancelAction)
        
        // alertsheet show
        self.present(alertTitle, animated: true, completion: nil)
    }
    
    // 이름순 정렬
    private func sortedByName() {
        print("이름순!!😁")
    }
    
    // Redate 순 정렬
    private func sorterByRedate() {
        
    }
}


