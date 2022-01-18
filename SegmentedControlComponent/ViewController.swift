//
//  ViewController.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 21/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentedComponent: AxSegmentedStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedComponent.delegate = self
        setupSegmentedComponent()
    }
    
    func setupSegmentedComponent() {
        segmentedComponent.segmentTitles = [
            ProductionSegmentedStackProtocol(named: "Produção"),
            HomologationSegmentedStackProtocol(named: "Homologação")
        ]
        
        segmentedComponent.setupSegments(forSelected: 4)
    }
}

// MARK: - AxSegmentedStackDelegate
extension ViewController: AxSegmentedStackDelegate {
    
    func didSelect(_ item: SegmentedStackProtocol) {
        print("\nYou chose the segment named: \(item.title)\n")
    }

}
