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
        // Do any additional setup after loading the view.
        
        setupSegmentedComponent()
    }
    
    func setupSegmentedComponent() {
        segmentedComponent.segmentTitles = ["Produção", "Homologação", "Teste", "Outro Teste"]
        segmentedComponent.setupSegments()
    }
    
}

