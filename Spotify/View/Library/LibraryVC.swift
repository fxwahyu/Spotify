//
//  LibraryVC.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class LibraryVC: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    @IBOutlet weak var listTypeButton: UIButton!
    
    var vm = LibraryVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        vm.fetchPlaylistsFromCoreData()
    }
    
    private func initialSetup() {
        setupCategoryCollectionView()
        setupPlaylistTableview()
        setupPlaylistCollectionview()
    }
    
    private func bind() {
        vm.playlist.bind { _ in
            DispatchQueue.main.async {
                self.changeListView()
            }
        }
        
        vm.listType.bind { _ in
            DispatchQueue.main.async {
                self.changeListView()
            }
        }
    }
    
    private func changeListView() {
        if vm.listType.value == .LIST {
            self.playlistTableView.reloadData()
            self.playlistTableView.isHidden = false
            self.playlistCollectionView.isHidden = true
        } else {
            self.playlistCollectionView.reloadData()
            self.playlistCollectionView.isHidden = false
            self.playlistTableView.isHidden = true
        }
    }
    
    private func setupCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.registerCell(CategoryCell.self)
        if let flowLayout = categoryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        categoryCollectionView.reloadData()
    }
    
    private func setupPlaylistTableview() {
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        playlistTableView.registerCell(PlaylistTableviewCell.self)
        playlistTableView.isHidden = true
    }
    
    private func setupPlaylistCollectionview() {
        playlistCollectionView.delegate = self
        playlistCollectionView.dataSource = self
        playlistCollectionView.registerCell(PlaylistCollectionviewCell.self)
        playlistCollectionView.isHidden = true
    }
    
    @IBAction func addPlaylistButton(_ sender: Any) {
        let bottomSheetVC = AddPlaylistBottomsheet()
        if let sheet = bottomSheetVC.sheetPresentationController {
            let customDetent = UISheetPresentationController.Detent.custom { context in
                return 90
            }
            sheet.detents = [customDetent, .large()]
            sheet.prefersGrabberVisible = false
        }
        bottomSheetVC.delegate = self
        present(bottomSheetVC, animated: true)
    }
    
    @IBAction func changeListTypeButton(_ sender: Any) {
        if vm.listType.value == .LIST {
            vm.listType.value = .GRID
            listTypeButton.setImage(#imageLiteral(resourceName: "grid icon"), for: .normal)
        } else {
            vm.listType.value = .LIST
            listTypeButton.setImage(#imageLiteral(resourceName: "list icon"), for: .normal)
        }
    }
}

extension LibraryVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return 1
        } else {
            return vm.playlist.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistCollectionviewCell", for: indexPath) as! PlaylistCollectionviewCell
            cell.setup(playlist: vm.playlist.value[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == playlistCollectionView {
            let padding: CGFloat = 12
            let cellWidth = (collectionView.frame.width - (3 * padding)) / 2
            return CGSize(width: cellWidth, height: 230)
        }
        return CGSize(width: 76, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlistName = vm.playlist.value[indexPath.row].name ?? ""
        openDetailPlaylist(playlistName: playlistName)
    }
}

extension LibraryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.playlist.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableviewCell", for: indexPath) as! PlaylistTableviewCell
        cell.setup(playlist: vm.playlist.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlistName = vm.playlist.value[indexPath.row].name ?? ""
        openDetailPlaylist(playlistName: playlistName)
    }
    
    private func openDetailPlaylist(playlistName: String) {
        let vc = PlaylistDetailVC()
        vc.vm.playlistName = playlistName
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LibraryVC: AddPlaylistBottomsheetDelegate {
    func addNewPlaylist() {
        let bottomSheetVC = AddNewPlaylistVC()
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.large(), .large()]
            sheet.prefersGrabberVisible = false
        }
        bottomSheetVC.delegate = self
        present(bottomSheetVC, animated: true)
    }
}

extension LibraryVC: AddNewPlaylistDelegate {
    func playlistAdded() {
        vm.fetchPlaylistsFromCoreData()
    }
}
