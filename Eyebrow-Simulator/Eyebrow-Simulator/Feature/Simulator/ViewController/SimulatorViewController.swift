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
            viewDidLoad: self.viewDidLoadPublisher,
            viewWillAppear: self.viewWillAppearPublisher
        )
        return self.viewModel.transform(input: input)
    }
    
    func bindViewModel() {
        let output = transformedOutput()
        
        output.originImage
            .sink(receiveValue: { [weak self] ciImage in
                guard let self else { return }
                let image = UIImage(ciImage: ciImage)
                self.baseView.configureSimulationImage(with: image)
            })
            .store(in: &self.cancelBag)
        
        output.faceViewSize
            .sink(receiveValue: { [weak self] size in
                guard let self else { return }
                self.baseView.placeBoundingBoxView(on: size)
            })
            .store(in: &self.cancelBag)
        
//        output.leftEyebrowBox
//            .sink(receiveValue: { [weak self] points in
//                guard let self else { return }
//                self.baseView.addPoints(points)
//            })
//            .store(in: &self.cancelBag)
//        
//        output.rightEyebrowBox
//            .sink(receiveValue: { [weak self] points in
//                guard let self else { return }
//                self.baseView.addPoints(points)
//            })
//            .store(in: &self.cancelBag)
        
        output.leftEyebrowBox
            .sink(receiveValue: { [weak self] box in
                guard let self else { return }
                self.baseView.placeLeftEyebrow(on: box)
            })
            .store(in: &self.cancelBag)
        
        output.rightEyebrowBox
            .sink(receiveValue: { [weak self] box in
                guard let self else { return }
                self.baseView.placeRightEyebrow(on: box)
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
