//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by urichese on 16.10.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
//        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }

    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

