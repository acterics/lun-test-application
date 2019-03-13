//
//    Profile.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation

struct Profile {
    let id: Int
    let name: String
    let address: String
    let phone: String
    let imageId: Int
    let lat: Double
    let lng: Double
    
    var image: Image?
}
