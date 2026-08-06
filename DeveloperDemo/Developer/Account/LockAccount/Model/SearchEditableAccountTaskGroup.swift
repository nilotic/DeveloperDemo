//
//  SearchEditableAccountTaskGroup.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum SearchEditableAccountTaskGroup {
    case lockableAccountItems(EditableAccountSearchResponse)
    case unlockableAccountItems(EditableAccountSearchResponse)
}
