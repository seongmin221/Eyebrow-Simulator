//
//  ViewModelBindable.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import Foundation
import Combine

protocol ViewModelBindable {
    associatedtype ViewModel: ViewModelType
    var viewModel: ViewModel { get set }
    var cancelBag: Set<AnyCancellable> { get set }
    func bindViewModel()
}
