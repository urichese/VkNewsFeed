//
//  NewsfeedPresenter.swift
//  VkNewsFeed
//
//  Created by urichese on 17.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
      switch response {
          
      case .some:
          print(".some Presenter")
      case .presentNewsFeed:
          print(".presentNewsFeed Presenter")
          viewController?.displayData(viewModel: .displayNewsFeed)
      }
  }
  
}
