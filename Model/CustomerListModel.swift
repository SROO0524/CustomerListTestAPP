//
//  CustomerListModel.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import Foundation

struct CustomerList : Codable {
    
    let list : [List]
    
    struct List : Codable {
        let custno: Int
        let name : String
        let contact : String
        let birth : String
        let memo: String
        let dontsend: Int
        let point : Int
        let profile : Int
        let chargeName : String
        let regdate : String
        let profileUrl : String
        
        enum CodingKeys: String, CodingKey {
            case custno, name, contact, birth, memo, dontsend, point, profile, chargeName, regdate, profileUrl

        }
    }
}
