//
//  TopDefaultView.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit
import SnapKit

class TopDefaultView: UIView {
    
//    MARK: Properties

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "고객 리스트"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26)
        label.textColor = .black
        return label
    }()
    
    private let allimentButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnLineUp"), for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()
    
    private let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.barStyle = .black
        search.placeholder = "검색어를 입력해주세요"
        return search
    }()

//    MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        configureSetUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: Func
    private func configureSetUI() {
        backgroundColor = .systemBlue
        let stack = UIStackView(arrangedSubviews: [titleLabel,allimentButton])
        stack.axis = .horizontal
        stack.spacing = 100
        
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
        }
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(stack.snp.bottom).offset(10)
            
        }
    }
    
}
