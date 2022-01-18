//
//  SelectedState.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 18/01/22.
//

import Foundation

class SelectedState: AxSegmentedViewSelectionStateProtocol {
    
    var isSelected: Bool { true }
    
    var borderStyle: AxSegmentedViewBorderStyleProtocol { SelectedBorder() }
    
}
