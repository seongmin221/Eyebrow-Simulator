//
//  SimulatorView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

final class SimulatorView: UIView {
    
    // MARK: - UI Properties
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let boundingBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.makeBorder(.red, 2)
        return view
    }()
    
    private let leftEyebrowView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        view.makeBorder(.red, 2)
        return view
    }()
    
    private let rightEyebrowView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        view.makeBorder(.red, 2)
        return view
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuWhite
        return view
    }()
    
    let eyebrowCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("적용하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        return button
    }()
    
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
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        bottomView.addSubview(self.applyButton)
        applyButton.snp.makeConstraints {
            $0.top.equalTo(self.eyebrowCollectionView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configUI() {
        self.backgroundColor = .menuWhite
        
        self.eyebrowCollectionView.collectionViewLayout = createLayout()
        self.eyebrowCollectionView.backgroundColor = .clear
        self.eyebrowCollectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Simulator

extension SimulatorView {
    func configureSimulationImage(with photo: UIImage) {
        self.previewImageView.image = photo
    }
    
    func placeBoundingBoxView(on frame: CGRect) {
        self.addSubview(boundingBoxView)
        self.boundingBoxView.frame = frame
    }
    
    func placeLeftEyebrow(on box: CGRect) {
        self.addSubview(leftEyebrowView)
        self.leftEyebrowView.frame = box
    }
    
    func placeRightEyebrow(on box: CGRect) {
        self.addSubview(rightEyebrowView)
        self.rightEyebrowView.frame = box
    }
    
    func configureEyebrow(to eyebrow: EyebrowModel) {
        self.leftEyebrowView.image = eyebrow.image
        self.rightEyebrowView.image = eyebrow.image.withHorizontallyFlippedOrientation()
    }
    
    
}

// MARK: - CollectionView Layout

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
            section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            return section
        }, configuration: config)
    }
}
