//
//  Observable.swift
//  MyPertamina
//
//  Created by Wahyu Herdianto on 02/11/22.
//  Copyright © 2022 myptm. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
