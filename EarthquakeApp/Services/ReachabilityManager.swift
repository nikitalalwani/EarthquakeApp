//
//  ReachabilityManager.swift
//  EarthquakeApp
//
//  Created by nikita lalwani on 9/21/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import ReachabilitySwift

/// Protocol for listenig network status change
public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}

class ReachabilityManager: NSObject {

    //Shared Instance
    static let shared = ReachabilityManager()
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
      return reachabilityStatus != .notReachable
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    var listeners = [NetworkStatusListener]()

    
    @objc func reachabilityChanged(notification: Notification) {
       let reachability = notification.object as! Reachability
       switch reachability.currentReachabilityStatus {
       case .notReachable:
        debugPrint(Strings.networkUnreachable)
       case .reachableViaWiFi:
        debugPrint(Strings.networkReachableWifi)
       case .reachableViaWWAN:
        debugPrint(Strings.networkReachableData)
     }
        
        for listener in listeners {
             listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
         }
    }
    
    @objc func checkReachability() {
       switch reachability.currentReachabilityStatus {
       case .notReachable:
        debugPrint(Strings.networkUnreachable)
       case .reachableViaWiFi:
        debugPrint(Strings.networkReachableWifi)
       case .reachableViaWWAN:
        debugPrint(Strings.networkReachableData)
     }
        
        for listener in listeners {
             listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
         }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
       NotificationCenter.default.addObserver(self,
                 selector: #selector(self.reachabilityChanged),
                     name: ReachabilityChangedNotification,
                   object: reachability)
      do{
        try reachability.startNotifier()
      } catch {
        debugPrint(Strings.reachabilityNotifier)
      }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
       reachability.stopNotifier()
       NotificationCenter.default.removeObserver(self,
                     name: ReachabilityChangedNotification,
                   object: reachability)
    }
    
    

    /// Adds a new listener to the listeners array
    ///
    /// - parameter delegate: a new listener
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
        checkReachability()
    }

    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
