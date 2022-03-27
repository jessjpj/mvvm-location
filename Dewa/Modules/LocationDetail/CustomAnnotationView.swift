//
//  CustomAnnotationView.swift
//  Dewa
//
//  Created by Mac on 27/03/2022.
//

import Foundation
import MapKit

protocol CustomAnnotationViewDelegate: AnyObject {
    func didTapCallout(for annotation: MKAnnotation)
}

class CustomAnnotationView: MKPinAnnotationView {
    static let preferredReuseIdentifier = Bundle.main.bundleIdentifier! + ".customAnnotationView"

    weak var delegate: CustomAnnotationViewDelegate?

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        canShowCallout = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAnnotationView(_:)))
        self.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapAnnotationView(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        if bounds.contains(location) { return }
        delegate?.didTapCallout(for: annotation!)
    }
}
