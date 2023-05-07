//
//  AuthHeaderView.swift
//  Bored
//
//  Created by Intan on 02/05/23.
//

import UIKit

class AuthHeaderView: UIView {

    //MARK: - Variables
    
    //MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "login")
        iv.tintColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 22, weight: .bold)
        lb.text = "Error"
        return lb
    }()
    
    private let subLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .secondaryLabel
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        lb.text = "Error"
        return lb
    }()
    
    //MARK: - LifeCycle
    init(title: String, subTitle: String){
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subLabel.text = subTitle
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 120),
            self.imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            self.subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
