//
//  Thumbnail.swift
//  ImageGallery
//
//  Created by Samuel Germain on 2019-12-16.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit

class ThumbnailView: UIView{
    
    var imageStack = UIStackView()
    var image1 = UIImageView()
    var image2 = UIImageView()
    var image3 = UIImageView()
    
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
    
    init(_ images: (UIImage?, UIImage?, UIImage?)){
        (image1.image, image2.image, image3.image) = images
        imageStack.addArrangedSubview(image1)
        imageStack.addArrangedSubview(image2)
        imageStack.addArrangedSubview(image3)
        imageStack.distribution = .equalSpacing
        super.init(frame: CGRect(x: 0, y: 0, width: 375, height: 667))

    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: imageStack, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: imageStack, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: imageStack, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: imageStack, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

