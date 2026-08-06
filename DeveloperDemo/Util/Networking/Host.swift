//
//  Host.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum Host {
    case api(Server)
    case authentication(Server)
    case godo(Server)
    case backOffice(Server)
    case commerce(Server)
    case nowService(Server)
    case appConfiguration(Server)
    case eventConfiguration(Server)
    case googleDeveloper
    case googleAccount
    case googleAPI
    case firebaseCloudMessaging
}

extension Host {
    
    var url: URL {
        URL(string: rawValue)!
    }
    
    var type: String {
        switch self {
        case .api:                      "API"
        case .authentication:           "Authentication"
        case .godo:                     "GODO"
        case .backOffice:               "BackOffice"
        case .commerce:                 "Commerce"
        case .nowService:                 "Now"
        case .appConfiguration:         "App Configuration"
        case .eventConfiguration:       "Event Configuration"
        case .googleDeveloper:          "Google Developer"
        case .googleAccount:            "Google Account"
        case .googleAPI:                "Google API"
        case .firebaseCloudMessaging:   "Firebase Cloud Messaging"
        }
    }

    var server: Server {
    #if DEBUG || BETA
        switch self {
        case .api(let server):                  server
        case .authentication(let server):       server
        case .godo(let server):                 server
        case .backOffice(let server):           server
        case .commerce(let server):             server
        case .nowService(let server):             server
        case .appConfiguration(let server):     server
        case .eventConfiguration(let server):   server
        case .googleDeveloper:                  .production
        case .googleAccount:                    .production
        case .googleAPI:                        .production
        case .firebaseCloudMessaging:           .production
        }
        
    #else
        return .production
    #endif
    }
    
    var isApi: Bool {
        switch self {
        case .api:  return true
        default:    return false
        }
    }
    
    var isGodo: Bool {
        switch self {
        case .godo: return true
        default:    return false
        }
    }
}

extension Host: RawRepresentable {
    
    init?(url: URL?) {
        guard let url, let host = URLComponents(url: url, resolvingAgainstBaseURL: false)?.host else { return nil }
        self.init(rawValue: host)
    }

    init?(rawValue: String) {
        switch rawValue {
        #if DEBUG || BETA
        // API
        case Self.api(.development(.none)).rawValue:                        self = .api(.development(.none))
        case Self.api(.stage(.none)).rawValue:                              self = .api(.stage(.none))
        case Self.api(.perf).rawValue:                                      self = .api(.perf)
        case Self.api(.production).rawValue:                                self = .api(.production)
        case let host where host.contains("api"):                           self = .api(.custom(host))
       
        // Authentication
        case Self.authentication(.development(.none)).rawValue:             self = .authentication(.development(.none))
        case Self.authentication(.stage(.none)).rawValue:                   self = .authentication(.stage(.none))
        case Self.authentication(.perf).rawValue:                           self = .authentication(.perf)
        case Self.authentication(.production).rawValue:                     self = .authentication(.production)
            
        case let host where host.contains("auth"):                          self = .authentication(.custom(host))
            
        // GODO
        case Self.godo(.development(.none)).rawValue:                       self = .godo(.development(.none))
        case Self.godo(.development(.qa1)).rawValue:                        self = .godo(.development(.qa1))
        case Self.godo(.development(.qa2)).rawValue:                        self = .godo(.development(.qa2))
        case Self.godo(.development(.qa3)).rawValue:                        self = .godo(.development(.qa3))
        case Self.godo(.development(.qa4)).rawValue:                        self = .godo(.development(.qa4))
        case Self.godo(.development(.qa5)).rawValue:                        self = .godo(.development(.qa5))
        case Self.godo(.stage(.none)).rawValue:                             self = .godo(.stage(.none))
        case Self.godo(.stage(.qa1)).rawValue:                              self = .godo(.stage(.qa1))
        case Self.godo(.stage(.qa2)).rawValue:                              self = .godo(.stage(.qa2))
        case Self.godo(.stage(.qa3)).rawValue:                              self = .godo(.stage(.qa3))
        case Self.godo(.stage(.qa4)).rawValue:                              self = .godo(.stage(.qa4))
        case Self.godo(.stage(.qa5)).rawValue:                              self = .godo(.stage(.qa5))
        case Self.godo(.perf).rawValue:                                     self = .godo(.perf)
        case Self.godo(.production).rawValue:                               self = .godo(.production)
        case let host where host.contains("www"):                           self = .godo(.custom(host))
                    
        // BackOffice
        case Self.backOffice(.development(.none)).rawValue:                 self = .backOffice(.development(.none))
        case Self.backOffice(.stage(.none)).rawValue:                       self = .backOffice(.stage(.none))
        
            
        // Commerce
        case Self.commerce(.development(.none)).rawValue:                   self = .commerce(.development(.none))
        case Self.commerce(.stage(.none)).rawValue:                         self = .commerce(.stage(.none))
        
        // NowService
        case Self.nowService(.development(.none)).rawValue:                   self = .nowService(.development(.none))
        case Self.nowService(.stage(.none)).rawValue:                         self = .nowService(.stage(.none))
        case Self.nowService(.stage(.qa1)).rawValue:                          self = .nowService(.stage(.qa1))
        case Self.nowService(.stage(.qa2)).rawValue:                          self = .nowService(.stage(.qa2))
        case Self.nowService(.stage(.qa3)).rawValue:                          self = .nowService(.stage(.qa3))
        case Self.nowService(.stage(.qa4)).rawValue:                          self = .nowService(.stage(.qa4))
        case Self.nowService(.stage(.qa5)).rawValue:                          self = .nowService(.stage(.qa5))
        case Self.nowService(.perf).rawValue:                                 self = .nowService(.perf)        
        case Self.nowService(.production).rawValue:                           self = .nowService(.production)
            
        // App Configuration
        case Self.appConfiguration(.development(.none)).rawValue:           self = .appConfiguration(.development(.none))
        case Self.appConfiguration(.stage(.none)).rawValue:                 self = .appConfiguration(.stage(.none))
        case Self.appConfiguration(.production).rawValue:                   self = .appConfiguration(.production)
            
            
        // Event Configuration
        case Self.eventConfiguration(.development(.none)).rawValue:         self = .eventConfiguration(.development(.none))
        case Self.eventConfiguration(.stage(.none)).rawValue:               self = .eventConfiguration(.stage(.none))
        case Self.eventConfiguration(.production).rawValue:                 self = .eventConfiguration(.production)
            
            
        // Google
        case Self.googleDeveloper.rawValue:                                 self = .googleDeveloper
        case Self.googleAccount.rawValue:                                   self = .googleAccount
        case Self.googleAPI.rawValue:                                       self = .googleAPI
        case Self.firebaseCloudMessaging.rawValue:                          self = .firebaseCloudMessaging
            
            
        default:                                                            return nil
            
        #else
        case let rawValue where rawValue.contains("api"):                   self = .api(.production)
        case let rawValue where rawValue.contains("gateway.cloud"):         self = .backOffice(.production)
        case let rawValue where rawValue.contains("commerce-message"):      self = .commerce(.production)
        case let rawValue where rawValue.contains("moderate"):              self = .appConfiguration(.production)
        case let rawValue where rawValue.contains("kafka-proxy"):           self = .eventConfiguration(.production)
        default:                                                            return nil
        #endif
        }
    }
    
    var rawValue: String {
        switch self {
        case .api(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "api.dev.example.com"
            case .stage(.none):                         return "api.stg.example.com"
            case .perf:                                 return "api.perf.example.com"
            case .custom(let host):                     return host
            case .production:                           return "api.example.com"
            default:                                    return "api.example.com"
                
            #else
            default:                                    return "api.example.com"
            #endif
            }
            
        case .authentication(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "auth.dev.example.com"
            case .stage(.none):                         return "auth.stg.example.com"
            case .perf:                                 return "auth.perf.example.com"
            case .production:                           return "auth.example.com"
            default:                                    return "auth.example.com"
                
            #else
            default:                                    return "auth.example.com"
            #endif
            }
            
        case .godo(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "www.dev.example.com"
            case .development(.qa1):                    return "www-qa1.dev.example.com"
            case .development(.qa2):                    return "www-qa2.dev.example.com"
            case .development(.qa3):                    return "www-qa3.dev.example.com"
            case .development(.qa4):                    return "www-qa4.dev.example.com"
            case .development(.qa5):                    return "www-qa5.dev.example.com"
            case .stage(.none):                         return "www.stg.example.com"
            case .stage(.qa1):                          return "www-qa1.stg.example.com"
            case .stage(.qa2):                          return "www-qa2.stg.example.com"
            case .stage(.qa3):                          return "www-qa3.stg.example.com"
            case .stage(.qa4):                          return "www-qa4.stg.example.com"
            case .stage(.qa5):                          return "www-qa5.stg.example.com"
            case .custom(let host):                     return host
            case .perf:                                 return "www.perf.example.com"
            case .production:                           return "www.example.com"
            default:                                    return ""
                
            #else
            default:                                    return "www.example.com"
            #endif
            }
            
        case .backOffice(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "gateway.cloud.dev.example.net"
            case .stage(.none):                         return "gateway.cloud.stg.example.net"
            case .production:                           return ""
            default:                                    return ""
            
            #else
            default:                                    return ""
            #endif
            }
            
        case .nowService(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "now.dev.example.com"
            case .stage(.none):                         return "now.stg.example.com"
            case .stage(.qa1):                          return "now-qa1.stg.example.com"
            case .stage(.qa2):                          return "now-qa2.stg.example.com"
            case .stage(.qa3):                          return "now-qa3.stg.example.com"
            case .stage(.qa4):                          return "now-qa4.stg.example.com"
            case .stage(.qa5):                          return "now-qa5.stg.example.com"
            case .perf:                                 return "now.perf.example.com"
            case .production:                           return "now.example.com"
            default:                                    return ""
                
            #else
            default:                                    return "now.example.com"
            #endif
            }
        case .commerce(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "commerce-message.dev.example.net"
            case .stage(.none):                         return "commerce-message.stg.example.net"
            case .production:                           return ""
            default:                                    return ""
                
            #else
            default:                                    return ""
            #endif
            }
            
        case .appConfiguration(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "moderate.dev.example.com"
            case .stage(.none):                         return "moderate.stg.example.com"
            case .production:                           return "moderate.example.com"
            default:                                    return ""
                
            #else
            default:                                    return ""
            #endif
            }
            
        case .eventConfiguration(let server):
            switch server {
            #if DEBUG || BETA
            case .development(.none):                   return "kafka-proxy.dev.example.net"
            case .stage(.none):                         return "kafka-proxy.stg.example.net"
            case .production:                           return "kafka-proxy.example.net"
            default:                                    return ""
                
            #else
            case .production:                           return "kafka-proxy.example.net"
            default:                                    return ""
            #endif
            }
            
        case .googleDeveloper:
            #if DEBUG || BETA
            return "developers.google.com"
            
            #else
            return ""
            #endif
            
        case .googleAccount:
            #if DEBUG || BETA
            return "accounts.google.com"
            
            #else
            return ""
            #endif
            
        case .googleAPI:
            #if DEBUG || BETA
            return "www.googleapis.com"
            
            #else
            return ""
            #endif
            
        case .firebaseCloudMessaging:
            #if DEBUG || BETA
            return "fcm.googleapis.com"
            
            #else
            return ""
            #endif
        }
    }
}

extension Host: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension Host: Equatable {
    
    static func == (lhs: Host, rhs: Host) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension Host: CaseIterable {
    
    static var allCases: [Host] {
        [.api(.development(.none)), .api(.stage(.none)), .api(.perf), .api(.custom("api.custom.example.com")), .api(.production),
         
         .authentication(.development(.none)), .authentication(.stage(.none)), .authentication(.perf), .authentication(.production),
         
         .godo(.development(.none)), .godo(.development(.qa1)), .godo(.development(.qa2)), .godo(.development(.qa3)), .godo(.development(.qa4)), .godo(.development(.qa5)),
         .godo(.stage(.none)), .godo(.stage(.qa1)), .godo(.stage(.qa2)), .godo(.stage(.qa3)), .godo(.stage(.qa4)), .godo(.stage(.qa5)),
         .godo(.perf), .godo(.custom("www-custom.stg.example.com")),
         .godo(.production),
         
         .backOffice(.development(.none)), .backOffice(.stage(.none)),
         
         .commerce(.development(.none)), .commerce(.stage(.none)),
         
         .nowService(.development(.none)), 
         .nowService(.stage(.none)), .nowService(.stage(.qa1)), .nowService(.stage(.qa2)), .nowService(.stage(.qa3)), .nowService(.stage(.qa4)), .nowService(.stage(.qa5)),
         .nowService(.perf),         
         .nowService(.production),
         
         .appConfiguration(.development(.none)), .appConfiguration(.stage(.none)), .appConfiguration(.production),
         
         .eventConfiguration(.development(.none)), .eventConfiguration(.stage(.none)), .eventConfiguration(.production)]
    }
}

extension Host: Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        do { try container.encode(rawValue) } catch { throw error }
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            guard let host = Host(rawValue: try container.decode(String.self)) else {
                throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to decode host data."))
            }
            
            self = host
            
        } catch { throw error }
    }
}
