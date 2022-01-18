//
//  ViewController.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 21/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentedComponent: AxSegmentedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedComponent.delegate = self
        setupSegmentedComponent()
    }
    
    func setupSegmentedComponent() {
        
        segmentedComponent.set(segmentedItems: [
            ProductionSegmentedStackProtocol(named: "Produção"),
            HomologationSegmentedStackProtocol(named: "Homologação")
        ], forSelected: 1)
    }
}

// MARK: - AxSegmentedStackDelegate
extension ViewController: AxSegmentedViewDelegate {
    
    func didSelect(_ item: AxSegmentedViewDataProtocol) {
        print("\nYou chose the segment named: \(item.title)\n")
    }

}
