//
//  SearchTableViewCell.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 11/05/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var searchImageview: UIImageView!
    
    // Variable
    internal var mealData: MealViewModel! {
        didSet {
            searchImageview.sd_setImage(with: URL(string: mealData.mealThumb), placeholderImage: nil)
            lblName.text = mealData.name
            btnFavourite.isSelected = mealData.isFavourite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .selected)
        btnFavourite.setImage(UIImage(systemName: "star"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
