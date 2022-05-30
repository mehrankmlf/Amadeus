//
//  StoryBoard + Extension.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 10/12/21.
//

import UIKit

enum Storyboard: String {
    
    case walkthrough = "Walkthrough"

    func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }
}
