//
//  ESPTouch.swift
//  ESPTouch
//
//  Created by jowsing on 2020/6/20.
//

import Foundation

public class ESPTouchManager: NSObject {
    
    // MARK: - Properties (public)
    
    public var timeout: TimeInterval = 60
    
    
    // MARK: - Properties (private)
    
    private var task: ESPTouchTask?
    private let condition = NSCondition()
    
    
    // MARK: - SmartConfig
    
    private func execute(_ ssid: String, bssid: String, password: String, taskCount: Int, broadcast: Bool) -> [ESPTouchResult] {
        self.condition.lock()
        self.task = ESPTouchTask(apSsid: ssid, andApBssid: bssid, andApPwd: password)
        self.task?.setPackageBroadcast(broadcast)
        self.condition.unlock()
        guard let results = self.task?.execute(forResults: Int32(taskCount)) as? [ESPTouchResult] else {
            return []
        }
        return results
    }
    
    public func smartConfig(password: String, response: ((Result<ESPTouchResult, ESPTouchError>) -> Void)?) {
        let dispatchQueue = DispatchQueue.global(qos: .default)
        var isCompletion = false
        dispatchQueue.async {
            guard let ssid = ESPTools.getCurrentWiFiSsid(),
                let bssid = ESPTools.getCurrentBSSID()
            else {
                isCompletion = true
                response?(.failure(.noSsid))
                return
            }
            let results = self.execute(ssid, bssid: bssid, password: password, taskCount: 1, broadcast: true)
            if let result = results.first, (result.bssid ?? "").count > 0 {
                isCompletion = true
                response?(.success(result))
            }
        }
        dispatchQueue.asyncAfter(deadline: .now() + timeout) {
            guard !isCompletion else { return }
            self.cancel()
            response?(.failure(.timeout))
        }
    }
    
    public func cancel() {
        self.condition.lock()
        if let task = self.task {
            task.interrupt()
        }
        self.condition.unlock()
    }
    
}
