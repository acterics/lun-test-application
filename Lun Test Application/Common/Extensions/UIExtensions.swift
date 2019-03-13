//
//    UIExtensions.swift 
//    Lun Test Application
//
//    Created by Oleg Lipskiy on 3/13/19
//    Copyright © 2019 Oleg Lipskiy. All rights reserved.

    

import Foundation
import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImage(from urlString: String,
                  contentMode: UIView.ContentMode = .scaleAspectFill,
                  placeholder: UIImage? = nil,
                  onError: @escaping (Error) -> Void = { _ in }) {
        guard let url = URL(string: urlString) else {
            onError(UrlDecodeError())
            return
        }
        if let imageFromCache = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = imageFromCache
            self.contentMode = contentMode
        } else {
            self.image = placeholder
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData: NSData = NSData(contentsOf: url) {
                    DispatchQueue.main.async {
                        guard let downloadedImage = UIImage(data: imageData as Data) else {
                            onError(ImageLoadingError())
                            return
                        }
                        imageCache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
                        self.image = downloadedImage
                        self.contentMode = contentMode
                    }
                } else {
                    DispatchQueue.main.async {
                        onError(ImageLoadingError())
                    }
                }
            }
        }
    }
    
}
