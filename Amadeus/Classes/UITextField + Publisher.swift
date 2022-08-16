//
//  UITextField + Publisher.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 8/16/22.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap(\.text) 
            .eraseToAnyPublisher()
    }
}
