//
//  SearchViewController.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 11/05/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: SearchTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    /// Setting up view
    private func setUpView() {
        searchBar.delegate = self
        searchBar.searchTextField.placeholder = "Search by name"
    }
    
    private func getFavourites() {
        tableView.favourites = UserDefaultManager.getFavouritesData()
        for favourite in tableView.favourites {
            if let index = tableView.mealsData.firstIndex(where: {$0.id == favourite}) {
                tableView.mealsData[index].isFavourite = true
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchMeal(searchedText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: Request Generator
extension SearchViewController: RequestGeneratorProtocol {
    
    private func searchMeal(searchedText: String) {
        
        guard let url = URL(string: completeUrl(endpoint: .searchMeal(searchedText)).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        SearchWebService.shared.searchMeal(url: url) { [weak self] response, msg, error in
            
            guard let strongSelf = self else { return }
            if let response = response {
                if response.count == 0 {
                    strongSelf.tableView.setEmptyMessage("Nothing here!")
                    strongSelf.tableView.mealsData = []
                    strongSelf.tableView.reloadData()
                } else {
                    strongSelf.tableView.restore()
                }
                for data in response {
                    strongSelf.tableView.mealsData.append(MealViewModel(data: data))
                }
                strongSelf.getFavourites()
            }
        }
    }
}
