//
//  Constants.swift
//  Foody CookBook
//
//  Created by Shubham Arora on 10/05/21.
//

import Foundation
import UIKit

let baseUrl: String = "http://www.themealdb.com/api/json/v1/1"
// AppDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate
// Font
enum Font: String{
    case Bold = "HelveticaNeue-bold"
    case Medium = "HelveticaNeue-Medium"
    case Regular = "HelveticaNeue"
    case Light = "HelveticaNeue-light"

    func of(size: CGFloat) -> UIFont {
      return UIFont(name: self.rawValue, size: size)!
    }
}
// User Default
public let userDefault = UserDefaults.standard
