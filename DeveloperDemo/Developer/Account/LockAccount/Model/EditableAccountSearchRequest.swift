//
//  EditableAccountSearchRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct EditableAccountSearchRequest {
    let keyword: String
    let searchType: EditableAccountSearchType
    let status: AccountLockStatus
}

extension EditableAccountSearchRequest: Encodable {

    private enum Key: String, CodingKey {
        case keyword = "searchValue"
        case searchType = "searchKeyword"
        case size
        case page
        case status = "loginStatus"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(keyword, forKey: .keyword) } catch { throw error }
        do { try container.encode(searchType, forKey: .searchType) } catch { throw error }
        do { try container.encode(10, forKey: .size) } catch { throw error }
        do { try container.encode(0, forKey: .page) } catch { throw error }
        do { try container.encode(status, forKey: .status) } catch { throw error }
    }
}
