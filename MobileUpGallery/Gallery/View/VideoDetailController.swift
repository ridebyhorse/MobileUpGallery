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
        guard let url = URL(string: video.player) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
