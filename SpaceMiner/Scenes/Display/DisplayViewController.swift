//
//  Created by Jordi Serra i Font on 21/4/17.
//  Copyright © 2017 kudai. All rights reserved.
//

import UIKit
import BSWInterfaceKit

class DisplayViewControllerFactory {
    static func displayViewController() -> UIViewController {
        let vc = DisplayViewController()
        vc.interactor = DisplayInteractor()
        return vc
    }
}


class DisplayViewController: UIViewController {
    
    private enum Constants {
        static let actionsMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    let rootStackView = UIStackView(.vertical, distribution: .fill)
    
    let messageContainer = UIView()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let progressView: ProgressView = {
        let view = ProgressView(progress: 0.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    
    lazy var actionsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var dataSource: CollectionViewStatefulDataSource<ActionCell>!
    var interactor: DisplayInteractorType!
    
    var progressTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleBar(withTitle: "PLANET")
        view.backgroundColor = .darkGray
        
        setup()
        layout()
        
        interactor.retrieveDisplayData().upon(.main) { (result) in
            switch result {
            case .failure(let error):
                self.configureFor(error: error)
            case .success(let viewModel):
                self.configureFor(viewModel: viewModel)
            }
        }
    }
    
    private func setup() {
        self.dataSource = CollectionViewStatefulDataSource<ActionCell>(state: .loading, collectionView: actionsCollectionView, listPresenter: self)
    }
    
    private func layout() {
        self.view.addSubview(rootStackView)
        rootStackView.fillSuperview()
        
        rootStackView.addArrangedSubview(progressView)
        rootStackView.addArrangedSubview(messageContainer)
        
        rootStackView.addArrangedSubview(actionsCollectionView, layoutMargins: Constants.actionsMargins)
        
        messageContainer.addSubview(messageLabel)
        messageLabel.centerInSuperview()
        
        messageContainer.heightAnchor.constraint(equalTo: actionsCollectionView.heightAnchor).isActive = true
    }
    
    
    func performAction(_ action: DisplayViewModel.Action) {
        if action.title == "DEPART" {
            travel()
        } else {
            print("Doing: \(action.title)")
        }
    }

    func travel() {
        self.progressView.setProgress(0.0, animated: false)
        self.progressTimer?.invalidate()
        self.progressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            guard self.progressView.progress < 1 else {
                timer.invalidate()
                return
            }
            self.progressView.setProgress(self.progressView.progress + 0.1, animated: true)
        }
    }
}

extension DisplayViewController: ViewModelConfigurable, ListStatePresenter {
    func configureFor(viewModel: DisplayViewModel) {
        messageLabel.attributedText = AppThemer.themer.attributedString(
            viewModel.message,
            withFontType: .fontBasic,
            andColor: .white,
            andSize: 14
        )
        
        self.dataSource.updateState(.loaded(data: viewModel.actions))
    }
    
    func configureFor(error: Error) {
        self.dataSource.updateState(.failure(error: error))
    }
    
    func errorConfiguration(forError error: Error) -> ErrorListConfiguration {
        return ErrorListConfiguration.default(ActionableListConfiguration.init(title: AppThemer.themer.attributedString(
            "There has been an error",
            withFontType: .fontBasic,
            andColor: .gray,
            andSize: 14
        )))
    }
}

extension DisplayViewController: UICollectionViewDelegateFlowLayout, ActionCellDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let actionCell = cell as? ActionCell else { return }
        actionCell.delegate = self
    }
    
    func didClickAction(_ action: DisplayViewModel.Action) {
        //TODO: perform action
        performAction(action)
    }
}


