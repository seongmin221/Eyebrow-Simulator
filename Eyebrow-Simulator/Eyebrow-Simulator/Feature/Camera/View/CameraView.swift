//
//  CameraView.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

import SnapKit

final class CameraView: UIView {
    
    // MARK: - Properties
    // MARK: - UI Properties
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .menuWhite
        return view
    }()
    let shutterButton: UIButton = {
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
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(180)
        }
        self.bottomView.addSubview(shutterButton)
        shutterButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }
    }
}
