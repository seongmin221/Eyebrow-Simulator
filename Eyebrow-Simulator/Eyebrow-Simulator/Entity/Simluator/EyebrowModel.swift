//
//  EyebrowModel.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 11/30/23.
//

import UIKit

struct EyebrowModel: Hashable {
    let image: UIImage
    
    init(image: UIImage = .init()) {
        self.image = image
    }
}

extension EyebrowModel {
    static let eyebrows: [EyebrowModel] = [
        .init(image: .init(named: "eyebrow1")!),
        .init(image: .init(named: "eyebrow2")!),
        .init(image: .init(named: "eyebrow3")!),
        .init(image: .init(named: "eyebrow4")!),
        .init(image: .init(named: "eyebrow5")!),
        .init(image: .init(named: "eyebrow6")!),
        .init(image: .init(named: "eyebrow7")!),
        .init(image: .init(named: "eyebrow8")!),
        .init(image: .init(named: "eyebrow9")!),
        .init(image: .init(named: "eyebrow10")!),
    ]
}
