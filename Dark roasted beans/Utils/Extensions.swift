//
//  Extensions.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 09/11/2021.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
