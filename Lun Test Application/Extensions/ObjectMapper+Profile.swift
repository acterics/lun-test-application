//
//    ObjectMapper+Profile.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import ObjectMapper

extension ProfileData: ImmutableMappable {
    init(map: Map) throws {
        self.images = try map.value("images")
        
        var person: Profile = try map.value("person")
        person.image = images.first { $0.id == person.imageId }
        self.person = person
        
    }
    
    
}

extension Profile: ImmutableMappable {
    init(map: Map) throws {
        self.id = try map.value("person_id")
        self.name = try map.value("name")
        self.address = try map.value("address")
        self.phone = try map.value("phone")
        self.imageId = try map.value("profile_image_id")
        self.lat = try map.value("lat")
        self.lng = try map.value("lng")
        self.image = nil
    }
    
    
}

extension Image: ImmutableMappable {
    init(map: Map) throws {
        self.id = try map.value("image_id")
        self.link = try map.value("link")
    }
    
    
}
