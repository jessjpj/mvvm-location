//
//  DevaLocationCVC.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import UIKit

class DevaLocationCVC: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configurecell(locationItem: DewaLocationItem?) {
        guard let locationItem = locationItem else {
            return
        }
        titleLabel.text = locationItem.office ?? ""
        addressLabel.text = locationItem.loc ?? ""
        guard let distance = locationItem.distance else {
            return
        }
        distanceLabel.text = "\(distance) km away"
    }

}
