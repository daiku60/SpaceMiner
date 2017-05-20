//
//  ActionCell.swift
//  SpaceMiner
//
//  Created by Jordi Serra i Font on 20/5/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import Foundation
import BSWInterfaceKit

private enum ButtonState {
    case normal
    case pressed
    case disabled
}

protocol ActionCellDelegate: class {
    func didClickAction(_ action: DisplayViewModel.Action)
}

class ActionCell: UICollectionViewCell {
    
    private enum Constants {
        static let borderWidth: CGFloat = 4
        static let borderColor: UIColor = .white
        
        static let focusedTitleColor: UIColor = .gray
    }
    
    
    //MARK: UI Elements
    
    let actionButton = UIButton()
    
    
    //MARK: Properties
    
    fileprivate var state: ButtonState = .normal {
        didSet {
            setupButtonForCurrentState()
        }
    }
    
    weak var delegate: ActionCellDelegate?
    
    private var action: DisplayViewModel.Action?
    
    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        contentView.addSubview(actionButton)
        actionButton.fillSuperview()
        
        actionButton.setTitleColor(Constants.focusedTitleColor, for: .focused)
        actionButton.layer.borderColor = Constants.borderColor.cgColor
        actionButton.layer.borderWidth = Constants.borderWidth
    }
    
    func setupButtonForCurrentState() {
        
        let props: (backgroundColor: UIColor, textColor: UIColor) = {
            switch self.state {
            case .normal:
                return (.clear, .white)
            case .pressed:
                return (.white, .gray)
            default:
                return (.clear, .gray)
            }
        }()
        actionButton.backgroundColor = props.backgroundColor
        
        guard let title = actionButton.attributedTitle(for: .normal)?.string else { return }
        actionButton.setAttributedTitle(
            AppThemer.themer.attributedString(
                title,
                withFontType: .fontBasic,
                andColor: props.textColor,
                andSize: 14)
            , for: .normal
        )
    }
    
    func touchDown(_ sender: UIButton) {
        self.state = .pressed
    }
    
    func touchUpInside(_ sender: UIButton) {
        self.state = .normal
    }
}

extension ActionCell: ViewModelReusable {
    func configureFor(viewModel action: DisplayViewModel.Action) {
        //TODO: configure for action
        
        let buttonConfiguration = ButtonConfiguration(
            buttonTitle: ButtonTitle.text(AppThemer.themer.attributedString(
                action.title,
                withFontType: .fontBasic,
                andColor: .white,
                andSize: 14)),
            actionHandler: { _ in
                self.delegate?.didClickAction(action)
        })
        actionButton.setButtonConfiguration(buttonConfiguration)
        
        state = action.isEnabled ? .normal : .disabled
    }
}
