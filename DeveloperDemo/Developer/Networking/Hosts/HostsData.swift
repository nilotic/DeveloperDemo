//
//  HostsData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

@Observable
final class HostsData {

    // MARK: - Value
    // MARK: Public
    var sections = [HostSection]()
    var settingType: HostSettingType = .production
    
    private(set) var isUpdated = false
    private(set) var isProgressing = false
    
    var customHost = ""
    var customGodoHost = ""
    var toastMessage = ""
    
    var isAlertPresented = false
    var isGodoAlertPresented = false
    var isSettingsViewPresented = false

    // MARK: Private
    @ObservationIgnored
    private var items = [String: HostItem]()
    @ObservationIgnored
    private var updatesHosts = Hosts()
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        Task {
            await MainActor.run { isProgressing = true }
            
            // 서버 상태 확인은 부가 정보이므로 실패해도 목록은 그려 준다.
            let isReachable = await isServerReachable()

            do {
                var sections = [HostSection]()
                var items = [HostItem]()
                
                var indexPath = IndexPath(row: 0, section: 0)
                var type = Host.allCases.first?.type ?? ""
                
                let updatesHosts = hosts
                let hosts: Set<Host> = [hosts.api, hosts.authentication, hosts.backOffice,
                                        hosts.godo, hosts.backOffice, hosts.commerce, hosts.nowService,
                                        hosts.appConfiguration, hosts.eventConfiguration]
                
                Host.allCases.forEach { host in
                    if type == host.type {
                        var hostItem = HostItem(host: host, indexPath: indexPath, isSelected: hosts.contains(host))

                        switch host {
                        case .api(let server) where server.isCustom:
                            guard case .custom = updatesHosts.api.server else { break }
                            hostItem.host = updatesHosts.api
                            hostItem.isSelected = true

                        case .godo(let server) where server.isCustom:
                            guard case .custom = updatesHosts.godo.server else { break }
                            hostItem.host = updatesHosts.godo
                            hostItem.isSelected = true

                        default:
                            break
                        }

                        items.append(hostItem)
                    } else {
                        sections.append(HostSection(title: type, items: items))
                        
                        indexPath.section += 1
                        indexPath.row = 0
                        type = host.type
                        
                        items = [HostItem(host: host, indexPath: indexPath, isSelected: hosts.contains(host))]
                    }
                    
                    indexPath.row += 1
                }
                
                sections.append(HostSection(title: type, items: items))
               
                let updatedSections = sections
                await MainActor.run {
                    self.sections = updatedSections
                    self.updatesHosts = updatesHosts
                }
                
            } catch {
                await MainActor.run { toastMessage = error.localizedDescription }
            }

            if !isReachable {
                await MainActor.run { toastMessage = String(localized: "vpnError") }
            }
            
            await MainActor.run { isProgressing = false }
        }
    }
    
    func edit(item: HostItem) {
        switch item.host {
        case .api(.custom(let host)):
            customHost = host
            isAlertPresented = true
        case .godo(.custom(let host)):
            customGodoHost = host
            isGodoAlertPresented = true
        default:
            break
        }
    }
    
    func handle(item: HostItem) {
        guard item.indexPath.section < sections.count, item.indexPath.row < sections[item.indexPath.section].items.count else { return }
        
        for hostItem in sections[item.indexPath.section].items {
            sections[item.indexPath.section].items[hostItem.indexPath.row].isSelected = hostItem == item
            
            guard sections[item.indexPath.section].items[hostItem.indexPath.row].isSelected else { continue }
            
            switch item.host {
            case .api:                      updatesHosts.api = item.host
            case .authentication:           updatesHosts.authentication = item.host
            case .godo:                     updatesHosts.godo = item.host
            case .backOffice:               updatesHosts.backOffice = item.host
            case .commerce:                 updatesHosts.commerce = item.host
            case .nowService:                 updatesHosts.nowService = item.host
            case .appConfiguration:         updatesHosts.appConfiguration = item.host
            case .eventConfiguration:       updatesHosts.eventConfiguration = item.host
            case .googleDeveloper:          continue
            case .googleAccount:            continue
            case .googleAPI:                continue
            case .firebaseCloudMessaging:   continue
            }
        }
        
        isUpdated = hosts != updatesHosts
    }
    
    func handle(type: HostSettingType) {
        for section in sections {
            for item in section.items {
                guard item.host.server == type.server else { continue }
                handle(item: item)
            }
        }
    }
    
    func updateHost() {
        guard let section = sections.first(where: { $0.items.first?.host.isApi ?? false }) else { return }

        for item in section.items {
            guard case .api(let server) = item.host else { return }
            switch server {
            case .custom:
                sections[item.indexPath.section].items[item.indexPath.row].isSelected = true
                sections[item.indexPath.section].items[item.indexPath.row].host = .api(.custom(customHost))
                updatesHosts.api = .api(.custom(customHost))
                
            default:
                sections[item.indexPath.section].items[item.indexPath.row].isSelected = false
            }
        }
        
        isUpdated = hosts != updatesHosts
    }
    
    func updateGodoHost() {
        guard let section = sections.first(where: { $0.items.first?.host.isGodo ?? false }) else { return }

        for item in section.items {
            guard case .godo(let server) = item.host else { return }
            switch server {
            case .custom:
                sections[item.indexPath.section].items[item.indexPath.row].isSelected = true
                sections[item.indexPath.section].items[item.indexPath.row].host = .godo(.custom(customGodoHost))
                updatesHosts.godo = .godo(.custom(customGodoHost))
                
            default:
                sections[item.indexPath.section].items[item.indexPath.row].isSelected = false
            }
        }
        
        isUpdated = hosts != updatesHosts
    }
    
    func apply() {
        hosts = updatesHosts
        
        UserDefaults.standard.setValue("https://\(hosts.api.rawValue)", forKey: ServerHostKind.api.userDefaultsKey)
        UserDefaults.standard.setValue("https://\(hosts.authentication.rawValue)", forKey: ServerHostKind.authentication.userDefaultsKey)
        UserDefaults.standard.setValue("https://\(hosts.godo.rawValue)", forKey: ServerHostKind.godo.userDefaultsKey)
        UserDefaults.standard.setValue("https://\(hosts.nowService.rawValue)", forKey: ServerHostKind.nowService.userDefaultsKey)
        UserDefaults.standard.setValue("https://\(hosts.appConfiguration.rawValue)", forKey: ServerHostKind.appConfig.userDefaultsKey)
        
        let server = hosts.eventConfiguration.server
        let value = "\(server == .production ? "https" : "http")://\(hosts.eventConfiguration.rawValue)\(server == .production ? "" : ":8080")"
        UserDefaults.standard.setValue(value, forKey: ServerHostKind.eventCollector.userDefaultsKey)
        
        Task { @CartActor in
            CartService().clear()
        }
    
        // Restart
        Task {
            await SessionManager.shared.restartApp()            
            await MainActor.run {
                 NotificationCenter.default.post(name: .restartApp, object: nil)
            }
        }
    }
    
    // MARK: Private
    private func isServerReachable() async -> Bool {
        var request = await URLRequest(httpMethod: .get, url: .memberHealth)
        request.timeoutInterval = 5

        guard let response = try? await NetworkManager.shared.request(urlRequest: request) else { return false }
        return response.statusCode == .ok
    }
}
