//
//  VideoDetailController.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import UIKit
import WebKit

final class VideoDetailController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    let video: Video
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
        title = video.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.backgroundColor = .systemBackground
        webView.scrollView.backgroundColor = .clear
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        guard let url = URL(string: video.player) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareVideo))
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func shareVideo() {
        guard let videoLink = URL(string: video.player) else { return }
        let ac = UIActivityViewController(activityItems: [videoLink], applicationActivities: nil)
        
        present(ac, animated: true)
    }
}
