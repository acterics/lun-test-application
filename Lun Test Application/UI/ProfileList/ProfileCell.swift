//
//    ProfileCell.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func bindView(profile: Profile) {
        nameLabel.text = profile.name
        addressLabel.text = profile.address
        phoneLabel.text = profile.phone
        if let image = profile.image {
            profileImage.setImage(from: image.link,
                                  placeholder: R.image.ic_placeholder(),
                                  onError: { _ in self.profileImage.image = R.image.ic_error()})
        }
        
    }
    
}
