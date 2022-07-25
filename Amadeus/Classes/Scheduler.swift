//
//  Scheduler.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 7/25/22.
//

import Foundation
import Combine

final class Scheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main
}
