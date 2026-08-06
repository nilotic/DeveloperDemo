//
//  ApplePushServiceAlert.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

/// The information for displaying an alert. A dictionary is recommended. If you specify a string, the alert displays your string as the body text.
struct ApplePushServiceAlert {
    /// The title of the notification. Apple Watch displays this string in the short look notification interface. Specify a string that’s quickly understood by the user.
    let title: String
    
    /// Additional information that explains the purpose of the notification.
    var subtitle = ""

    /// The content of the alert message.
    var body = ""
}

extension ApplePushServiceAlert: Encodable {
    
    private enum Key: String, CodingKey {
        case title
        case subtitle
        case body
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(title, forKey: .title) } catch { throw error }
        
        if !subtitle.isEmpty {
            do { try container.encode(subtitle, forKey: .subtitle) } catch { throw error }
        }
            
        if !body.isEmpty {
            do { try container.encode(body, forKey: .body) } catch { throw error }
        }
    }
}

#if DEBUG
extension ApplePushServiceAlert {
    
    static var placeholder: ApplePushServiceAlert {
        ApplePushServiceAlert(title: "배송완료", body: "#{delivery_box_info} \n주문하신 상품을 #{pickup_type_name}에 배송 완료하였습니다.\n주문내역 상세 를 확인해주세요.2023-08-08T16:45")
    }
}
#endif
