//
//  Models.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/23/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import Foundation

struct Product {
    let title: String
    let description: String
    let actionTitle: String
    let productImage: String

    static var ipad: Product {
        return Product(
            title: "iPad Pro 12.9\"",
            description: "It’s a magical piece of glass. It’s so fast most PC laptops can’t catch up. It has pro cameras that can transform reality. And you can use it with touch, pencil, keyboard, and now trackpad. It’s the new iPad Pro.",
            actionTitle: "Read More",
            productImage: "ipad-12-9"
        )
    }
}
