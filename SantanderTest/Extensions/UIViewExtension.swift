//
//  UIViewExtension.swift
//  SantanderTest
//
//  Created by Lucas Pelinzon on 28/09/19.
//  Copyright © 2019 Lucas Pelinzon. All rights reserved.
//

import UIKit

extension UIView {
  func round(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
