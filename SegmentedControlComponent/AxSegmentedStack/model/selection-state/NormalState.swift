//
//  DefaultState.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 18/01/22.
//

import Foundation

class NormalState: AxSegmentedViewSelectionStateProtocol {
    
    var isSelected: Bool { false }
    
    var borderStyle: AxSegmentedViewBorderStyleProtocol { NormalBorder() }
    
}
