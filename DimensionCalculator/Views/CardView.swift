//
//  CardView.swift
//  DimensionCalculator
//
//  Created by Karthikkeyan Bala Sundaram on 4/19/20.
//  Copyright © 2020 Karthikkeyan Bala Sundaram. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    static let imageHeight: CGFloat = 160
    static let actionButtonHeight: CGFloat = 36
    
    lazy var shadowView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = .singleUnit
        view.layer.shadowRadius = .singleUnit
        view.layer.shadowOpacity = 0.25
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(unit: .doubleUnit)
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = .singleUnit
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.blue, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(unit: .doubleUnit)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(shadowView)
        shadowView.clipMargins(to: self)

        shadowView.addSubview(imageView)
        imageView.clipEdges(to: shadowView, sides: [
            .leading,
            .trailing,
            .top,
            .height(CardView.imageHeight)
        ])

        shadowView.addSubview(titleLabel)
        titleLabel.clipMargins(to: shadowView, insets: UIEdgeInsets(top: .doubleUnit), sides: [
            .leading,
            .trailing,
            .topTo(imageView.bottomAnchor)
        ])

        shadowView.addSubview(descriptionLabel)
        descriptionLabel.clipMargins(to: shadowView, insets: UIEdgeInsets(top: .doubleUnit), sides: [
            .leading,
            .trailing,
            .topTo(titleLabel.bottomAnchor)
        ])

        shadowView.addSubview(actionButton)
        actionButton.clipMargins(to: shadowView, insets: UIEdgeInsets(top: .doubleUnit), sides: [
            .leading,
            .width(120),
            .topTo(descriptionLabel.bottomAnchor),
            .height(CardView.actionButtonHeight)
        ])
    }
    
    static func dimensions(bounds: CGRect, model: Product) -> CGSize {
        var calculator = DimensionCalculator(constraint: .fixedWidth(bounds.width - .quadrupleUnit))
        calculator.add(directionalInsets: NSDirectionalEdgeInsets(unit: .quadrupleUnit))
        calculator.add(height: imageHeight)
        calculator.add(height: .doubleUnit)
        calculator.add(texts: [
            model.title: .systemFont(ofSize: 18, weight: .bold),
            model.description: .systemFont(ofSize: 14, weight: .regular)
        ], spacing: .doubleUnit)
        calculator.add(height: .doubleUnit)
        calculator.add(height: actionButtonHeight)
        return calculator.dimensions
    }
}
