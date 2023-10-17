//
//  BaseViewController.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/7/23.
//

import UIKit
import Combine

typealias BaseViewControllerType = UIViewController & ViewControllerType

class BaseViewController<V: UIView, VM: ViewModelType>: BaseViewControllerType {
    
    var baseView: V
    var viewModel: VM
    var cancelBag: Set<AnyCancellable> = Set()
    
    required init(
        _ view: V,
        _ viewModel: VM
    ) {
        self.baseView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: self.viewModel)
    }
    
    func bind(viewModel: VM) {}
    
}
