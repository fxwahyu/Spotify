//
//  PlaylistDetailVC.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 08/12/24.
//

import UIKit

class PlaylistDetailVC: UIViewController {

    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistSongsCountLabel: UILabel!
    @IBOutlet weak var songsListTableView: UITableView!
    
    var vm = PlaylistDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaylistTableview()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        vm.fetchPlaylistsFromCoreData()
    }
    
    private func bind() {
        vm.playlist.bind { _ in
            DispatchQueue.main.async {
                self.songsListTableView.reloadData()
                self.setData()
            }
        }
    }
    
    private func setupPlaylistTableview() {
        songsListTableView.delegate = self
        songsListTableView.dataSource = self
        songsListTableView.registerCell(TrackCell.self)
    }
    
    private func setData() {
        playlistNameLabel.text = vm.playlistName
        playlistSongsCountLabel.text = "\(vm.playlist.value.first?.tracks?.count ?? 0) songs"
    }


    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToPlaylist(_ sender: Any) {
        let vc = SearchVC()
        vc.vm.playlistName = vm.playlistName
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlaylistDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getArrayOfTracks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        cell.setData(track: vm.getArrayOfTracks()[indexPath.row], withKind: false)
        return cell
    }
    
    
}
