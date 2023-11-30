//
//  SimulatorView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit

final class SimulatorView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Properties
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuWhite
        return view
    }()
    
    let eyebrowCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        self.setLayout()
        self.configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(previewImageView)
        previewImageView.snp.makeConstraints {
            $0.height.equalTo(SizeLiteral.Screen.width * 4 / 3)
            $0.center.horizontalEdges.equalToSuperview()
        }
        
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(self.previewImageView.snp.bottom)
        }
        
        bottomView.addSubview(self.eyebrowCollectionView)
        eyebrowCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configUI() {
        self.eyebrowCollectionView.collectionViewLayout = createLayout()
    }
}

extension SimulatorView {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(55),
                heightDimension: .absolute(55)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 24
            
            return section
        }, configuration: config)
    }
}
