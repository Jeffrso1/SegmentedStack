//
//  ProductionSegmentedStackProtocol.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 18/01/22.
//

import Foundation

class ProductionSegmentedStackProtocol: SegmentedStackProtocol {
    
    var title: String
    
    required init(named title: String) {
        self.title = title
    }
    
}
