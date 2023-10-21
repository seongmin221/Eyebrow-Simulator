//
//  CameraResultView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit

import SnapKit

final class CameraResultView: ViewType {
    
    // MARK: - Property
    
    let previewImage: UIImage
    
    // MARK: - UI Property
    
    private let preivewImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    init(previewImage: UIImage) {
        self.previewImage = previewImage
        super.init(frame: .zero)
        self.setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        self.addSubview(preivewImageView)
        preivewImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
