//
//  EventCell.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import UIKit

final class EventCell: UICollectionViewCell {
    static let reuseID = "EventCell"
    private let imageView = UIImageView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let price = UILabel()
    private let badge = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        title.font = .preferredFont(forTextStyle: .headline)
        subtitle.font = .preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        price.font = .preferredFont(forTextStyle: .subheadline)
        badge.font = .systemFont(ofSize: 12, weight: .semibold)
        badge.textColor = .white
        badge.backgroundColor = .systemOrange
        badge.layer.cornerRadius = 6
        badge.layer.masksToBounds = true
        badge.textAlignment = .center
        badge.setContentHuggingPriority(.required, for: .horizontal)

        let textStack = UIStackView(arrangedSubviews: [title, subtitle, price])
        textStack.axis = .vertical
        textStack.spacing = 4

        let h = UIStackView(arrangedSubviews: [textStack, badge])
        h.alignment = .center
        h.spacing = 8

        let stack = UIStackView(arrangedSubviews: [imageView, h])
        stack.axis = .vertical
        stack.spacing = 8

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 2/3).isActive = true

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(_ e: Event) {
        title.text = e.name
        subtitle.text = "\(e.venue.city), \(e.venue.state) • " + DateFormatter.localizedString(from: e.datetimeLocal, dateStyle: .medium, timeStyle: .short)
        price.text = "From \(e.pricing.currency) \(e.pricing.min)"
        badge.isHidden = !(e.flags.fewLeft || e.flags.lowFees)
        badge.text = e.flags.fewLeft ? "Few left" : (e.flags.lowFees ? "Low fees" : "")
        // Minimal image loading (replace with better cache if you want)
        imageView.image = nil
        if let url = e.images.hero {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data, let img = UIImage(data: data) else { return }
                DispatchQueue.main.async { self?.imageView.image = img }
            }.resume()
        }
    }
}

