//
//  ProgressView.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 22/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    private(set) var progress: CGFloat
    
    var widthConstraint: NSLayoutConstraint?
    
    let completedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    init(progress: CGFloat) {
        self.progress = progress
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(completedView)
        
        completedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        completedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        completedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        widthConstraint = completedView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: progress)
        widthConstraint?.isActive = true
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        self.progress = progress
        
        DispatchQueue.main.async {
            self.widthConstraint?.isActive = false
            self.widthConstraint = self.completedView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: self.progress)
            self.widthConstraint?.isActive = true
            
            if animated {
                UIView.animate(withDuration: 1, animations: self.layoutIfNeeded)
            }
        }
    }
}
