//
//  CameraView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Combine
import UIKit

import SnapKit

final class CameraView: ViewType {
    
    // MARK: - Properties
    
    var shutterButtonTrigger: AnyPublisher<Void, Never> {
        return self.shutterButton
            .controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    // MARK: - UI Properties
    
    let cameraLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuWhite
        return view
    }()
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.roundCorners(40)
        button.makeBorder(.main, 10)
        return button
    }()
    
    // MARK: - Life Cycles
    
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
        self.addSubview(cameraLayerView)
        cameraLayerView.snp.makeConstraints {
            $0.center.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiteral.Screen.width * 4 / 3)
        }
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(self.cameraLayerView.snp.bottom)
        }
        self.bottomView.addSubview(shutterButton)
        shutterButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
    }
}

extension CameraView {
    func insertCameraLayer(layer: CALayer) {
        self.cameraLayerView.layer.insertSublayer(layer, below: self.cameraLayerView.layer)
        layer.frame = self.cameraLayerView.layer.bounds
    }
}
