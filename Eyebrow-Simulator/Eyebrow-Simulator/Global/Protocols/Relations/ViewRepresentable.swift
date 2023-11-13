//
//  ViewRepresentable.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/17/23.
//

import Foundation

protocol ViewRepresentable {
    associatedtype View
    var baseView: View { get set }
}
