//
//  ViewController.swift
//  OnboardingTravel
//
//  Created by Aslıhan Gürkan on 3.04.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var darkView: UIView!
    
    private var items : [OnboardingItem] = []
    private var currentPage : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPlaceholderItems()
        setupPageControl()
        setupScreen(index : currentPage)
//        updateBackgroundImage(index: currentPage)
        setupGestures()
        setupViews()
        
    }
    
    private func setupPlaceholderItems() {
        items = OnboardingItem.placeholderItems
    }

    private func setupViews() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
    }

    private func updateBackgroundImage(index: Int) {
        let image = items[index].bgImage
        UIView.transition(with: bgImageView, duration: 0.5, options: .transitionCrossDissolve) {
            self.bgImageView.image = image
        }
        
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        detailLabel.text = items[index].detail
        pageControl.currentPage = index
        
        titleLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        titleLabel.transform = .identity
        detailLabel.transform = .identity
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapAnimation() {
        
        
        // first animation : title label
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5,
                       options: .curveEaseInOut, animations: {
            //TODO: expl.
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            })
            
        }
        
        // second animation : detail label
        
        //delay: 0.5 because we wait to title animate's is over
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { _ in
            
            if self.currentPage < self.items.count - 1 {
                //want to show next image when detail tab disappear
                self.updateBackgroundImage(index: self.currentPage + 1)
            }
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }) { _ in
//                 print("done!")
                self.currentPage += 1
                
                if self.isOverLastItem() {
                    //show the main part of the app
                    self.showMainApp()
                } else {
                    self.setupScreen(index: self.currentPage)
                }
                
            }
        }
    }
    
    private func isOverLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    private func showMainApp() {
        //MainAppViewController : StoryBoardID
        
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainAppViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = mainAppViewController
            //Transition to main app
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

