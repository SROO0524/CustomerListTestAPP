//
//  DataFetch.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit
import Alamofire

extension MainViewController {
    func storeInfoService(selfVC: MainViewController, page: Int) {
        AF.request(url,
                   method: .get,
                   parameters: ["size": 20, "page": page],
                   encoding: URLEncoding.default
        ).response { (response) in
            
            if let error = response.error {
                print("----- AF RESPONSE ERROR [GET] (STORE INFO)----- \(error.localizedDescription)")
            }
            
            guard let code = response.response?.statusCode else { return }
            
            if code >= 200, code <= 299 {
                switch response.result {
                    
                case .success(let data):
                    guard let data = data else {return}
                    do {
                        let json = try JSONDecoder().decode(CutomerListResponse.self, from: data)
                        if (json.list.count == 0) {
                            self.isEnded = true
                        } else {
                            self.customerInfos = self.customerInfos + json.list
                        }
                        print("----- AF RESULT SUCCESS [GET] (STORE INFO)----- ")
                        
                    } catch let error {
                        print("----- JSONDecoder ERROR (STORE INFO)-----  \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("----- AF RESULT FAIL [GET] (STORE INFO)----- \(error.localizedDescription)")
                }
                
            } else if code >= 400, code <= 499 {
                print("----- AF STATUS CODE IS 400 ~ 499 [GET] (STORE INFO)----- ")
            } else {
                print("----- AF STATUS CODE IS 500 ~ [GET] (STORE INFO)----- ")
            }
        }
    }
    }
