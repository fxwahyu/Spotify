//
//  PlaylistDetailVCViewController.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class PlaylistDetailVCViewController: UIViewController {

    @IBOutlet weak var musicListTableView: UITableView!
    
    var musics: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }

    private func initialize() {
        musicListTableView.registerCell(MusicSearchCell.self)
        musicListTableView.dataSource = self
        musicListTableView.delegate = self
    }
    
    private func promptForAnswer() {
        let ac = UIAlertController(title: "What's playlist name?", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Create", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.savePlaylist(name: answer.text ?? "")
            // do something interesting with "answer" here
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    private func savePlaylist(name: String) {
        do {
            try CoreDataManager.shared.saveNewPlaylist(name: name)
            fetchPlaylists()
            print("Playlist and musics saved successfully!")
        } catch {
            print("Failed to save playlist: \(error)")
        }
    }
    
    private func fetchPlaylists() {
        do {
            let tracks: [Track] = try CoreDataManager.shared.fetch(Track.self)
            self.musics = tracks
            musicListTableView.reloadData()
            print("this is tracks from core data", tracks)
            print("this is tracks from var", self.musics)
        } catch {
            print("Failed to fetch playlist: \(error)")
        }
    }

    @IBAction func addMusic(_ sender: Any) {
    }
}

extension PlaylistDetailVCViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicSearchCell", for: indexPath) as! MusicSearchCell
        cell.musicName.text = self.musics[indexPath.row].trackName
//        cell.musicName.text = "\(musics[indexPath.row].artistName) - \(musics[indexPath.row].trackName)"
        return cell
    }
    
    
}
