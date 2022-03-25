//
//  CustomerServiceWebService.swift
//  Dewa
//
//  Created by Mac on 24/03/2022.
//

import Foundation

class CustomerServiceWebService {

    func getCustomerServiceLocations(url: URL, completion :@escaping (Data?, Error?) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let service = NetWorkService()
        service.getData(request: request) { data, error in
            completion(data, error)
        }
    }
}
