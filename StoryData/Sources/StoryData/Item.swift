//
//  Item.swift
//  Stories
//
//  Created by Michael Thole on 11/24/24.
//

import Foundation
import SwiftData

@Model
public final class Item {
    public var timestamp: Date = Date.distantPast
    
    public init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
