//
//  Recipe.swift
//  mo2oTest
//
//  Created by Graciela Lucena on 9/26/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Unbox

struct Recipe {
    
    var title: String
    var href: String
    var ingredients : String
    var thumbnail : String

}

extension Recipe: Unboxable {
    
    struct Key {
        static let title = "title"
        static let href = "href"
        static let ingredients = "ingredients"
        static let thumbnail = "thumbnail"
    }
    
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: Key.title)
        self.href = try unboxer.unbox(key: Key.href)
        self.ingredients = try unboxer.unbox(key: Key.ingredients)
        self.thumbnail = try unboxer.unbox(key: Key.thumbnail)
    }
}
