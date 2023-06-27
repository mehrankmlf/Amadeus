//
//  SplashViewController.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 9/12/21.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {
    
    let timer = CountDownTimer(duration: 4)
    let contentView = SplashView()
    let subscriber = Cancelable()
    var navigateSubject = PassthroughSubject<SplashViewController.Event, Never>()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteBackground
        self.setupTimer()
        self.setupNavigation()
    }
    
    private func setupTimer() {
        self.timer
            .map { String(describing: $0) }
            .sink { [weak self] value in
                switch value{
                case .finished:
                    self?.navigateSubject.send(.splash)
                }
            } receiveValue: { value in
                print(value)
            }.store(in: subscriber)
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension SplashViewController {
    enum Event {
        case splash
    }
}




