//
//  SearchTableView.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 11/05/21.
//

import UIKit

class SearchTableView: UITableView {

    internal var mealsData: [MealViewModel] = [MealViewModel]()
    internal var favouriteClicked: ((Int) -> Void)?
    internal var favourites: [String] = [String]() {
        didSet {
            UserDefaultManager.saveFavouritesData(data: favourites)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        // Register cell
        registerCell()
        tableFooterView = UIView.init(frame: .zero)
    }
    
    /// Registering cells
    private func registerCell() {
        register(cellType: SearchTableViewCell.self)
    }
    
    // MARK: IBACtions
    @IBAction func btnFavouriteClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        mealsData[sender.tag].isFavourite = sender.isSelected
        if let index = favourites.firstIndex(of: mealsData[sender.tag].id) {
            favourites.remove(at: index)
        } else {
            favourites.append(mealsData[sender.tag].id)
        }
        reloadData()
    }
}

// MARK: TableView Methods
extension SearchTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        cell.mealData = mealsData[indexPath.row]
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite.addTarget(self, action: #selector(btnFavouriteClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
