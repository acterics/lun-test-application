//
//    Errors.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation

struct ProfileDataLoadingError: Error {
    let message: String
    
    var localizedDescription: String {
        get { return message }
    }
}

struct UrlDecodeError: Error {}
struct ImageLoadingError: Error {}
