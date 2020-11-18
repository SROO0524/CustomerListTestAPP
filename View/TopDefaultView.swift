//
//  TopDefaultView.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit
import SnapKit

protocol TopDefaultViewDelegate : class {
    func tapButtonpressed()
}

class TopDefaultView: UIView {
    
//    MARK: Properties

    weak var delegate : TopDefaultViewDelegate?
    
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
        button.addTarget(self, action: #selector(alignmentButtonTap), for: .touchUpInside)
        button.isSelected = true
        return button
    }()
    
//    MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Func
    private func configureSetUI() {
        let stack = UIStackView(arrangedSubviews: [titleLabel,allimentButton])
        addSubview(stack)
        stack.axis = .horizontal
        stack.spacing = 210
//        stack.backgroundColor = .systemRed
  
        stack.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY).offset(10)
//            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            
        }
    }
    
    @objc func alignmentButtonTap() {
        delegate?.tapButtonpressed()
        print("클릭")
    }
}
    

