//
//  SlideCell.swift
//  Bored
//
//  Created by Intan on 29/03/23.
//

import UIKit

class SlideCell: UICollectionViewCell {
    
    //MARK: - Color
        static var globalPink = UIColor(red: 255/255, green: 241/255, blue: 244/255, alpha: 1)

    //MARK: - Variables
    var slide: Slide? {
        didSet {
            guard let unwrappedPage = slide else { return }
            imageView.image = UIImage(named: unwrappedPage.image)

            let attributeOne : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
            let attributeTwo : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.gray]

            let title = NSAttributedString(string: unwrappedPage.title, attributes: attributeOne)
            let description = NSAttributedString(string: "\n\n\n\(unwrappedPage.description)", attributes: attributeTwo)

            let finalAttributedString = NSMutableAttributedString()
            finalAttributedString.append(title)
            finalAttributedString.append(description)

            titleLabel.attributedText = finalAttributedString
            titleLabel.textAlignment = .center
        }
    }

    //MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "slide1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let titleLabel: UITextView = {
       let textView = UITextView()
        let attributeOne : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
        let attributeTwo : [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.gray]

        let title = NSAttributedString(string: "Boredom Is A State Of Mind", attributes: attributeOne)
        let description = NSAttributedString(string: "\n\nWhen you are bored that means you have nothing to do and that is definitely not a fun thing.", attributes: attributeTwo)

        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(title)
        finalAttributedString.append(description)
        textView.attributedText = finalAttributedString
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SlideCell.globalPink
        setupUI()
    }

    //MARK: - UI Setup
    private func setupUI() {
        let onboardingView = UIView()
        addSubview(onboardingView)
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        
        onboardingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        onboardingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onboardingView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        onboardingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        onboardingView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        onboardingView.backgroundColor = .clear
        
        
        let slideStackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        slideStackView.axis = .vertical
        slideStackView.translatesAutoresizingMaskIntoConstraints = false
        slideStackView.distribution = .fillProportionally
        imageView.heightAnchor.constraint(equalTo: slideStackView.heightAnchor, multiplier: 0.4).isActive = true
        
        onboardingView.addSubview(slideStackView)
        
        NSLayoutConstraint.activate([
            slideStackView.topAnchor.constraint(equalTo: onboardingView.safeAreaLayoutGuide.topAnchor),
            slideStackView.bottomAnchor.constraint(equalTo: onboardingView.bottomAnchor),
            slideStackView.leftAnchor.constraint(equalTo: onboardingView.leftAnchor, constant: 24),
            slideStackView.rightAnchor.constraint(equalTo: onboardingView.rightAnchor, constant: -24)
        ])

 
//        onboardingView.addSubview(imageView)
//        imageView.centerXAnchor.constraint(equalTo: onboardingView.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: onboardingView.centerYAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalTo: onboardingView.heightAnchor, multiplier: 0.45).isActive = true
//
//        onboardingView.addSubview(titleLabel)
//        titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 124).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: onboardingView.leftAnchor, constant: 24).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: onboardingView.rightAnchor, constant: -24).isActive = true


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
