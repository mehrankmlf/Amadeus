//
//  EmptyState.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 4/25/22.
//

import UIKit
import Combine

protocol EmptyStateDelegate: AnyObject {
    func emptyStateButtonClicked()
}

final class EmptyState {
    
    var delegate: EmptyStateDelegate?
    private var emptyStateView: EmptyStateView!
    
    var subscriber = Set<AnyCancellable>()
    
    fileprivate var hidden = true {
        didSet {
            self.emptyStateView?.isHidden = hidden
        }
    }
    
    init(inView view: UIView?) {
        
        emptyStateView = EmptyStateView.getView()
        emptyStateView?.isHidden = true
        emptyStateView?.fixConstraintsInView(view)
        emptyStateView.buttonPressSubject.sink { [weak self] value in
            self?.delegate?.emptyStateButtonClicked()
        }.store(in: &subscriber)
        
    }
}

extension EmptyState {
    func show(title: String, errorType: EmptyStateErrorType?, isShow: Bool) {
        self.emptyStateView.viewModel = EmptyStateView.ViewModel(title: title, description: nil)
        hidden = !isShow
    }
    
    func hide() {
        hidden = true
    }
}
