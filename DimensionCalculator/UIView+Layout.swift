//
//  UIView+Layout.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/22/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

enum ConstraintSide: Hashable {
    case leading
    case trailing
    case top
    case topTo(NSLayoutYAxisAnchor)
    case bottom
    case width(CGFloat)
    case height(CGFloat)
    
    static let `default`: [ConstraintSide] = [ .leading, .trailing, .top, .bottom ]
}

extension UIView {
    @discardableResult
    func clipEdges(
        to parentView: UIView,
        insets: UIEdgeInsets = .zero,
        sides: [ConstraintSide] = ConstraintSide.default
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = sides.map {
            switch $0 {
            case .leading:
                return leadingAnchor.constraint(
                    equalTo: parentView.leadingAnchor,
                    constant: insets.left
                )
            case .trailing:
                return trailingAnchor.constraint(
                    equalTo: parentView.trailingAnchor,
                    constant: -insets.right
                )
            case .topTo(let anchor):
                return topAnchor.constraint(
                    equalTo: anchor,
                    constant: insets.top
                )
            case .top:
                return topAnchor.constraint(
                    equalTo: parentView.topAnchor,
                    constant: insets.top
                )
            case .bottom:
                return bottomAnchor.constraint(
                    equalTo: parentView.bottomAnchor,
                    constant: -insets.bottom
                )
            case .width(let constant):
                return widthAnchor.constraint(equalToConstant: constant)
            case .height(let constant):
                return heightAnchor.constraint(equalToConstant: constant)
            }
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    @discardableResult
    func clipMargins(
        to parentView: UIView,
        insets: UIEdgeInsets = .zero,
        sides: [ConstraintSide] = ConstraintSide.default
    ) -> [NSLayoutConstraint] {
        guard !sides.isEmpty else { return [] }

        translatesAutoresizingMaskIntoConstraints = false

        let constraints: [NSLayoutConstraint] = sides.map {
            switch $0 {
            case .leading:
                return leadingAnchor.constraint(
                    equalTo: parentView.layoutMarginsGuide.leadingAnchor,
                    constant: insets.left
                )
            case .trailing:
                return trailingAnchor.constraint(
                    equalTo: parentView.layoutMarginsGuide.trailingAnchor,
                    constant: -insets.right
                )
            case .top:
                return topAnchor.constraint(
                    equalTo: parentView.layoutMarginsGuide.topAnchor,
                    constant: insets.top
                )
            case .topTo(let anchor):
                return topAnchor.constraint(
                    equalTo: anchor,
                    constant: insets.top
                )
            case .bottom:
                return bottomAnchor.constraint(
                    equalTo: parentView.layoutMarginsGuide.bottomAnchor,
                    constant: -insets.bottom
                )
            case .width(let constant):
                return widthAnchor.constraint(equalToConstant: constant)
            case .height(let constant):
                return heightAnchor.constraint(equalToConstant: constant)
            }
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
