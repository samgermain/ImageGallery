//
//  Thumbnail.swift
//  ImageGallery
//
//  Created by Samuel Germain on 2019-12-16.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit

class ThumbnailView: UIView{
  
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var snapshot: UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }

    class func instanceFromNib() -> ThumbnailView {
        return UINib(nibName: "ThumbnailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ThumbnailView
    }
    
    class func newThumbnail(images: (UIImage?, UIImage?, UIImage?)) -> ThumbnailView {
        let thumbnail = instanceFromNib()
        (thumbnail.image1.image, thumbnail.image2.image, thumbnail.image3.image) = images
        return thumbnail
    }
    
}

