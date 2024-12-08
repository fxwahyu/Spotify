//
//  ThumbnailGridView.swift
//  Spotify
//
//  Created by Wahyu Herdianto on 07/12/24.
//

import UIKit

class ThumbnailGridView: UIView {

    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    var thumbnailData: Playlist? {
        didSet {
            thumbnailCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, _ data: Playlist? = nil) {
        super.init(frame: frame)
        self.thumbnailData = data
        initialize()
    }
    
    private func initialize() {
        let xibView = Bundle.main.loadNibNamed("ThumbnailGridView", owner: self, options: nil)!.first as! UIView
        xibView.frame = self.bounds
        self.addSubview(xibView)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
        thumbnailCollectionView.registerCell(ThumbnailCell.self)
        thumbnailCollectionView.reloadData()
    }
}

extension ThumbnailGridView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailData?.tracks?.count ?? 0 > 4 ? 4 : thumbnailData?.tracks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCell", for: indexPath) as! ThumbnailCell
        let tracksArray = (thumbnailData?.tracks as? Set<Track>)?.sorted { $0.trackName ?? "" < $1.trackName ?? "" }
        cell.setImage(imageUrl: tracksArray?[indexPath.row].artworkUrl100 ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = self.frame.size.width/2
        return CGSize(width: imageSize, height: imageSize)
    }
    
}
