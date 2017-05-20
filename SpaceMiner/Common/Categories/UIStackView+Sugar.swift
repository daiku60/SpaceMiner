//
//  UIStackView+Sugar.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 21/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(_ orientation: UILayoutConstraintAxis, distribution: UIStackViewDistribution = .fill, alignment: UIStackViewAlignment = .fill, spacing: CGFloat = 0) {
        self.init()
        self.axis = orientation
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func clear() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
            removeArrangedSubview(subview)
        }
    }
}
