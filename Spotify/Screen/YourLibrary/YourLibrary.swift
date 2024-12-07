//
//  YourLibrary.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 06/12/24.
//

import UIKit

class YourLibrary: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var musics: [TrackModel] = []
    var playlist: [Playlist] = []
    var vm = YourLibraryVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        fetchPlaylists()
//        getData()

        // Do any additional setup after loading the view.
    }
    
    private func initialize() {
        searchResultTableView.registerCell(MusicSearchCell.self)
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
    
    private func getData() {
        
    }

    @IBAction func addNewPlaylist(_ sender: Any) {
        promptForAnswer()
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
            let playlists: [Playlist] = try CoreDataManager.shared.fetch(Playlist.self)
            self.playlist = playlists
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
            print("this is playlist from core data", playlists)
            print("this is playlist from var", self.playlist)
        } catch {
            print("Failed to fetch playlist: \(error)")
        }
    }
}

extension YourLibrary: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicSearchCell", for: indexPath) as! MusicSearchCell
        cell.musicName.text = self.playlist[indexPath.row].name
//        cell.musicName.text = "\(musics[indexPath.row].artistName) - \(musics[indexPath.row].trackName)"
        return cell
    }
    
    
}
