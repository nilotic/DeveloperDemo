//
//  TypographySection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TypographySection {
    let title: LocalizedStringKey
    var typographys: [Typography]
    var isExpanded = false
}

extension TypographySection: Identifiable {
    
    var id: String {
        "\(title)\(typographys.map(\.id).joined())\(isExpanded)"
    }
}

extension TypographySection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TypographySection: Equatable {
    
    static func == (lhs: TypographySection, rhs: TypographySection) -> Bool {
        lhs.id == rhs.id
    }
}

extension TypographySection {
  
    static private let content = """
                                 샛별이 뜰 때가 가장 신선할 때 내일의 장보기 데모마켓
                                 ABCDEFGHIJKLMNOPQRSTUVWXYZ
                                 가나다라마바사아자차카타파하
                                 """
    
    static var bold: TypographySection {
        let typographys = [Typography(index: 0,  size: 64, weight: .bold, lineHeight: 72, content: content),
                           Typography(index: 1,  size: 32, weight: .bold, lineHeight: 44, content: content),
                           Typography(index: 2,  size: 28, weight: .bold, lineHeight: 36, content: content),
                           Typography(index: 3,  size: 24, weight: .bold, lineHeight: 32, content: content),
                           Typography(index: 4,  size: 20, weight: .bold, lineHeight: 28, content: content),
                           Typography(index: 5,  size: 18, weight: .bold, lineHeight: 26, content: content),
                           Typography(index: 6,  size: 16, weight: .bold, lineHeight: 22, content: content),
                           Typography(index: 7,  size: 14, weight: .bold, lineHeight: 20, content: content),
                           Typography(index: 8,  size: 13, weight: .bold, lineHeight: 18, content: content),
                           Typography(index: 9,  size: 12, weight: .bold, lineHeight: 16, content: content),
                           Typography(index: 10, size: 10, weight: .bold, lineHeight: 14, content: content)]
        
        return TypographySection(title: "bold", typographys: typographys)
    }
  
    static var semibold: TypographySection {
        let typographys = [Typography(index: 0,  size: 64, weight: .semibold, lineHeight: 72, content: content),
                           Typography(index: 1,  size: 32, weight: .semibold, lineHeight: 44, content: content),
                           Typography(index: 2,  size: 28, weight: .semibold, lineHeight: 36, content: content),
                           Typography(index: 3,  size: 24, weight: .semibold, lineHeight: 32, content: content),
                           Typography(index: 4,  size: 20, weight: .semibold, lineHeight: 28, content: content),
                           Typography(index: 5,  size: 18, weight: .semibold, lineHeight: 26, content: content),
                           Typography(index: 6,  size: 16, weight: .semibold, lineHeight: 22, content: content),
                           Typography(index: 7,  size: 14, weight: .semibold, lineHeight: 20, content: content),
                           Typography(index: 8,  size: 13, weight: .semibold, lineHeight: 18, content: content),
                           Typography(index: 9,  size: 12, weight: .semibold, lineHeight: 16, content: content),
                           Typography(index: 10, size: 10, weight: .semibold, lineHeight: 14, content: content)]
        
        return TypographySection(title: "semibold", typographys: typographys)
    }

    static var regular: TypographySection {
        let typographys = [Typography(index: 0,  size: 64, weight: .regular, lineHeight: 72, content: content),
                           Typography(index: 1,  size: 32, weight: .regular, lineHeight: 44, content: content),
                           Typography(index: 2,  size: 28, weight: .regular, lineHeight: 36, content: content),
                           Typography(index: 3,  size: 24, weight: .regular, lineHeight: 32, content: content),
                           Typography(index: 4,  size: 20, weight: .regular, lineHeight: 28, content: content),
                           Typography(index: 5,  size: 18, weight: .regular, lineHeight: 26, content: content),
                           Typography(index: 6,  size: 16, weight: .regular, lineHeight: 22, content: content),
                           Typography(index: 7,  size: 14, weight: .regular, lineHeight: 20, content: content),
                           Typography(index: 8,  size: 13, weight: .regular, lineHeight: 18, content: content),
                           Typography(index: 9,  size: 12, weight: .regular, lineHeight: 16, content: content),
                           Typography(index: 10, size: 10, weight: .regular, lineHeight: 14, content: content)]
        
        return TypographySection(title: "regular", typographys: typographys)
    }
}

#if DEBUG
extension TypographySection {
    
    static var placeholder: TypographySection {
        bold
    }
}
#endif
