//
//  RandomController.swift
//  Bored
//
//  Created by Intan on 07/04/23.
//

import UIKit

class RandomController: UIViewController {
    
    //MARK: - Color
    static var globalPink = UIColor(red: 255/255, green: 241/255, blue: 244/255, alpha: 1)
    static var shadowGray = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
    
    //MARK: - Variables
    var activityView: UIActivityIndicatorView?

    //MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "random")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    //MARK: - Connect to API
    private func fetchJSON() {
        DispatchQueue.main.async { [self] in
            showActivityIndicatory()
            self.titleLabel.text = ""
            self.descTextView.text = ""

            
            let urlString = "https://www.boredapi.com/api/activity?"
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = URL(string: urlString) {
                    
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) {  (data, response, error) in
                        if error != nil {
                            self.hideActivityIndicator()
                            self.showError()
                            DispatchQueue.main.async {
                                self.titleLabel.text = "Ooopps! :("
                                self.descTextView.text = "Please check your connection and try again."
                            }
                            return
                        }
                        
                        if let data = try? Data(contentsOf: url) {
                            self.hideActivityIndicator()
                            self.parse(json: data)
                            return
                        }
                    }
                    task.resume()
                }
                
            }
        }
    }
    
    
    private func parse(json: Data){
        
        let decoder = JSONDecoder()
        
        if let decodedData = try? decoder.decode(Activity.self, from: json) {
            let titleType = decodedData.type
            let descActivity = decodedData.activity
            DispatchQueue.main.async {
                self.titleLabel.text = titleType
                self.descTextView.text = descActivity
            }
        } else {
            showError()
        }
    }
    
    private func showError(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let eror = UIAlertController(title: "Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            eror.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(eror, animated: true)
        }
    }
    
    private func showActivityIndicatory() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView?.translatesAutoresizingMaskIntoConstraints = false
        activityView?.startAnimating()
        
        view.addSubview(activityView!)
        activityView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityView?.stopAnimating()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RandomController.globalPink
        setupUI()
        DispatchQueue.global(qos: .background).async {
            self.fetchJSON()
        }
        refreshButton.addTarget(self, action: #selector(didTapRefreshButton(_:)), for: .touchUpInside)
    }
    
    
    //MARK: - UI Setup
    fileprivate func setupUI(){
        
        let back = UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", image: back, target: self, action: #selector(backTapped))
        
        let view1 = UIView()
        view1.backgroundColor = .red
        view1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let view2 = UIView()
        view2.backgroundColor = .red
        view2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let randomStackView = UIStackView(arrangedSubviews: [imageView, view2, titleLabel, descTextView, refreshButton, view1])
        randomStackView.axis = .vertical
        randomStackView.distribution = .fillProportionally
        randomStackView.translatesAutoresizingMaskIntoConstraints = false
        randomStackView.alignment = .center
        imageView.heightAnchor.constraint(equalTo: randomStackView.heightAnchor, multiplier: 0.35).isActive = true
        
        
        view.addSubview(randomStackView)
        NSLayoutConstraint.activate([
            randomStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            randomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            randomStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            randomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        
    }
    
    //MARK: - Selectors
    @objc func backTapped() {
        let _ = self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapRefreshButton(_ sender: UIButton){
        fetchJSON()
    }
}

