//
//  CustomerListTableViewCell.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

class CustomerListTableViewCell: UITableViewCell {
    static let identifier = "CustomerListTableViewCell"
    
//    MARK: Properties
    
    private let button : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "btnLineUp"), for: .normal)
        return button
    }()
    

//    MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(button)
        configureSetUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: configure
    
    private func configureSetUI() {
        button.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(5)        }
    }

    


}
