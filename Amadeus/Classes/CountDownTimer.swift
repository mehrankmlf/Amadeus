//
//  CountDownTimer.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 4/13/22.
//

import Foundation
import Combine

struct CountDownTimer: Publisher {
    struct TimeRemaining: CustomStringConvertible {
        let min, seconds, totalSeconds: Int

        var description: String {
            String(format: "%02d:%02d", min, seconds)
        }
    }

    typealias Output = TimeRemaining
    typealias Failure = Never

    let duration: TimeInterval

    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Output == S.Input {
        let subscription = CountDownSubscription(duration: duration, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

private extension CountDownTimer {
    class CountDownSubscription<S: Subscriber>: Subscription where S.Input == Output, S.Failure == Failure {
        private var duration: Int
        private var subscriber: S?
        private var timer: Timer?

        init(duration: TimeInterval, subscriber: S) {
            self.duration = Int(duration)
            self.subscriber = subscriber
        }

        func request(_ demand: Subscribers.Demand) {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                self.duration -= 1
                if self.duration == 0 {
                    self.subscriber?.receive(completion: .finished)
                    self.cancel()
                } else {
                    let components = self.durationToTimeComponents(self.duration)
                    let timeRemaining = TimeRemaining(min: components.min, seconds: components.seconds, totalSeconds: self.duration)
                    _ = self.subscriber?.receive(timeRemaining)
                }
            })
                self.timer?.fire()
        }

        func cancel() {
            timer?.invalidate()
        }

        func durationToTimeComponents(_ duration: Int) ->(min: Int, seconds: Int) {
            return (min: duration / 60, seconds: duration % 60)
        }
    }
}
