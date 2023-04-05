//
//  OnboardingItem.swift
//  OnboardingTravel
//
//  Created by Aslıhan Gürkan on 6.04.2023.
//

import UIKit

struct OnboardingItem {
    
    let title : String
    let detail : String
    let bgImage : UIImage?
    
    static let placeholderItems : [OnboardingItem] = [
        .init(title: "Travel Your Way", detail: "Travel the world by air, rail or sea at the most competitive prices", bgImage: UIImage(named: "travel1")),
        .init(title: "Stay Your Way", detail: "With over millions of hotels worlwide, find the perfect accommodation in the most amazing places!", bgImage: UIImage(named: "travel2")),
        .init(title: "Discover Your Way With New Features", detail: "Explore exotic destinations with our features that link you to like-minded travellers!", bgImage: UIImage(named: "travel3")),
        .init(title: "Fast Your way", detail: "We recommend you local cuisines that are safe aand highly recommended by the locals!", bgImage: UIImage(named: "travel4"))
    ]
}

