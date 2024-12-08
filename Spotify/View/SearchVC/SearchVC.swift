//
//  SearchVC.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchListTableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var vm = SearchVM()
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.stopAnimating()
        setupSearchBar()
        setupSearchList()
        bind()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchTimer?.invalidate()
    }
    
    private func bind() {
        vm.listOfTracks.bind { _ in
            DispatchQueue.main.async {
                self.loading.stopAnimating()
                self.searchListTableView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.tintColor = .white
        searchBar.becomeFirstResponder()
    }
    
    private func setupSearchList() {
        searchListTableView.delegate = self
        searchListTableView.dataSource = self
        searchListTableView.registerCell(TrackCell.self)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loading.startAnimating()
        if searchText.isEmpty {
            // show recent
        } else {
            searchTimer?.invalidate()
            guard !searchText.isEmpty else { return }
            
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                self.vm.searchInput = searchText
                self.searchTimer?.invalidate()
            }
            
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.listOfTracks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        cell.setData(track: vm.listOfTracks.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = vm.listOfTracks.value[indexPath.row]
        showConfirmationPopup(track: track)
    }
    
    private func showConfirmationPopup(track: TrackModel) {
        let alert = UIAlertController(title: "", message: "Add \(track.trackName ?? "") to playlist: \(vm.playlistName)?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            self.vm.addTrackToPlaylist(track: track) { success in
                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.showDuplicatedError()
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showDuplicatedError() {
        let alert = UIAlertController(title: "Failed to add to the playlist", message: "You have already had this item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
