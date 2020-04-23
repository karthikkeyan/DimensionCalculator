//
//  Units.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/22/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    init(unit: CGFloat) {
        self.init(top: unit, leading: unit, bottom: unit, trailing: unit)
    }
}

extension UIEdgeInsets {
    init(unit: CGFloat) {
        self.init(top: unit, left: unit, bottom: unit, right: unit)
    }

    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self = .zero

        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

extension CGFloat {
    static let singleUnit: CGFloat = 8
    static let doubleUnit: CGFloat = .singleUnit * 2
    static let tripleUnit: CGFloat = .singleUnit * 3
    static let quadrupleUnit: CGFloat = .singleUnit * 4
}
