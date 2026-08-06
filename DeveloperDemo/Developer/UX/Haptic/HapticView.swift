//
//  HapticView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HapticView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var repeatCount: UInt = 1
    @State private var intensity = 0.1
    
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        Group {
            if #available(iOS 26, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                
            } else {
                contentView
            }
        }
        .navigationTitle(DeveloperItem.haptic.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Private
    private var contentView: some View {
        List {
            repeatSectionView
            selectionSectionView
            impactSectionView
            impactIntensitySectionView
            notificationSecitonView
        }
    }
    
    private var repeatSectionView: some View {
        Section("repeat") {
            Picker("repeatCount", selection: $repeatCount) {
                ForEach(UInt(1)...UInt(10), id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
    
    private var selectionSectionView: some View {
        Section("selection") {
            HapticItemView(data: .selection) {
                hapticGenerate(service: HapticService.selection)
            }
        }
    }
    
    private var impactSectionView: some View {
        Section("impact") {
            HapticItemView(data: .light) {
                hapticGenerate(service: HapticService.impact(.light))
            }
            
            HapticItemView(data: .medium) {
                hapticGenerate(service: HapticService.impact(.medium))
            }
            
            HapticItemView(data: .heavy) {
                hapticGenerate(service: HapticService.impact(.heavy))
            }
            
            HapticItemView(data: .soft) {
                hapticGenerate(service: HapticService.impact(.soft))
            }
            
            HapticItemView(data: .rigid) {
                hapticGenerate(service: HapticService.impact(.rigid))
            }
        }
    }
    
    private var impactIntensitySectionView: some View {
        Section("intensity") {
            Picker("intensity", selection: $intensity) {
                ForEach(Array(stride(from: 0.1, through: 1.0, by: 0.05)), id: \.self) { value in
                    Text(String(format: "%.2f", value))
                        .tag(value as Double)
                }
            }
            
            HapticItemView(data: .light) {
                hapticGenerate(service: HapticService.impactIntensity(.light, intensity))
            }
            
            HapticItemView(data: .medium) {
                hapticGenerate(service: HapticService.impactIntensity(.medium, intensity))
            }
            
            HapticItemView(data: .heavy) {
                hapticGenerate(service: HapticService.impactIntensity(.heavy, intensity))
            }
            
            HapticItemView(data: .soft) {
                hapticGenerate(service: HapticService.impactIntensity(.soft, intensity))
            }
            
            HapticItemView(data: .rigid) {
                hapticGenerate(service: HapticService.impactIntensity(.rigid, intensity))
            }
        }
    }
    
    private var notificationSecitonView: some View {
        Section("notification") {
            HapticItemView(data: .success) {
                hapticGenerate(service: HapticService.notification(.success))
            }
            
            HapticItemView(data: .warning) {
                hapticGenerate(service: HapticService.notification(.warning))
            }
            
            HapticItemView(data: .error) {
                hapticGenerate(service: HapticService.notification(.error))
            }
        }
    }
    
    private func hapticGenerate(service: HapticService) {
        for i in 0..<repeatCount {
            Task {
                try await Task.sleep(nanoseconds: UInt64(i) * 500_000_000)
                service.generate()
            }
        }
    }
    
}

#if DEBUG
#Preview {
    HapticView()
}
#endif
