//
//  LocationDetailView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import UIKit

class LocationDetailView: UIView {

    var viewModel: LocationDetailViewModel? {
        didSet {
            configure()
        }
    }
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    func configure() {
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LocationDetailView {
    func setupUI() {
        
    }
}
