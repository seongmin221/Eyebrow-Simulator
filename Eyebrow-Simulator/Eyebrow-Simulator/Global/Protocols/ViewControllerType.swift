//
//  ViewControllerType.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Foundation
import Combine

protocol ViewControllerType {
    
    associatedtype ViewModel
    
    var viewModel: ViewModel { get set }
    var cancelBag: Set<AnyCancellable> { get set }
    
    init(_ viewModel: ViewModel)
    
    func bind(viewModel: ViewModel)
}
