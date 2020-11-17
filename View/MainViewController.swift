//
//  MainViewController.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

class MainViewController: UIViewController {

//    MARK: Properties
    let topDefaultView = TopDefaultView()
    
    let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.barStyle = .default
        search.sizeToFit()
        return search
    }()
    
    
//    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        configure()
    }
    
//    MARK: func
    private func configure() {
        view.addSubview(topDefaultView)
        congifureLayout()
    }
    
    private func congifureLayout() {
        
        topDefaultView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalTo(view).inset(16)
        }
    }


}

