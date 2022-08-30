//
//  HoverProtocol.swift
//  Hover
//
//  Created by Onur Cantay on 08/01/2022.
//  Copyright © 2022 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
import Combine

 protocol BaseAPIProtocol {
  
  /// Requests with `DataTaskPublisher` with body response
  /// - Parameters:
  ///   - target: `NetworkTarget`
  ///   - decoder: `Decodable`
  ///   - scheduler:  Threading and execution time helper if you want to run it on main thread just use `Runloop.main` or `DispatchQueue.main`
  ///   - response: Response Model
  @available(iOS 13.0, *)
  func request<M, T>(
    with target: NetworkTarget,
    decoder: JSONDecoder,
    scheduler: T,
    response type: M.Type
  ) -> AnyPublisher<M, APIError> where M: Decodable, T: Scheduler
}
