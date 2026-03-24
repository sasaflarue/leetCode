//
//  EventListViewController.swift
//  PracticeInterview
//
//  Created by Alexander LaRue on 10/31/25.
//

import UIKit
import Combine

final class EventListViewController: UIViewController, UICollectionViewDataSourcePrefetching {
    enum Section { case main }

    private let filterBar = FilterBarView()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Event>!
    private let refresh = UIRefreshControl()
    private let vm: EventListViewModel

    private var cancellables = Set<AnyCancellable>()
    private var errorLabel = UILabel()

    init(service: EventService) {
        self.vm = EventListViewModel(service: service)
        super.init(nibName: nil, bundle: nil)
        title = "Events"
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupFilterBar()
        setupCollection()
        setupDataSource()
        setupRefresh()
        bindVM()

        vm.loadInitial()
    }

    private func setupFilterBar() {
        view.addSubview(filterBar)
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        filterBar.onChange = { [weak self] cat, city, sort in
            guard let self else { return }
            var f = self.vm.filters
            f.category = cat
            f.cityQuery = city
            f.sort = sort
            self.vm.filters = f
        }
        filterBar.onClear = { [weak self] in
            guard let self else { return }
            self.vm.filters = FilterState()
            self.filterBar.category.selectedSegmentIndex = 0
            self.filterBar.search.text = ""
            self.filterBar.sort.selectedSegmentIndex = 0
        }
    }

    private func setupCollection() {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            // Simple one-column list-like layout
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                heightDimension: .estimated(160)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                           heightDimension: .estimated(160)),
                                                         subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
            section.interGroupSpacing = 12
            return section
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.reuseID)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.prefetchDataSource = self

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: filterBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Event>(collectionView: collectionView) {
            (cv, indexPath, item) -> UICollectionViewCell? in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: EventCell.reuseID, for: indexPath) as! EventCell
            cell.configure(item)
            return cell
        }
    }

    private func setupRefresh() {
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refresh
    }

    @objc private func didPullToRefresh() { vm.refresh() }

    private func bindVM() {
        // Polling approach for brevity (you can convert VM to @Published + Combine if you prefer)
        // Apply snapshots whenever we come back to main thread updates
        let applySnapshot: () -> Void = { [weak self] in
            guard let self else { return }
            var snap = NSDiffableDataSourceSnapshot<Section, Event>()
            snap.appendSections([.main])
            snap.appendItems(self.vm.items, toSection: .main)
            self.dataSource.apply(snap, animatingDifferences: true)
            self.refresh.endRefreshing()
            if let msg = self.vm.errorMessage {
                self.showError(msg)
            } else {
                self.clearError()
            }
        }

        // naive timer to reflect VM state changes (keeps sample simple)
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in applySnapshot() }
    }

    private func showError(_ message: String) {
        if errorLabel.superview == nil {
            errorLabel.numberOfLines = 0
            errorLabel.textAlignment = .center
            errorLabel.textColor = .systemRed
            view.addSubview(errorLabel)
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                errorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            ])
        }
        errorLabel.text = "Error: \(message) • Tap to retry"
        let tap = UITapGestureRecognizer(target: self, action: #selector(retry))
        errorLabel.isUserInteractionEnabled = true
        errorLabel.addGestureRecognizer(tap)
    }

    private func clearError() { errorLabel.removeFromSuperview() }

    @objc private func retry() {
        clearError()
        vm.loadInitial()
    }

    // MARK: Prefetching/Pagination
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let max = indexPaths.map(\.item).max() else { return }
        vm.loadNextPageIfNeeded(visibleIndex: max)
    }
}
