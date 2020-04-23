//
//  DimensionCalculator.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/19/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

public struct DimensionCalculator {
    public enum SizeConstraint {
        case maximumWidth(CGFloat)
        case maximumHeight(CGFloat)
        case fixedWidth(CGFloat)
        case fixedHeight(CGFloat)
    }

    let constraint: SizeConstraint

    public var dimensions: CGSize

    public init(constraint: SizeConstraint) {
        self.constraint = constraint
        self.dimensions = constraint.initialSize
    }

    public mutating func add(height: CGFloat) {
        switch constraint {
        case .maximumWidth, .fixedWidth:
            dimensions.height += height
        case .maximumHeight(let size):
            dimensions.height = min(dimensions.height + height, size)
        case .fixedHeight(let size):
            dimensions.height = size
        }
    }

    public mutating func add(width: CGFloat) {
        switch constraint {
        case .maximumHeight, .fixedHeight:
            dimensions.width += width
        case .maximumWidth(let size):
            dimensions.width = min(dimensions.width + width, size)
        case .fixedWidth(let size):
            dimensions.width = size
        }
    }

    public mutating func add(size: CGSize) {
        add(height: size.height)
        add(width: size.width)
    }

    public mutating func add(rect: CGRect) {
        add(height: rect.height)
        add(width: rect.width)
    }

    public mutating func add(height: NSLayoutConstraint) {
        add(height: height.constant)
    }

    public mutating func add(width: NSLayoutConstraint) {
        add(width: width.constant)
    }

    public mutating func add(stack: UIStackView) {
        let totalSpace = stack.spacing * CGFloat(stack.arrangedSubviews.count - 1)
        
        let size = stack.arrangedSubviews.reduce(CGSize.zero) {
            return CGSize(width: $0.width + $1.frame.width, height: $0.height + $1.frame.height)
        }

        add(size: size)

        switch stack.axis {
        case .horizontal:
            add(width: totalSpace)
        case .vertical:
            add(height: totalSpace)
        @unknown default:
            break
        }
    }

    public mutating func add(heights: [CGFloat], spacing: CGFloat = 0) {
        add(height: heights.reduce(0, +))
        add(height: spacing * CGFloat(heights.count - 1))
    }

    public mutating func add(widths: [CGFloat], spacing: CGFloat = 0) {
        add(width: widths.reduce(0, +))
        add(width: spacing * CGFloat(widths.count - 1))
    }

    public mutating func add(text: String, font: UIFont) {
        let boundingBox = text.boundingRect(
            with: constraint.constraintSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )

        if constraint.isGrowsVertically {
            add(height: ceil(boundingBox.height))
        } else {
            add(width: ceil(boundingBox.width))
        }
    }

    public mutating func add(text: NSAttributedString) {
        let boundingBox = text.boundingRect(
            with: constraint.constraintSize,
            options: .usesLineFragmentOrigin,
            context: nil
        )

        if constraint.isGrowsVertically {
            add(height: ceil(boundingBox.height))
        } else {
            add(width: ceil(boundingBox.width))
        }
    }
    
    public mutating func add(texts: [String: UIFont], spacing: CGFloat) {
        texts.forEach { (text: String, font: UIFont) in
            add(text: text, font: font)
        }

        add(height: spacing * CGFloat(texts.count - 1))
    }

    public mutating func add(texts: [NSAttributedString], spacing: CGFloat) {
        texts.forEach { add(text: $0) }

        add(height: spacing * CGFloat(texts.count - 1))
    }

    public mutating func add(insets: UIEdgeInsets) {
        add(height: insets.bottom + insets.top)
        add(width: insets.left + insets.right)
    }

    public mutating func add(directionalInsets: NSDirectionalEdgeInsets) {
        add(height: directionalInsets.bottom + directionalInsets.top)
        add(width: directionalInsets.leading + directionalInsets.trailing)
    }
}

// MARK: - SizeConstraint

extension DimensionCalculator.SizeConstraint {
    var initialSize: CGSize {
        var size: CGSize = .zero
        switch self {
        case .maximumWidth(let width), .fixedWidth(let width):
            size.width = width
        case .maximumHeight(let height),.fixedHeight(let height):
            size.height = height
        }

        return size
    }

    var constraintSize: CGSize {
        let max = CGFloat.greatestFiniteMagnitude
        var size = CGSize(width: max, height: max)
        switch self {
        case .maximumWidth(let width), .fixedWidth(let width):
            size.width = width
        case .maximumHeight(let height),.fixedHeight(let height):
            size.height = height
        }

        return size
    }

    var isGrowsVertically: Bool {
        switch self {
        case .maximumWidth, .fixedWidth:
            return true
        case .maximumHeight, .fixedHeight:
            return false
        }
    }
}
