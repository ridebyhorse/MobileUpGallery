//
//  GalleryController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit
import VKID

final class GalleryController: UIViewController {
    let presenter: GalleryPresenter
    private var photos = [Photo]()
    private var videos = [Video]()
    
    private lazy var control: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "Фото", at: 0, animated: true)
        control.insertSegment(withTitle: "Видео", at: 1, animated: true)
        control.addTarget(self, action: #selector(tabSwitched), for: .valueChanged)
        
        return control
    }()
    
    private let photoView = PhotoView()
    private let videoView = VideoView()
    
    init(presenter: GalleryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.activate()
        title = "Mobile Up Gallery"
        configure()
        setDelegates()
    }
    
    private func setDelegates() {
        photoView.photoCollection.dataSource = self
        photoView.photoCollection.delegate = self
        videoView.videoCollection.dataSource = self
        videoView.videoCollection.delegate = self
    }

    private func configure() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        control.selectedSegmentIndex = 0

        view.addSubview(control)
        view.addSubview(photoView)
        view.addSubview(videoView)
        view.subviews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            control.heightAnchor.constraint(equalToConstant: 32),
            photoView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 8),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videoView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 8),
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        videoView.isHidden = true
    }
    
    private func setupNavigationItem() {
        navigationItem.hidesBackButton = true
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(signOutTapped))
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func signOutTapped() {
        presenter.signOut()
    }
    
    @objc private func tabSwitched(_ sender: UISegmentedControl) {
        photoView.isHidden.toggle()
        videoView.isHidden.toggle()
    }
}

private extension GalleryController {
    func getCollectionViewCell(for photoId: Int) -> PhotoCell? {
        let indexPath = IndexPath(item: photoId, section: 0)
        guard let cell = photoView.photoCollection.cellForItem(at: indexPath) as? PhotoCell else { return nil }
        
        return cell
    }
    
    func getCollectionViewCell(for videoId: Int) -> VideoCell? {
        let indexPath = IndexPath(item: videoId, section: 0)
        guard let cell = videoView.videoCollection.cellForItem(at: indexPath) as? VideoCell else { return nil }
        
        return cell
    }
}

extension GalleryController: GalleryControllerProtocol, PhotoViewProtocol, VideoViewProtocol {
    func updatePhotos(photos: [Photo]) {
        self.photos = photos
        photoView.photoCollection.reloadData()
    }

    func updateVideos(videos: [Video]) {
        self.videos = videos
        videoView.videoCollection.reloadData()
    }
}

extension GalleryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return photos.count
        default:
            return videos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "photoCell",
                for: indexPath) as? PhotoCell else {
                return UICollectionViewCell()
            }
            
            let photoData = photos[indexPath.row]
            
            cell.delegate = self
            cell.configure(with: photoData, and: indexPath)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "videoCell",
                for: indexPath) as? VideoCell else {
                return UICollectionViewCell()
            }
            
            let videoData = videos[indexPath.row]
            cell.delegate = self
            cell.configure(with: videoData, and: indexPath)
            return cell
        }
    }
}

extension GalleryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = indexPath.row
        switch control.selectedSegmentIndex {
        case 0:
            presenter.selectPhoto(id)
        default:
            presenter.selectVideo(id)
        }
    }
}

extension GalleryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            let interItemSpacing: CGFloat = 4
            let numberOfItemsPerRow: CGFloat = 2
            let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
            let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
            return CGSize(width: itemSize, height: itemSize)
        default:
            let itemSize = collectionView.bounds.width
            return CGSize(width: itemSize, height: itemSize * 0.56)
        }
    }
}

extension GalleryController: LoadingPresenting {
    func showLoading() {
        let loading = LoadingView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loading.topAnchor.constraint(equalTo: view.topAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func hideLoading() {
        for view in view.subviews {
            if let loading = view as? LoadingView {
                loading.removeFromSuperview()
            }
        }
    }
}
