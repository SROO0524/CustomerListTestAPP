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
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noimg")
        return image
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "김시루"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 19)
        return label
    }()
    
    private let phoneLabel : UILabel = {
        let label = UILabel()
        label.text = "010-123-1234"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()

    private let redateLabel : UILabel = {
        let label = UILabel()
        label.text = "5월 20일"
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()
    
    private let memoView : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.text = "메모를 보여주는 공간입니다. 메모를 보여주는 공간입니다."
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        label.backgroundColor = ColorModel.customMemoBackgroungGray
        label.textColor = ColorModel.customMemoGray
        return label
    }()
    
//    MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSetUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: configure
    
    private func configureSetUI() {
        
        [profileImage,nameLabel,phoneLabel,redateLabel,memoView].forEach({
            contentView.addSubview($0)
        })
        
        profileImage.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(contentView).inset(55)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(26)
            make.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        redateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLabel)
            make.trailing.equalTo(contentView).inset(15)
        }
        
        memoView.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImage)
            make.trailing.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(15)
        }
        
        
        
        
        
        
        
    }
    

    


}
