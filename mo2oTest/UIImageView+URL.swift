//
//  UIImageView+URL.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func loadImage(with imageURL: URL, placeholderImage: UIImage?) {
        af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
    }
}
