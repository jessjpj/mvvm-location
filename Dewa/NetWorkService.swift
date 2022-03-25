//
//  NetWorkService.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

class NetWorkService {
    func getData(request: URLRequest, completion: @escaping (Data?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}
