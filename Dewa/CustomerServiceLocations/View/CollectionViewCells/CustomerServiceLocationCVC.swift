//
//  CustomerServiceLocationCVC.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import UIKit
import SDWebImage
import CoreLocation

class CustomerServiceLocationCVC: UICollectionViewCell {

    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configurecell(locationItem: ServiceCenterModel?) {
        guard let locationItem = locationItem else {
            return
        }
        let locationURL = URL(string: locationItem.image)
        locationImageView.sd_setImage(
            with: locationURL,
            placeholderImage: UIImage(named: "placeholder"))
        titleLabel.text = locationItem.title
        addressLabel.text = locationItem.longAddress
        guard let distance = locationItem.distance else {
            return
        }
        distanceLabel.text = "\(distance) km away"
    }

}
