//
//  ESPTouchError.swift
//  ESPTouch
//
//  Created by jowsing on 2020/6/20.
//

import Foundation

public enum ESPTouchError: Error {
    case noSsid // 没有连接wifi
    case timeout // 超时
}
