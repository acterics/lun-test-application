//
//    ProfileListViewController.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import UIKit

class ProfileListViewController: UIViewController {
    
    @IBOutlet weak var profileTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTable.delegate = self
        
    }
}

extension ProfileListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        perform(R.segue.profileListViewController.toDetails) { detailsVC in
            //Inject profile model
        }
    }
    
}
