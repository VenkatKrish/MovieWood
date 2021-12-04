import Foundation
import UIKit
import SystemConfiguration
import Alamofire
final class NetworkReachability {
    
    static let shared = NetworkReachability()

    private let reachability = NetworkReachabilityManager(host: "www.apple.com")!

    typealias NetworkReachabilityStatus = NetworkReachabilityManager.NetworkReachabilityStatus

    private init() {}
    
    let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")

    func checkForReachability() {
        self.networkReachabilityManager?.listener = { status in
            print("Network Status: \(status)")
            switch status {
            case .notReachable:
                self.updateReachabilityStatus(.notReachable)
                break
                //Show error here (no internet connection)
            case .reachable(let connection):
                self.updateReachabilityStatus(.reachable(connection))
            case .unknown:
                self.updateReachabilityStatus(.notReachable)
                break
            }
        }

        self.networkReachabilityManager?.startListening()
    }
    /// Start observing reachability changes
//    func startListening() {
//        var status = reachability.startListening()
//
//        reachability.startListening { [weak self] status in
//            switch status {
//            case .notReachable:
//                self?.updateReachabilityStatus(.notReachable)
//            case .reachable(let connection):
//                self?.updateReachabilityStatus(.reachable(connection))
//            case .unknown:
//                break
//            }
//        }
//    }
    
    /// Stop observing reachability changes
    func stopListening() {
        reachability.stopListening()
    }
    
    
    /// Updated ReachabilityStatus status based on connectivity status
    ///
    /// - Parameter status: `NetworkReachabilityStatus` enum containing reachability status
    private func updateReachabilityStatus(_ status: NetworkReachabilityStatus) {
        switch status {
        case .notReachable:
            print("Internet not available")
        case .reachable(.ethernetOrWiFi):
            print("Internet available")
        case .unknown:
            break
        case .reachable(.wwan):
            print("Internet available")
        }
    }

    /// returns current reachability status
    var isReachable: Bool {
        return reachability.isReachable
    }

    /// returns if connected via cellular
    var isConnectedViaCellular: Bool {
        return reachability.isReachableOnWWAN
    }

    /// returns if connected via cellular
    var isConnectedViaWiFi: Bool {
        return reachability.isReachableOnEthernetOrWiFi
    }

    deinit {
        stopListening()
    }
}

