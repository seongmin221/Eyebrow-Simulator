//
//  CameraResultView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

import SnapKit

final class CameraResultView: ViewType {
    
    // MARK: - Property
    
    var continueButtonTrigger: AnyPublisher<Void, Never> {
        return self.continueButton
            .controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    var retakeButtonTrigger: AnyPublisher<Void, Never> {
        return self.retakeButton
            .controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    // MARK: - UI Property
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuWhite
        return view
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.roundCorners(40)
        button.makeBorder(.main, 10)
        return button
    }()
    
    private let retakeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "arrow.clockwise"), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        self.setLayout()
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
        
        bottomView.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        bottomView.addSubview(retakeButton)
        retakeButton.snp.makeConstraints {
            $0.centerY.equalTo(self.continueButton)
            $0.trailing.equalToSuperview().inset(40)
            $0.size.equalTo(50)
        }
    }
}

extension CameraResultView {
    func configurePreviewImage(with image: UIImage) {
        self.previewImageView.image = image
    }
    
    func animateContinueButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.continueButton.makeBorder(.main, 40)
        })
    }
}
