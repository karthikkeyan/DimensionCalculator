//
//  ViewController.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/19/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

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

        let model = Product.ipad
        update(using: model)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let size = CardView.dimensions(bounds: self.view.bounds, model: model)
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
