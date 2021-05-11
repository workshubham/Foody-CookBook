//
//  DesignableButton.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
