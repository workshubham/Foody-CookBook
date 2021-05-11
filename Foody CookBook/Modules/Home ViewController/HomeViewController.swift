//
//  HomeViewController.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // Variables
    private var mealData: MealViewModel! {
        didSet {
            updateView()
        }
    }
    private let animationView = AnimationView.init(name: "food")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealImageView.contentMode = .scaleAspectFill
        setLoaderConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRandomMeal()
    }
    
    /// Upodate view by data
    private func updateView() {
        navBar.topItem?.title = mealData.name
        mealImageView.sd_setImage(with: URL(string: mealData.mealThumb), placeholderImage: nil)
        lblArea.text = mealData.area
        lblCategory.text = mealData.category
        instructionsTextView.text = mealData.instructions
    }
    
    /// Setting up loader constraint
    private func setLoaderConstraint() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    /// Show loader
    private func showLoader() {
        backgroundView.isHidden = false
        animationView.isHidden = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
    
    /// Hide loader
    private func hideLoader() {
        animationView.stop()
        animationView.isHidden = true
        backgroundView.isHidden = true
    }
    
    // MARK: IBActions
    @IBAction func btnWatchNowClicked(_ sender: UIButton) {
        guard let url = URL(string: mealData.youtubeLink) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func btnSearchClicked(_ sender: Any) {
        let searchViewController = SearchViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    @IBAction func btnFavouritesClicked(_ sender: Any) {
        let favouriteViewController = FavouritesViewController.instantiate(fromAppStoryboard: .Main)
        navigationController?.pushViewController(favouriteViewController, animated: true)
    }
}

// MARK: Request Generator
extension HomeViewController: RequestGeneratorProtocol {
    
    private func fetchRandomMeal() {
        showLoader()
        guard let url = URL(string: completeUrl(endpoint: .getRandomMeal)) else { return }
        HomeWebService.shared.getRandomMeal(url: url) { [weak self] response, message, error in
            
            guard let strongSelf = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                strongSelf.hideLoader()
            }
            if let response = response {
                strongSelf.mealData = MealViewModel(data: response)
            }
        }
    }
}
