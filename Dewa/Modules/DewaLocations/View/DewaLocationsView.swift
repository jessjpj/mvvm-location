//
//  DewaLocationsView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import UIKit

final class DewaLocationsView: UIView {

    @IBOutlet weak var collectionView: DewaLocationsCollectionView!

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

extension DewaLocationsView {
    func setupUI() {

    }
}
