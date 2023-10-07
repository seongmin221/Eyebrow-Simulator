//
//  BaseViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

typealias BaseViewControllerType = UIViewController & ViewControllerType

class BaseViewController<T: ViewModelType>: BaseViewControllerType {
    
    var viewModel: T
    var cancelBag: Set<AnyCancellable> = Set()
    
    required init(_ viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel)
    }
    
    func bind(viewModel: T) {}
    
}
