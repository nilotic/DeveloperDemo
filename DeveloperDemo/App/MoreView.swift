//
//  MoreView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct MoreView: View {

    var body: some View {
        NavigationStack {
            List {
                Section("계정") {
                    LabeledContent("로그인", value: "게스트")
                    LabeledContent("등급", value: "-")
                }

                Section("설정") {
                    LabeledContent("알림", value: "켜짐")
                    LabeledContent("버전", value: Bundle.main.shortVersion)
                }

                Section("개발") {
                    NavigationLink("개발자") {
                        DeveloperView()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("더보기")
        }
    }
}

private extension Bundle {

    var shortVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    }
}

#if DEBUG
#Preview {
    MoreView()
}
#endif
