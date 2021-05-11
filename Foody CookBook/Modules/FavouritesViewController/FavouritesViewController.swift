//
//  FavouritesViewController.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 11/05/21.
//

import UIKit
import Lottie

class FavouritesViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    
    // Variables
    internal var favourites: [String] = [String]()
    private var mealsData: [MealViewModel] = [MealViewModel]()
    private let animationView = AnimationView.init(name: "food")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavourites()
        setUpView()
    }
    
    /// Setting up view
    private func setUpView() {
        setLoaderConstraint()
        tableView.tableFooterView = UIView.init(frame: .zero)
        // Register Cell
        registerCell()
    }
    
    /// Registering cells
    private func registerCell() {
        tableView.register(cellType: SearchTableViewCell.self)
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
    
    /// Get favourite meals detail
    private func getFavourites() {
        favourites = UserDefaultManager.getFavouritesData()
        let dispatchGroup = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
        for favourite in favourites {
            dispatchGroup.enter()
            DispatchQueue.global(qos: .background).async {
                semaphore.wait()
                self.getMealDetail(id: favourite) { response in
                    self.mealsData.append(response)
                    semaphore.signal()
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            if self.mealsData.count == 0 {
                self.tableView.setEmptyMessage("Nothing here!")
            } else {
                self.tableView.restore()
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: IBActions
    @IBAction func btnBackClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: TableView Methods
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        cell.mealData = mealsData[indexPath.row]
        cell.btnFavourite.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: Request Generator
extension FavouritesViewController: RequestGeneratorProtocol {
    
    private func getMealDetail(id: String, onCompletion: @escaping (MealViewModel) -> Void) {
        DispatchQueue.main.async {
            self.showLoader()
        }
        guard let url = URL(string: completeUrl(endpoint: .getMealDetail(id))) else { return }
        HomeWebService.shared.getRandomMeal(url: url) { [weak self] response, message, error in
            
            guard let strongSelf = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                strongSelf.hideLoader()
            }
            if let response = response {
                onCompletion(MealViewModel(data: response))
            }
        }
    }
}
