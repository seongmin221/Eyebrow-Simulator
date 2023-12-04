//
//  EyebrowCell.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 11/30/23.
//

import UIKit

final class EyebrowCell: UICollectionViewCell {
    
    // MARK: - Property
    
    var eyebrowModel: EyebrowModel = EyebrowModel(image: UIImage())
    
    // MARK: - UI Property
    
    private let eyebrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        self.contentView.addSubview(eyebrowImageView)
        eyebrowImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension EyebrowCell {
    func load(eyebrow: EyebrowModel) {
        self.eyebrowModel = eyebrow
        self.eyebrowImageView.image = eyebrow.image
    }
}
