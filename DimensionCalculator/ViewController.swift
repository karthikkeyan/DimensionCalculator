//
//  ViewController.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/19/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

struct Product {
    let title: String
    let description: String
    let actionTitle: String
    let productImage: String
}

class ViewController: UIViewController {

    private var heightConstraint: NSLayoutConstraint?
    private lazy var card: CardView = {
        let card = CardView(frame: .zero)
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(card)

        let constraints = card.clipEdges(to: view, sides: [
            .leading,
            .trailing,
            .top,
            .height(190)
        ])
        heightConstraint = constraints.last

        let ipad = Product(
            title: "iPad Pro 12.9\"",
            description: "It’s a magical piece of glass. It’s so fast most PC laptops can’t catch up. It has pro cameras that can transform reality. And you can use it with touch, pencil, keyboard, and now trackpad. It’s the new iPad Pro.",
            actionTitle: "Read More",
            productImage: "ipad-12-9"
        )
        update(using: ipad)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let size = CardView.dimensions(bounds: self.view.bounds, model: ipad)
            self.heightConstraint?.constant = size.height
            self.view.layoutIfNeeded()
        }
    }

    private func update(using product: Product) {
        card.titleLabel.text = product.title
        card.descriptionLabel.text = product.description
        card.actionButton.setTitle(product.actionTitle, for: .normal)
        card.imageView.image = UIImage(named: product.productImage)
    }
}
