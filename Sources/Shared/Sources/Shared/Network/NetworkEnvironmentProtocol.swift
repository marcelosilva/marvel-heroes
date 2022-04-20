//
//  NetworkEnvironmentProtocol.swift
//
//
//  Created by Marcelo Silva on 20/04/22.
//
import Foundation

public protocol NetworkEnvironmentProtocol {
    var baseURL: String { get }
    var logMode: Bool { get }
    var serverTrust: Bool { get }
    var timeoutInterval: TimeInterval { get }
}
