//
//  AppConfiguration.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

final class AppConfiguration {
    lazy var customerServiceLocationURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "customerServiceLocationURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()

    lazy var dewaLocationURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "dewaLocationURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()

}
