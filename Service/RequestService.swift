//
//  DataFetch.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit
import Alamofire

//    MARK: Request Protocol
public protocol RequestDelegate {
    func success(response: Response) -> Void
    func fail() -> Void
}

class RequestService {
//    MARK: Properties
    var requestDelegate: RequestDelegate?

//    MARK:  Fetch Func
    public func getRequest(_ url: String, viewModel: ViewModel, param: [String: Any]) {
        AF.request(url,
                   method: .get,
                   parameters: param,
                   encoding: URLEncoding.default
        ).response { (response) in
            
            if let error = response.error {
                print("----- AF RESPONSE ERROR [GET] (CUSTOMER INFO)----- \(error.localizedDescription)")
            }
            
            guard let code = response.response?.statusCode else { self.requestDelegate?.fail()
                return
            }
            // 오류 체크
            if code >= 200, code <= 299 {
                switch response.result {
                    case .success(let data):
                        guard let data = data else {return}
                        do {
                            let json = try JSONDecoder().decode(CutomerListResponse.self, from: data)
                            self.requestDelegate?.success(response: json)
                            
                        } catch let error {
                            print("----- JSONDecoder ERROR (CUSTOMER INFO)-----  \(error.localizedDescription)")
                        }
                        
                    case .failure(let error):
                        print("----- AF RESULT FAIL [GET] (CUSTOMER INFO)----- \(error.localizedDescription)")
                    }
            } else if code >= 400, code <= 499 {
                self.requestDelegate?.fail()
            } else {
                self.requestDelegate?.fail()
            }
        }
    }
}
