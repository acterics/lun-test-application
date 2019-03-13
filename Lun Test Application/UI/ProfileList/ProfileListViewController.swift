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
    
    private var profileDataSource = ProfileListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTable.delegate = self
        profileTable.dataSource = profileDataSource
        
        loadProfileData()
    }
    
    private func loadProfileData() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                guard let asset = NSDataAsset(name: "profile_data")?.data else {
                    throw ProfileDataLoadingError(message: "No profile data resouce")
                }
                guard let jsonString = String(data: asset, encoding: .utf8) else {
                    throw ProfileDataLoadingError(message: "Cannot decode data resource")
                }
                let profileData = try ProfileData(JSONString: jsonString)
                DispatchQueue.main.async {
                    self.profileDataSource.profileData = profileData
                    self.profileTable.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showErrorMessage(error.localizedDescription)
                }
            }
        }
    }
    
    private func showErrorMessage(_ message: String) {
        print(message)
    }
}

extension ProfileListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profileData = profileDataSource.profileData else { return }
        perform(R.segue.profileListViewController.toDetails) { detailsVC in
            detailsVC.profile = profileData.person
        }
    }
    
}

