//
//  SimulatorViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

final class SimulatorViewController: ViewControllerType {
    
    typealias View = SimulatorView
    typealias ViewModel = SimulatorViewModel
    
    typealias Cell = EyebrowCell
    typealias Model = EyebrowModel
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Model>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Model>
    
    enum Section {
        case main
    }
    
    // MARK: - Property
    
    var baseView: SimulatorView = .init()
    
    var viewModel: SimulatorViewModel
    var cancelBag: Set<AnyCancellable> = Set()
    
    private var dataSource: DataSource!
    private var snapshot: Snapshot!
    
    // MARK: - Life Cycle
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.setDataSource()
        self.setSnapshot()
    }
    
    // MARK: - Setting
    
    func bindViewModel() {
        
    }
    
    func bind(cell: Cell) {
        
    }
}

extension SimulatorViewController {
    
    private func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<Cell, Model> { cell, _, eyebrow in
            cell.load(eyebrow: eyebrow)
            self.bind(cell: cell)
        }
        
        self.dataSource = DataSource(
            collectionView: self.baseView.eyebrowCollectionView,
            cellProvider: { collectionView, indexPath, eyebrow in
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: eyebrow
                )
            }
        )
    }
    
    private func setSnapshot() {
        self.snapshot = Snapshot()
        self.snapshot.appendSections([.main])
        self.snapshot.appendItems(EyebrowModel.eyebrows, toSection: .main)
        self.dataSource.apply(self.snapshot)
    }
}
