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
        self.setDelegate()
        self.bindViewModel()
        self.setDataSource()
        self.setSnapshot()
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        self.baseView.eyebrowCollectionView.delegate = self
    }
    
    private func transformedOutput() -> ViewModel.Output {
        let input = ViewModel.Input(
            viewDidLoad: self.viewDidLoadPublisher
        )
        return self.viewModel.transform(input: input)
    }
    
    func bindViewModel() {
        let output = transformedOutput()
        
        output.eyebrowPosition
            .sink(receiveValue: { [weak self] _ in
                // FIXME: eyebrowposition 받아와지면 해당 값으로 적용
                guard let self = self else { return }
                self.baseView.placeEyebrowView(
                    left: .init(x: 20, y: 100, width: 50, height: 25),
                    right: .init(x: 100, y: 100, width: 50, height: 25)
                )
            })
            .store(in: &self.cancelBag)
    }
}

// MARK: - Simulator

extension SimulatorViewController {
    private func addEyebrowView(on frame: CGRect) {
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        self.baseView.addSubview(view)
    }
    
    private func applyEyebrow(_ eyebrow: EyebrowModel) {
        self.baseView.configureEyebrow(to: eyebrow)
    }
}

// MARK: - CollectionView Datasource

extension SimulatorViewController {
    
    private func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<Cell, Model> { cell, _, eyebrow in
            cell.load(eyebrow: eyebrow)
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

extension SimulatorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EyebrowCell else { return }
        self.applyEyebrow(cell.eyebrowModel)
    }
}
