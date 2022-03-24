//
//  CustomerServiceViewModel.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import Foundation

class CustomerServiceViewModel {
    private(set) var webservice :CustomerServiceWebService!

    var title: String? = "Customer Service Locations"
    var models: [ServiceCenterModel] = [ServiceCenterModel]()

    init(models: [ServiceCenterModel]) {
        self.models = models
    }

    init(service: CustomerServiceWebService) {
        self.webservice = service
    }
}
