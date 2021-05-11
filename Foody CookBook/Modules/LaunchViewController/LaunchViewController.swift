//
//  LaunchViewController.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {

    private var animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting up animation view
        setUpAnimationView()
    }
    
    /// Setting up animation view
    private func setUpAnimationView() {
        animationView = .init(name: "food")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let homeViewController = HomeViewController.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}
