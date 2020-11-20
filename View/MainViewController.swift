//
//  MainViewController.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

class MainViewController: UIViewController, ViewModelDelegate {
    
//    MARK: Properties
    let viewModel = MainViewModel()
    
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
        self.viewModel.viewModeldelegate = self
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        view.backgroundColor = ColorModel.customBackgroundColor
        viewModel.fetch()
    }
    
//    MARK: Func
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
        searchController.obscuresBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요")
    }
    
    // TableView Reload
    func reload() {
        tableView.reloadData()
    }
}

//    MARK: Extension

//TableViewDelegate extension
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomerListTableViewCell.identifier, for: indexPath) as!
                CustomerListTableViewCell
        cell.update(viewModel.find(index: indexPath.row))
        
        cell.style()
        return cell
    }

    //Scrolling paging
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height: CGFloat = scrollView.frame.size.height
        let contentYOffset: CGFloat = scrollView.contentOffset.y
        let scrollViewHeight: CGFloat = scrollView.contentSize.height
        let distanceFromBottom: CGFloat = scrollViewHeight - contentYOffset
                  
        if distanceFromBottom < height && !isFiltering() {
            viewModel.fetch()
        }
    }
}

// SearchController extension
extension MainViewController : UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.viewModel.doFilter(searchBar.text!)
      }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // 필터링 결과 사용할지 아닐지 결정하기 위한 메소드
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
        
    }
    
    // 검색창 검색결과 업데이트
    internal func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.doFilter(searchController.searchBar.text!)
    }
}


// AlerController extension
extension MainViewController  {
    @objc func sortButtonTaped(_ sender: UIButton) {
        alertSheet(style: .actionSheet)
    }
    
    private func alertSheet(style : UIAlertController.Style) {
        //alertTitle
        let alertTitle = UIAlertController(title: nil,
                                           message: "정렬방식을 선택해주세요.",
                                           preferredStyle: .actionSheet)
        //alertoptions
        let nameSorted = UIAlertAction(title: "이름순",
                                       style: .default) { (UIAlertAction) in
            self.viewModel.sortedByName()
        }
        
        let dateSorted = UIAlertAction(title: "날짜순",
                                       style: .default) { (UIAlertAction) in
            self.viewModel.sorterByRedate()
        }
        
        //cancle
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (UIAlertAction) in
            self.viewModel.sorterByOriginal()
        }
        
        //alertsheet 에 action 추가
        alertTitle.addAction(nameSorted)
        alertTitle.addAction(dateSorted)
        alertTitle.addAction(cancelAction)
        
        // alertsheet show
        self.present(alertTitle, animated: true, completion: nil)
    }
}
