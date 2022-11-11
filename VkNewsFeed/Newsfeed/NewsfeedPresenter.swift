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
	var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()

	let dateFormatter: DateFormatter = {
		let dt = DateFormatter()
		dt.locale = Locale(identifier: "ru_RU")
		dt.dateFormat = "d MMM 'в' HH:mm"
		return dt
	}()

	func presentData(response: Newsfeed.Model.Response.ResponseType) {

		switch response {
			case .presentNewsfeed(let feed, let revealedPostIds):
				print(revealedPostIds)
				let cells = feed.items.map { (feedItem) in
					cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
				}
				let feedViewModel = FeedViewModel.init(cells: cells)
				viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsfeed(feedViewModel: feedViewModel))
		}
	}

	private func cellViewModel(from feedItem: FeedItem,
							   profiles: [Profile],
							   groups: [Group],
							   revealedPostIds: [Int]) -> FeedViewModel.Cell {
		let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
		let date = Date(timeIntervalSince1970: feedItem.date)
		let dateTitle = dateFormatter.string(from: date)
		let photoAttachment = self.photoAttachment(feedItem: feedItem)
		let isFullSized = revealedPostIds.contains {feedItem.postId == $0}
		let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment, isFullSizedPost: isFullSized)
		return FeedViewModel.Cell.init(postId: feedItem.postId,
									   iconUrlString: profile.photo,
									   name: profile.name,
									   date: dateTitle,
									   text: feedItem.text,
									   likes: String(feedItem.likes?.count ?? 0),
									   comments: String(feedItem.comments?.count ?? 0),
									   shares: String(feedItem.reposts?.count ?? 0),
									   views: String(feedItem.views?.count ?? 0),
									   photoAttachment: photoAttachment,
									   sizes: sizes )
	}
	private func profile(for sourseID: Int,
						 profiles: [Profile],
						 groups: [Group]) -> ProfileRepresentable {
		let profilesOrGroups: [ProfileRepresentable] = sourseID >= 0 ? profiles : groups
		let normalSourseID = sourseID >= 0 ? sourseID : -sourseID
		let profileRepresentable = profilesOrGroups.first { profileRepresentable in
			profileRepresentable.id == normalSourseID
		}
		return profileRepresentable!
	}
	private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
		guard let photos = feedItem.attachments?.compactMap({ attachment in
			attachment.photo
		}), let firstPhoto = photos.first else { return nil}
		return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)

	}
}
