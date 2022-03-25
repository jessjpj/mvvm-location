//
//  CustomerServiceLocationView.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation
import UIKit

final class CustomerServiceLocationView: UIView {

    @IBOutlet weak var collectionView: CollectionServiceLocationCollectionView!

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

extension CustomerServiceLocationView {
    func setupUI() {
    }
}
