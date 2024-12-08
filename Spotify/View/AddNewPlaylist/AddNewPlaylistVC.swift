//
//  AddNewPlaylistVC.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

protocol AddNewPlaylistDelegate {
    func playlistAdded()
}

class AddNewPlaylistVC: UIViewController {

    @IBOutlet weak var playlistNameTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var delegate: AddNewPlaylistDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistNameTextField.becomeFirstResponder()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        if playlistNameTextField.text != nil {
            let playlistName = playlistNameTextField.text ?? ""
            do {
                if CoreDataManager.shared.isPlaylistDuplicated(name: playlistName) {
                    self.showDuplicatedError()
                } else {
                    try CoreDataManager.shared.saveNewPlaylist(name: playlistName)
                    dismiss(animated: true)
                    delegate?.playlistAdded()
                }
            } catch {
                print("Failed to save playlist: \(error)")
            }
        }
    }
    
    private func showDuplicatedError() {
        let alert = UIAlertController(title: "", message: "The name is already exist", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
