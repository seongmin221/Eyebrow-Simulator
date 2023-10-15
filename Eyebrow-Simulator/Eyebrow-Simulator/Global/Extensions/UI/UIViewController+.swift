//
//  UIViewController+.swift
//  Eyebrow-Simulator
//
//  Created by 이성민 on 10/15/23.
//

import UIKit

extension UIViewController {
    
    func hideNavigationBar(_ isHidden: Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
}
