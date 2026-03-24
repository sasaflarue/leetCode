//
//  FilterBarView.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import UIKit

final class FilterBarView: UIView {
    let category = UISegmentedControl(items: ["All"] + EventCategory.allCases.map { $0.rawValue.capitalized })
    let search = UISearchBar()
    let sort = UISegmentedControl(items: ["Rel", "Date", "Price", "Pop"])
    let clear = UIButton(type: .system)

    var onChange: ((_ category: EventCategory?, _ city: String, _ sort: Query.Sort) -> Void)?
    var onClear: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        category.selectedSegmentIndex = 0
        sort.selectedSegmentIndex = 0
        clear.setTitle("Clear", for: .normal)

        let stack = UIStackView(arrangedSubviews: [category, search, sort, clear])
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

        category.addTarget(self, action: #selector(handleChange), for: .valueChanged)
        sort.addTarget(self, action: #selector(handleChange), for: .valueChanged)
        search.delegate = self
        clear.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
    }

    required init?(coder: NSCoder) { fatalError() }

    @objc private func handleChange() {
        let catIndex = category.selectedSegmentIndex
        let cat: EventCategory? = (catIndex > 0) ? EventCategory.allCases[catIndex - 1] : nil
        let city = search.text ?? ""
        let s: Query.Sort = [Query.Sort.relevance, .date, .price, .popularity][sort.selectedSegmentIndex]
        onChange?(cat, city, s)
    }

    @objc private func handleClear() { onClear?() }
}

extension FilterBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { handleChange() }
}

