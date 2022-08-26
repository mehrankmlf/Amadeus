//
//  HoverProtocol.swift
//  Hover
//
//  Created by Onur Cantay on 08/01/2022.
//  Copyright © 2022 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
import Combine

 protocol HoverProtocol {
  
  /// Requests for a spesific call with `DataTaskPublisher` for with body response
  /// - Parameters:
  ///   - target: `NetworkTarget`
  ///   - type: Decodable Object Type
  ///   - urlSession: `URLSession`
  ///   - scheduler:  Threading and execution time helper if you want to run it on main thread just use `Runloop.main` or `DispatchQueue.main`
  @available(iOS 13.0, *)
  func request<M, T>(
    with target: NetworkTarget,
    urlSession: URLSession,
    jsonDecoder: JSONDecoder,
    scheduler: T,
    class type: M.Type
  ) -> AnyPublisher<M, APIError> where M: Decodable, T: Scheduler
}
