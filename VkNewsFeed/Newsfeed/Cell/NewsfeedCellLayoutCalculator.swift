//
//  NewsfeedCellLayoutCalculator.swift
//  VkNewsFeed
//
//  Created by urichese on 19.10.2022.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 0)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + topViewHeight + 8, left: 8, bottom: 8, right: 20) // исправить
    static let postLabelFonts = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)){
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: - работа с postLableFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = screenWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFonts)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - работа с attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: - работа с bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //MARK: - работа с totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom

        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame)
    }
}