//
//  ViewController.swift
//  GifLoader
//
//  Created by Aman Gupta on 05/04/21.
//

import UIKit

class ViewController: UIViewController {

    private let performanceTrackingManager = PerformanceTrackingManager(name: "Home",
                                                                initSignpostName: SignpostName.Home.initTime,
                                                                networkSignpostName: SignpostName.Home.networkTime,
                                                                renderSignpostName: SignpostName.Home.renderTime)
    private lazy var randomImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (self.view.frame.width/2)-150,
                                                  y: (self.view.frame.height/2)-100,
                                                  width: 300,
                                                  height: 200))
        imageView.image = UIImage(named: "whymeme")
        imageView.accessibilityIdentifier = "randomImageView"
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print("aman: \(documentsDirectory)")
        
        performanceTrackingManager.start()
        networkCall()
    }

    private func networkCall() {
        performanceTrackingManager.startNetwork()
        sleep(1)
        performanceTrackingManager.finishNetwork()
        renderView()
    }

    private func renderView() {
        self.view.addSubview(randomImage)
        performanceTrackingManager.finish()
    }
    
}

