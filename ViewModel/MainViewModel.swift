//
//  CustomerListTableViewModel.swift
//  CustomerListTestAPP
//
//  Created by 김믿음 on 2020/11/16.
//

import UIKit

// 해당 프로토콜을 가지면 꼭 Fetch 를 구현해야함!
public protocol ViewModel: RequestDelegate {
    func fetch() -> Void
}

public protocol ViewModelDelegate {
    func reload() -> Void
}

class MainViewModel: ViewModel, RequestDelegate {
    private var originalCustomerInfos: [CustomerInfo] = []
    private var customerInfos: [CustomerInfo] = []
    let requestService = RequestService()
    var page = 0
    var loading = false
    var isEnded = false
    var isOrdering = false
    var isFiltering = false
    var viewModeldelegate: ViewModelDelegate?
    
    let url = "http://crm-staging.gongbiz.kr/app/v2020/cust"

//    MARK:  Init
    init() {
        requestService.requestDelegate = self
        self.fetch()
    }
//    MARK: Func
    public func find(index: Int) -> CustomerInfo {
        return self.customerInfos[index]
    }
    
    public func getCount() -> Int {
        return self.customerInfos.count
    }
    
// Customer Info Fetch
    func fetch() {
        if canFetch() {
            self.page += 1
            self.loading = true
            
            requestService.getRequest(url, viewModel: self, param: ["size": 20, "page": self.page])
        }
    }
    
    func doFilter(_ searchText: String) {
        self.customerInfos = self.originalCustomerInfos.filter({ (customerinfo : CustomerInfo) -> Bool in
            if (searchText.isEmpty) {
                return true
            }
            return customerinfo.name.lowercased().contains(searchText.lowercased())
                || customerinfo.contact.lowercased().contains(searchText.lowercased())
        })
        self.viewModeldelegate?.reload()
    }
    
    // 이름순 정렬
    public func sortedByName() {
        self.isOrdering = true
        self.customerInfos.sort { $0.name < $1.name }
        self.viewModeldelegate?.reload()
    }
    
    // Redate 순 정렬
    public func sorterByRedate() {
        self.isOrdering = true
        self.customerInfos.sort { $0.regdate < $1.regdate }
        self.viewModeldelegate?.reload()
    }
    
    // 기존 정렬순
    public func sorterByOriginal() {
        self.customerInfos = self.originalCustomerInfos
        self.viewModeldelegate?.reload()
        self.isOrdering = false
    }
    
    //데이터 성공
    func success(response: Response) {
        let customerInfosRes = response as! CutomerListResponse
        if (customerInfosRes.list.count == 0) {
            self.isEnded = true
        } else {
            self.customerInfos = self.customerInfos + customerInfosRes.list
            self.originalCustomerInfos = self.customerInfos
        }
        self.loading = false
        viewModeldelegate?.reload()
    }
    
    // 데이터 실패
    func fail() {
        self.page -= 1
        self.loading = false
        print("네트워크 연결에 실패했습니다")
    }
    
    private func canFetch() -> Bool {
        return !loading && !isEnded && !isOrdering && !isFiltering
    }
    
    
}
