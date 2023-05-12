//
//  SwipingController.swift
//  Bored
//
//  Created by Intan on 29/03/23.
//

import UIKit
import FirebaseAuth

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Variables
    let slides = [
        Slide(image: "slide1", title: "Boredom Is A State Of Mind", description: "When you are bored that means you have nothing to do and that is definitely not a fun thing."),
        Slide(image: "slide2", title: "Why Boredom Is Bad?", description: "Too much boredom is not good for us… it produces a lot of negative outcomes, such as lack of concentration, accidents, risk taking, or even thrill seeking. "),
        Slide(image: "slide3", title: "How To Be Bored The Right Way", description: "Being Bored Can Be Good for You—If You Do It Right. Instead of sitting around on your phone getting lost in the news and social media (mhmm, doomscrolling), pivot to some fun things you can do at home or in your own backyard.")
    ]
    
    var timer: Timer?
    var currentIndexCell = 0

    //MARK: - UI Components
    private lazy var pageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = slides.count
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .gray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private let startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Let's Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView?.register(SlideCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.contentInsetAdjustmentBehavior = .never
        startTimer()
        startButton.addTarget(self, action: #selector(checkAuthentication(_:)), for: .touchUpInside)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()

            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }

        }) { (_) in

        }
    }
    
    private func startTimer() {
        timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc private func checkAuthentication(_ sender: UIButton) {
        if Auth.auth().currentUser == nil {
            //Go to Sign In screen
            let lc = LoginController()
            let navVC = UINavigationController(rootViewController: lc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        } else {
            //Go to Home screen
            let hc = HomeController()
            let navVC = UINavigationController(rootViewController: hc)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        let bottomControlStackView = UIStackView(arrangedSubviews: [pageControl, startButton])
        bottomControlStackView.distribution = .fillProportionally
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.axis = .vertical
        
        view.addSubview(bottomControlStackView)
        
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            bottomControlStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
    }
    
    //MARK: - Selectors
    @objc func moveToNextIndex() {
        if currentIndexCell < slides.count - 1 {
            currentIndexCell += 1
        } else {
            currentIndexCell = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentIndexCell, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndexCell
    }

}


//MARK: - Collection View Delegate
extension SwipingController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SlideCell
        let slide = slides[indexPath.item]
        cell.slide = slide
        return cell
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x

        pageControl.currentPage = Int(x / view.frame.width)

    }
}
