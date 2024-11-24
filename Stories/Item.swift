//
//  Item.swift
//  Stories
//
//  Created by Michael Thole on 11/24/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
