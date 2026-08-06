//
//  GrowthBookExperiment.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct GrowthBookExperiment {

    let id: String
    let variationID: Int
}

extension GrowthBookExperiment {

    var properties: AmplitudeEventProperties {
        [.experimentID: id,
         .variationID: variationID]
    }

    init?(headerFields: [AnyHashable: Any]) {
        let experimentIDField = HTTPHeaderField.service(.growthbook(.experimentKey)).rawValue
        let variationIDField = HTTPHeaderField.service(.growthbook(.variationID)).rawValue

        var experimentID: String?
        var variationID: Int?

        for (field, value) in headerFields {
            guard let field = field as? String else { continue }

            if field.caseInsensitiveCompare(experimentIDField) == .orderedSame {
                experimentID = value as? String

            } else if field.caseInsensitiveCompare(variationIDField) == .orderedSame {
                variationID = Int("\(value)")
            }
        }

        guard let experimentID, let variationID else { return nil }

        self.id = experimentID
        self.variationID = variationID
    }
}
