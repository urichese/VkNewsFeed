//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by urichese on 16.10.2022.
//

import Foundation
import VK_ios_sdk

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "51449392"
    private let vkSDK: VKSdk
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        print("vk initialized")
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
