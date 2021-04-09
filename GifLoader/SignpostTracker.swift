//
//  SignpostTracker.swift
//  GifLoader
//
//  Created by Aman Gupta on 05/04/21.
//

import Foundation
import os.signpost

internal final class SignpostTracker {
    internal static let shared = SignpostTracker()

    private let log = OSLog(subsystem: "com.creativegif.gifloader", category: "performance tests")

    private var collectedMetrics: [String] = []

    private init() {}

    internal func trackStart(name: StaticString) {
        let nameStr = "\(name)-start"
        guard !collectedMetrics.contains(nameStr) else { return }

        if #available(iOS 12.0, *) {
            os_signpost(.begin, log: self.log, name: name)
        }
        collectedMetrics.append(nameStr)
    }

    internal func trackEnd(name: StaticString) {
        let nameStr = "\(name)-end"
        guard !collectedMetrics.contains(nameStr), collectedMetrics.contains("\(name)-start") else { return }
        
        if #available(iOS 12.0, *) {
            os_signpost(.end, log: self.log, name: name)
        }
        collectedMetrics.append(nameStr)
    }
}

public enum SignpostName {
    public enum Home {
        public static let initTime: StaticString = "Home:init"
        public static let networkTime: StaticString = "Home:network"
        public static let renderTime: StaticString = "Home:render"
    }
}
