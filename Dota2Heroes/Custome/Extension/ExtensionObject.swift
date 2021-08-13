//
//  Extension+NSObject.swift
//  YUKK
//
//  Created by Chris Ferdian on 13/04/20.
//  Copyright © 2020 Gustaman. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

public class Debouncer: NSObject {
    public var callback: (() -> Void)
    public var delay: Double
    public weak var timer: Timer?
 
    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }
 
    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }
 
    @objc func fireNow() {
        self.callback()
    }
}
