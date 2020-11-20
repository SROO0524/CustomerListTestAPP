//
//  CustomerListTableViewCell.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit
import Kingfisher

class CustomerListTableViewCell: UITableViewCell {
    static let identifier = "CustomerListTableViewCell"
    
    //    MARK: Properties
    
    //Cell Data Set
    var customerInfo : CustomerInfo? {
        didSet{
            
            self.setImage(frome: self.customerInfo?.profileUrl ?? "")
            self.nameLabel.text = self.customerInfo?.name
            self.phoneLabel.text = (self.customerInfo != nil) ?  updatePhoneNumber(self.customerInfo!.contact) : ""
            //            self.redateLabel.text = self.customerInfo?.regdate
            self.redateLabel.text = updateRedate(customerInfo?.regdate ?? "")
            self.memoView.text = self.customerInfo?.memo
        }
    }
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noimg")
        image.frame.size = CGSize(width: 60, height: 60)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/1.8
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 19)
        return label
    }()
    
    private let phoneLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()
    
    private let redateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()
    
    private let memoView : UILabel = {
        let label = UILabel()
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
    
    // Cell Data Set Func
    func update(_ customerInfo: CustomerInfo) {
        self.customerInfo = customerInfo
    }
    
    //    MARK: configure
    
    private func configureSetUI() {
        
        [profileImage,nameLabel,phoneLabel,redateLabel,memoView].forEach({
            contentView.addSubview($0)
        })
        
        profileImage.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(contentView).inset(55)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.18)
            make.height.equalTo(profileImage.snp.width)
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
    
    // Kingfisher Image Set Func
    private func setImage(frome url: String) {
        guard let imageURL = URL(string: url) else { return }
        self.profileImage.kf.setImage(with: imageURL)
    }
    
    //phoneNumber Fomatter
    private func updatePhoneNumber(_ number: String) -> String {
        var head: String.Index = number.startIndex
        var middle: String.Index = number.startIndex
        if (number.count == 11) {
            head = number.index(number.startIndex, offsetBy: 3)
            middle = number.index(head, offsetBy: 4)
        }
        else if (number.count == 10) {
            head = number.index(number.startIndex, offsetBy: 3)
            middle = number.index(head, offsetBy: 3)
        } else if (number.count == 10) {
            head = number.index(number.startIndex, offsetBy: 2)
            middle = number.index(head, offsetBy: 3)
        } else {
            return number
        }
        
        return "\(number[number.startIndex..<head])-\(number[head..<middle])-\(number[middle..<number.endIndex])"
        
    }
    
    private func updateRedate(_ stringDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyyMMddHHmmss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "M월d일"
        
        if let date = dateFormatterGet.date(from: stringDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
    
    
}
