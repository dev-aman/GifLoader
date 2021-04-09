//
//  PerformanceTrackingManager.swift
//  GifLoader
//
//  Created by Aman Gupta on 05/04/21.
//

import Foundation
import UIKit

public final class PerformanceTrackingManager {
    private let name: String
    private let initSignpostName: StaticString
    private let networkSignpostName: StaticString
    private let renderSignpostName: StaticString
    private lazy var signpostTracker = SignpostTracker.shared
    
    public init(
        name: String,
        initSignpostName: StaticString,
        networkSignpostName: StaticString,
        renderSignpostName: StaticString
    ) {
        self.name = name
        self.initSignpostName = initSignpostName
        self.networkSignpostName = networkSignpostName
        self.renderSignpostName = renderSignpostName
    }
    
    public func start() {
        signpostTracker.trackStart(name: initSignpostName)
    }
    
    public func startNetwork() {
        signpostTracker.trackEnd(name: initSignpostName)
        signpostTracker.trackStart(name: networkSignpostName)
    }
    
    public func finishNetwork() {
        signpostTracker.trackEnd(name: networkSignpostName)
        signpostTracker.trackStart(name: renderSignpostName)
    }
    
    public func finish() {
        signpostTracker.trackEnd(name: renderSignpostName)
    }

}
