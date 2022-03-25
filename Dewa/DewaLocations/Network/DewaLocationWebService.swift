//
//  DewaLocationWebService.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

class DewaLocationWebService {

    func getDewaLocations(url: URL, completion :@escaping (Data?, Error?) -> ()) {
        let request = URLRequest(url: url)
        let service = NetWorkService()
        service.getData(request: request) { data, error in
            completion(data, error)
        }
    }
}
