//
//  UITableView.swift
//  CodebaseIOS
//
//  Created by ArifRachman on 05/09/22.
//  Copyright © 2022 CodebaseIOS. All rights reserved.
//

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}


extension UITableViewCell {
    
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

extension UITableViewHeaderFooterView {
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

extension UITableView {
    func registerCell<T: UITableViewCell>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueCell<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}
