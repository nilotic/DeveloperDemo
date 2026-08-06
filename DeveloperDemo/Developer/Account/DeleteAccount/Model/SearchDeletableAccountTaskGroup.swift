//
//  SearchDeletableAccountTaskGroup.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum SearchDeletableAccountTaskGroup {
    case deletableAccountItems(DeletableAccountSearchResponse)
    case withdrawalAccountItems(WithdrawalAccountSearchResponse)
}
