//
//  WebViewController.swift
//  Bored
//
//  Created by Intan on 07/05/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let urlString: String
    
    init(with urlString: String){
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: self.urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.webView.load(URLRequest(url: url))
        
        self.setupUI()
    }
    
    private func setupUI(){
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        rightBarButtonItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.view.addSubview(webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    //MARK: - Selectors
    @objc func didTapDone(){
        self.dismiss(animated: true, completion: nil)
    }

}
