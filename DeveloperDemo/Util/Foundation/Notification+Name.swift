//
//  Notification+Name.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let restartApp = Notification.Name("restartApp")
    static let userDidLogin = Notification.Name("userDidLogin")
    static let moveToRecommendation = Notification.Name("moveToRecommendation")
    static let moveToPopularProduct = Notification.Name("moveToPopularProduct")
    static let moveToProductList = Notification.Name("moveToProductList")
    static let moveToCategoryProducts = Notification.Name("moveToCategoryProducts")
    static let moveToProductCollection = Notification.Name("moveToProductCollection")
    static let moveToBeautyProfile = Notification.Name("moveToBeautyProfile")
    static let updateBasedOnUserType = Notification.Name("updateBasedOnUserType")
    static let updateBasedOnMembershipStatus = Notification.Name("updateBasedOnMembershipStatus")
    static let updateSortOptionInProductList = Notification.Name("updateSortOptionInProductList")
    static let updateRecommendation = Notification.Name("updateRecommendation")
    static let updateProductReviews = Notification.Name("updateProductReviews")
    static let updateProductInquiries = Notification.Name("updateProductReviews")
    static let updateMyPage = Notification.Name("updateMyPage")
    static let reloadMyPage = Notification.Name("reloadMyPage")
    static let updateOrderSheet = Notification.Name("updateOrderSheet")
    static let updatePurchaseOrderHistories = Notification.Name("updatePurchaseOrderHistories")
    static let updateOneToOneInquiries = Notification.Name("updateOneToOneInquiries")
    static let updateNotificationSetting = Notification.Name("updateNotificationSetting")
    static let removeProductReview = Notification.Name("removeProductReview")
    static let removeOneToOneInquiry = Notification.Name("removeOneToOneInquiry")
    static let receiveDefaultWebKitMessageInWeb = Notification.Name("receiveDefaultWebKitMessageInWeb")
    static let receiveDefaultWebKitMessageInProductWeb = Notification.Name("receiveDefaultWebKitMessageInProductWeb")
    static let receiveDefaultWebKitMessageInOrder = Notification.Name("receiveDefaultWebKitMessageInOrder")
    static let receiveDefaultWebKitMessageInSignup = Notification.Name("receiveDefaultWebKitMessageInSignup")
    static let tabPageControllerIndexChanged = Notification.Name("tabPageControllerIndexChanged")
    static let addressUpdated = Notification.Name("addressUpdated")
    static let addressAdded = Notification.Name("addressAdded")
    static let addressDeleted = Notification.Name("addressDeleted")
    static let currentDeliveryAddressChangedBySelect = Notification.Name("currentDeliveryAddressChangedBySelect")
    static let currentDeliveryAddressChangedByDelete = Notification.Name("currentDeliveryAddressChangedByDelete")
    static let currentDeliveryAddressChangedByAdd = Notification.Name("currentDeliveryAddressChangedByAdd")
    static let setAdultVerification = Notification.Name("setAdultVerification")
    static let reloadWebView = Notification.Name("realoadWebView")
    static let runCallbackFunction = Notification.Name("runCallbackFunction")
    static let finishAndRefresh = Notification.Name("finishAndRefresh")
    static let addToCartSuccess = Notification.Name("addToCartSuccess")

    struct ImageTask {
        struct Default {
            static let Downloading = Notification.Name("Photo.ImageTask.Default.Downloading")
            static let DidCompleted = Notification.Name("Photo.ImageTask.Default.DidCompleted")

        }
        struct Thumbnail {
            static let Downloading = Notification.Name("Photo.ImageTask.Thumbnail.Downloading")
            static let DidCompleted = Notification.Name("Photo.ImageTask.Thumbnail.DidCompleted")
        }
    }
}
