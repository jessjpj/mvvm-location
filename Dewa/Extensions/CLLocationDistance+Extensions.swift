//
//  CLLocationDistance+Extensions.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
    func inMiles() -> CLLocationDistance {
        return self*0.00062137
    }

    func inKilometers() -> CLLocationDistance {
        return self/1000
    }
}
