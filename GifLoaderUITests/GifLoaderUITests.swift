//
//  GifLoaderUITests.swift
//  GifLoaderUITests
//
//  Created by Aman Gupta on 05/04/21.
//

import XCTest
import UIKit

class GifLoaderUITests: XCTestCase {

    private var app = XCUIApplication()

    override func setUpWithError() throws {
        app = XCUIApplication()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print("aman: ui \(documentsDirectory)")
        continueAfterFailure = false
    }

    func testHomePLT() throws {
        measure(metrics: [
            getSignpostMetric(name: SignpostName.Home.initTime),
            getSignpostMetric(name: SignpostName.Home.networkTime),
            getSignpostMetric(name: SignpostName.Home.renderTime)
        ], block: {
            app = XCUIApplication()
            app.launch()
            _ = app.otherElements
                .matching(.image, identifier: "randomImageView")
                .firstMatch
                .waitForExistence(timeout: 30)
        })
    }
    
    private func getSignpostMetric(name: StaticString) -> XCTOSSignpostMetric {
        return XCTOSSignpostMetric(subsystem: "com.creativegif.gifloader",
                                   category: "performance tests",
                                   name: "\(name)")
    }
    
    private func waitForAppLaunch() {
        // Wait for application to enter the foreground
        if !app.wait(for: .runningForeground, timeout: 30) {
            XCTFail("Unable to launch GIFLoader")
        }
    }

}
