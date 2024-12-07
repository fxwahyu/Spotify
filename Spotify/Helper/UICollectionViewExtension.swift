//
//  UICollectionViewExtension.swift
//  Fruit Hub
//
//  Created by Wahyu Herdianto on 02/10/23.
//

import UIKit

extension UICollectionViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
  static var nibName: String {
    return String(describing: self )
  }
  
  static var nib: UINib? {
    if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
      return UINib(nibName: self.nibName, bundle: nil)
    }
    return nil
  }
}

extension UICollectionView {
  func registerCell<T: UICollectionViewCell>(_: T.Type) {
    if let nib = T.nib {
      self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    } else {
      self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
  }
  
  func dequeueCell<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}
