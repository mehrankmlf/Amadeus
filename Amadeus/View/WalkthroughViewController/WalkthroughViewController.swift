//
//  WalkthroughViewController.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 10/12/21.
//

import UIKit
import Combine

class WalkthroughViewController: BaseViewController {

    var navigateSubject = PassthroughSubject<WalkthroughViewController.Event, Never>()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        addObservers()

        pageControll.pageIndicatorTintColor = .gray
        pageControll.currentPageIndicatorTintColor = .black
    }
    
    @IBAction func pageControll_Clicked(_ sender: UIPageControl) {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.size.width * CGFloat(sender.currentPage), y: 0.0), animated: true)
    }
    
    @IBAction func btnPresentLogin_Clicked(_ sender: Any) {
        self.navigateSubject.send(.walkthrough)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObservers()
        super.viewWillDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.scrollView.setContentOffset(
            CGPoint(x: scrollView.bounds.size.width * CGFloat(pageControll.currentPage), y: 0.0), animated: false)
    }
    
    // MARK: - KVO

    private var keyValueObservations = [NSKeyValueObservation]()

    private func addObservers() {
        let kvo = scrollView.observe(\.contentOffset, options: [.new]) { _, change  in
            guard let newValue = change.newValue?.x else {
                return
            }

            let width = self.view.frame.width
            if newValue.truncatingRemainder(dividingBy: width) == 0 {
                self.pageControll.currentPage = Int(newValue / width)
            }
        }
        keyValueObservations.append(kvo)
    }

    private func removeObservers() {
        for kvo in keyValueObservations {
            kvo.invalidate()
        }
        keyValueObservations.removeAll()
    }
}

extension WalkthroughViewController {
    enum Event {
        case walkthrough
    }
}
