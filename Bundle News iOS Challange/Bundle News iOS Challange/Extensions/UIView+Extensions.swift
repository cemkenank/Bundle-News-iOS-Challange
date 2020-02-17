//
//  UIView+Extensions.swift
//  Bundle News iOS Challange
//
//  Created by MrDark on 16.02.2020.
//  Copyright © 2020 MrDark. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
