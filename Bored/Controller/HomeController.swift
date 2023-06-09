//
//  HomeController.swift
//  Bored
//
//  Created by Intan on 30/03/23.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    //MARK: - Color
    static var globalPink = UIColor(red: 255/255, green: 241/255, blue: 244/255, alpha: 1)
    static var shadowGray = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
  
    //MARK: - Variables
    private let tableCellId = "tableCellId"
    private let cells = [
        Category(imageCell: "diy", categoryLabel: "DIY", imageChev: "r-chevron"),
        Category(imageCell: "social", categoryLabel: "Social", imageChev: "r-chevron"),
        Category(imageCell: "charity", categoryLabel: "Charity", imageChev: "r-chevron"),
        Category(imageCell: "busywork", categoryLabel: "Busywork", imageChev: "r-chevron"),
        Category(imageCell: "relaxation", categoryLabel: "Relaxation", imageChev: "r-chevron"),
        Category(imageCell: "recreational", categoryLabel: "Recreational", imageChev: "r-chevron"),
        Category(imageCell: "music", categoryLabel: "Music", imageChev: "r-chevron"),
        Category(imageCell: "cooking", categoryLabel: "Cooking", imageChev: "r-chevron"),
        Category(imageCell: "education", categoryLabel: "Education", imageChev: "r-chevron")
    ]

    private let imageAct = ["diy","social","charity","busywork","relaxation","recreational","music","cooking","education"]
    
    //MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = HomeController.globalPink
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    private let scrollContainer: UIView = {
        let sc = UIView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.backgroundColor = HomeController.globalPink
        return sc
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "random")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Try it out now!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Or you can find by category:"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let textLabelRandom : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Let's find something to do."
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let randomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.systemGray4.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5.0
        view.layer.cornerRadius = 20
        view.layer.shouldRasterize = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableLayerView: UIView = {
        let tlv = UIView()
        tlv.backgroundColor = .black
        tlv.translatesAutoresizingMaskIntoConstraints = false
        return tlv
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.backgroundColor = HomeController.globalPink
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let textHello : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    
    

    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = HomeController.globalPink
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        setupUI()
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            DispatchQueue.main.async {
                if let user = user {
                    self.textHello.text = "Hello, \(user.name)!"
                }
            }
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(TableCell.self, forCellReuseIdentifier: "tableCellId")
        tryButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    

    //MARK: - UI Setup
    private func setupUI() {
        let credits = UIImage(systemName: "info.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let creditsInfo = UIBarButtonItem(image: credits, style: .plain, target: self, action: #selector(infoTapped))
        self.navigationItem.leftBarButtonItem = creditsInfo
        
        let logoutBtn = UIBarButtonItem(title:"Logout", style: .plain, target: self, action: #selector(didLogout))
        logoutBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = logoutBtn
        
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollContainer.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContainer.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            //for dynamic vertical scrolling
            scrollContainer.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
            scrollContainer.heightAnchor.constraint(equalToConstant: 1475)
        ])

        scrollContainer.addSubview(textHello)
        textHello.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 18).isActive = true
        textHello.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor, constant: 36).isActive = true
        
        scrollContainer.addSubview(randomView)
        randomView.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor).isActive = true
        randomView.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 72).isActive = true
        randomView.heightAnchor.constraint(equalToConstant: 364).isActive = true
        randomView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        scrollContainer.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: randomView.centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: randomView.bottomAnchor, constant: 64).isActive = true
        
        randomView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: randomView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: randomView.topAnchor, constant: 42).isActive = true
        imageView.heightAnchor.constraint(equalTo: randomView.heightAnchor, multiplier: 0.4).isActive = true
        
        randomView.addSubview(textLabelRandom)
        textLabelRandom.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        textLabelRandom.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48).isActive = true
        
        randomView.addSubview(tryButton)
        tryButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        tryButton.bottomAnchor.constraint(equalTo: textLabelRandom.bottomAnchor, constant: 78).isActive = true
        tryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        tryButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        scrollContainer.addSubview(tableLayerView)
        tableLayerView.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor).isActive = true
        tableLayerView.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 1235).isActive = true
        tableLayerView.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        tableLayerView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableLayerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: tableLayerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableLayerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: tableLayerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableLayerView.bottomAnchor)
        ])
    }
    
    //MARK: - Selectors
    @objc func didTapButton(_ sender: UIButton) {
        let rc = RandomController()
        let navVC = UINavigationController(rootViewController: rc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
//        navigationController?.pushViewController(rc, animated: true)
    }
    
    @objc func infoTapped() {
        let showInfo = UIAlertController(title: "FYI", message: "This all data are comes from The Bored API.", preferredStyle: .alert)
        showInfo.addAction(UIAlertAction(title: "Okay!", style: .default))
        present(showInfo, animated: true)
    }
    
    @objc func didLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

extension HomeController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! TableCell
        let itemCell = cells[indexPath.item]
        cell.category = itemCell
        cell.contentView.backgroundColor = HomeController.globalPink
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dtc = DetailTableViewController()
        dtc.categorySelected = imageAct[indexPath.row]
        let navVC = UINavigationController(rootViewController: dtc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
