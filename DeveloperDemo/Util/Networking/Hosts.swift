//
//  Hosts.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

var hosts = Hosts() {

    didSet {
        guard let data = try? JSONEncoder().encode(hosts) else { return }
        UserDefaults.standard.setValue(data, forKey: "hosts")
    }
}

struct Hosts {
    var api: Host = .api(.production)
    var authentication: Host = .authentication(.development(.none))
    var godo: Host = .godo(.production)
    var backOffice: Host = .backOffice(.stage(.none))
    var commerce: Host = .commerce(.stage(.none))
    var nowService: Host = .nowService(.production)
    var appConfiguration: Host = .appConfiguration(.production)
    var eventConfiguration: Host = .eventConfiguration(.production)
}

extension Hosts {
    
    mutating func synchronize() {
        api = Host(url: ServerHostKind.api.currentHostURL) ?? .api(.production)
        authentication = Host(url: ServerHostKind.authentication.currentHostURL) ?? .authentication(.production)
        godo = Host(url: ServerHostKind.godo.currentHostURL) ?? .godo(.production)
        nowService = Host(url: ServerHostKind.nowService.currentHostURL) ?? .nowService(.production)
        appConfiguration = Host(url: ServerHostKind.appConfig.currentHostURL) ?? .appConfiguration(.production)
        eventConfiguration = Host(url: ServerHostKind.eventCollector.currentHostURL) ?? .eventConfiguration(.production)
        
        update()
    }
    
    private mutating func update() {
        guard let data = UserDefaults.standard.data(forKey: "hosts"), let decodedData = try? JSONDecoder().decode(Hosts.self, from: data) else {
            let server = api.server == .production ? .stage(.none) : api.server
            backOffice = .backOffice(server)
            commerce = .commerce(server)
            return
        }
        
        backOffice = decodedData.backOffice
        commerce = decodedData.commerce
    }
}

extension Hosts: Codable {
    
    private enum Key: String, CodingKey {
        case api
        case authentication
        case front
        case godo
        case backOffice
        case commerce
        case marketing
        case nowService
        case appConfiguration
        case eventConfiguration
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(api, forKey: .api) } catch { throw error }
        do { try container.encode(authentication, forKey: .authentication) } catch { throw error }
        do { try container.encode(godo, forKey: .godo) } catch { throw error }
        do { try container.encode(backOffice, forKey: .backOffice) } catch { throw error }
        do { try container.encode(commerce, forKey: .commerce) } catch { throw error }
        do { try container.encode(nowService, forKey: .nowService) } catch { throw error }
        do { try container.encode(appConfiguration, forKey: .appConfiguration) } catch { throw error }
        do { try container.encode(eventConfiguration, forKey: .eventConfiguration) } catch { throw error }
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
    
        do { api = try container.decode(Host.self, forKey: .api) } catch { api = .api(.production) }
        do { authentication = try container.decode(Host.self, forKey: .authentication) } catch { authentication = .authentication(.production) }
        do { godo = try container.decode(Host.self, forKey: .godo) } catch { godo = .godo(.production) }
        do { backOffice = try container.decode(Host.self, forKey: .backOffice) } catch { backOffice = .backOffice(.production) }
        do { commerce = try container.decode(Host.self, forKey: .commerce) } catch { commerce = .commerce(.production) }
        do { nowService = try container.decode(Host.self, forKey: .nowService) } catch { nowService = .nowService(.production) }
        do { appConfiguration = try container.decode(Host.self, forKey: .appConfiguration) } catch { appConfiguration = .appConfiguration(.production) }
        do { eventConfiguration = try container.decode(Host.self, forKey: .eventConfiguration) } catch { eventConfiguration = .eventConfiguration(.production) }
    }
}

extension Hosts: RawRepresentable {
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|")
        
        guard components.count == 8 else { return nil }
        api = Host(rawValue: components[0]) ?? .api(.production)
        authentication = Host(rawValue: components[1]) ?? .authentication(.production)
        godo = Host(rawValue: components[2]) ?? .godo(.production)
        backOffice = Host(rawValue: components[3]) ?? .backOffice(.stage(.none))
        commerce = Host(rawValue: components[4]) ?? .commerce(.stage(.none))
        nowService = Host(rawValue: components[5]) ?? .nowService(.production)
        appConfiguration = Host(rawValue: components[6]) ?? .appConfiguration(.production)
        eventConfiguration = Host(rawValue: components[7]) ?? .eventConfiguration(.production)
    }
    
    var rawValue: String {
        "\(api.rawValue)|\(authentication.rawValue)|\(godo.rawValue)|\(backOffice.rawValue)|\(commerce.rawValue)|\(nowService.rawValue)|\(appConfiguration.rawValue)|\(eventConfiguration.rawValue)"
    }
}

extension Hosts: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension Hosts: Equatable {
    
    static func == (lhs: Hosts, rhs: Hosts) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
