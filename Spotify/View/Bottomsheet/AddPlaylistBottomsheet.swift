//
//  AddPlaylistBottomsheet.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

protocol AddPlaylistBottomsheetDelegate {
    func addNewPlaylist()
}

class AddPlaylistBottomsheet: UIViewController {
    
    var delegate: AddPlaylistBottomsheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
    }
    
    @objc func tapped(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true)
        delegate?.addNewPlaylist()
    }
    
}
