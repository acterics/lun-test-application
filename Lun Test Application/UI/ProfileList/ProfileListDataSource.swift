//
//    ProfileListDataSource.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import UIKit

class ProfileListDataSource: NSObject, UITableViewDataSource {
    private static let PROFILES_COUNT = 100
    
    var profileData: ProfileData? = nil
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if profileData != nil {
            return ProfileListDataSource.PROFILES_COUNT
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileData = self.profileData else { fatalError("Illegal state") }
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileCell, for: indexPath)!
        cell.bindView(profile: profileData.person)
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}
