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
            self.contactLabel.text = (self.customerInfo != nil) ?  updatePhoneNumber(self.customerInfo!.contact) : ""
            //            self.redateLabel.text = self.customerInfo?.regdate
            self.redateLabel.text = updateRedate(customerInfo?.regdate ?? "")
            self.memoLabel.text = self.customerInfo?.memo
        }
    }
    
    // 프로필 이미지
    private let profileUrl : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noimg")
        image.frame.size = CGSize(width: 60, height: 60)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/1.8
        image.clipsToBounds = true
        return image
    }()
    
    //고객명라벨
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 19)
        return label
    }()
    
    //연락처라벨
    private let contactLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()
    
    //redate 라벨
    private let redateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.textColor = ColorModel.customSubGray
        return label
    }()
    // 메모라벨
    private let memoLabel : UILabel = {
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
    
    func style() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.2
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 10
        self.contentView.layer.borderColor = ColorModel.customBackgroundColor.cgColor
        self.contentView.layer.masksToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    //    MARK: configure
    
    private func configureSetUI() {
        
        [profileUrl,nameLabel,contactLabel,redateLabel,memoLabel].forEach({
            contentView.addSubview($0)
        })
        
        profileUrl.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(contentView).inset(55)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.18)
            make.height.equalTo(profileUrl.snp.width)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(26)
            make.leading.equalTo(profileUrl.snp.trailing).offset(15)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        redateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactLabel)
            make.trailing.equalTo(contentView).inset(15)
        }
        
        memoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileUrl)
            make.trailing.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(15)
        }
    }
    
    // Kingfisher Image Set Func
    private func setImage(frome url: String) {
        guard let imageURL = URL(string: url) else { return }
        self.profileUrl.kf.setImage(with: imageURL)
    }
    
    //phoneNumber Fomatter Func
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
    // Redate Date Formatter Func
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
