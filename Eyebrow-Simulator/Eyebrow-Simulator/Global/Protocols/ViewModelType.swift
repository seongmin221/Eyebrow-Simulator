//
//  ViewModelType.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Foundation

typealias ViewModelType = ViewModel

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
