//
//  Array+Extension.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

extension Array {
    var nilOrNotEmpty: Array? {
        isEmpty ? nil : self
    }
    
    var isMultiple: Bool {
        count >= 2
    }
    
    var lastIndex: Int {
        count - 1
    }
    
    var toJSONString: String {
        guard JSONSerialization.isValidJSONObject(self) else { return "" }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}

extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        
        return filter { seen.insert($0).inserted }
    }
    
    func countForElements() -> [(value: Element, count: Int)] {
        let countedSet = NSCountedSet(array: self)
        
        return uniqued().reduce(into: [(Element, Int)]()) { result, value in
            result.append((value, countedSet.count(for: value)))
        }
    }
}

extension Array where Element: Equatable {
    func uniqued() -> [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}

extension Array {
    func joinedString(using separator: JoinSeparator) -> String {
        self.map { "\($0)" }.joined(separator: separator.rawValue)
    }
    
    enum JoinSeparator {
        /// `>` 기호를 사용하는 구분자입니다. 예: `"1>2>3"`
        case arrow
        /// `,` 기호를 사용하는 구분자입니다. 예: `"1,2,3"`
        case comma
        
        var rawValue: String {
            switch self {
            case .arrow: return ">"
            case .comma: return ","
            }
        }
    }
}
