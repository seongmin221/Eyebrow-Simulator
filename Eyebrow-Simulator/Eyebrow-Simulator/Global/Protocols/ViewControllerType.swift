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
    
    associatedtype View
    associatedtype ViewModel
    
    var baseView: View { get set }
    
    var viewModel: ViewModel { get set }
    var cancelBag: Set<AnyCancellable> { get set }
    
    init( _ view: View, _ viewModel: ViewModel)
    
    func bind(viewModel: ViewModel)
}
