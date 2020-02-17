//
//  BundleProductCellViewModel.swift
//  Bundle News iOS Challange
//
//  Created by MrDark on 15.02.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import PKHUD

enum BundleErrorTypes: Int, Error {
    case urlError = 400
    case dataError = 404
}

class BundleProductViewModel {
    
    public init() {}

    // MARK: API Service

    func getProducts() -> Observable<[BundleProductModel]> {
            HUD.show(.progress)
               return Observable.create { observer -> Disposable in

                   AF.request("http://5e209e06e31c6e0014c60962.mockapi.io/api/products")
                       .validate()
                       .responseJSON { response in
                           switch response.result {
                           case .success:
                               guard let data = response.data else {
                                   observer.onError(response.error ?? BundleErrorTypes.dataError)
                                   return
                               }
                               do {
                                   let bundleProductModel = try JSONDecoder().decode([BundleProductModel].self, from: data)
                                   observer.onNext(bundleProductModel)
                               } catch {
                                   observer.onError(error)
                               }
                           case .failure(let error):
                               if let statusCode = response.response?.statusCode,
                                   let reason = BundleErrorTypes(rawValue: statusCode)
                               {
                                   observer.onError(reason)
                               }
                               observer.onError(error)
                           }
                   }
                   
                   return Disposables.create()
               }
           }
}

