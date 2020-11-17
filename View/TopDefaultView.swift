//
//  TopDefaultView.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

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
        return search
    }()

//    MARK: LifeCycle
    override func layoutSubviews() {
        
    }

    
//    MARK: Func
    private func configureSetUI() {
        let stack = UIStackView(arrangedSubviews: [titleLabel,allimentButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        addSubview(stack)
        
        
        addSubview(searchBar)
        
    }
    
}
