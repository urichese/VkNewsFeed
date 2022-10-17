//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by urichese on 17.10.2022.
//

import UIKit

class FeedViewController: UIViewController {
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        networkService.getFeed()
    }
}
