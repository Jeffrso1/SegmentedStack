//
//  AxSegmentedStack.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 21/12/21.
//

import UIKit

class AxSegmentedStack: UIView {
    // MARK: - Properties.
    fileprivate var buttonsArray = [UIButton]()
    fileprivate var selectedButton: UIButton?
    
    var segmentTitles = [String]()
    
    var font: UIFont = UIFont.systemFont(ofSize: 14)
    
    var defaultBorderWidth: CGFloat = 1
    var defaultBorderColor: UIColor = .lightGray
    var defaultTitleColor: UIColor = .lightGray
    var defaultBackgroundColor: UIColor = .clear
    
    var selectedBorderWidth: CGFloat = 1
    var selectedBorderColor: UIColor = .red
    var selectedTitleColor: UIColor = .red
    var selectedBackgroundColor: UIColor = .blue.withAlphaComponent(0.2)
    
    // MARK: - Setup functions.
    func setupSegments() {
        setupButtonsArray(with: segmentTitles)
        setupStackView()
    }
    
    func setupButtonsArray(with titlesArray: [String]) {
        let arrayLenght = titlesArray.count
        
        for index in 0..<arrayLenght {
            let currentTitle = titlesArray[index]
            let segmentItem = UIButton(frame: CGRect.zero)
            segmentItem.addTarget(self, action: #selector(self.buttonWasClicked), for: .touchUpInside)
            
            if index == 0 {
                setupAppearance(for: segmentItem, named: currentTitle, .Selected)
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
                buttonsArray.append(segmentItem)
                continue
            }
            else if index == arrayLenght - 1 {
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            }
            
            setupAppearance(for: segmentItem, named: currentTitle, .NotSelected)
            buttonsArray.append(segmentItem)
        }
    }
    
    func setupAppearance(for button: UIButton, named buttonTitle: String, _ selectionState: SelectionState) {
        
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(defaultTitleColor, for: .normal)
        button.setTitleColor(selectedTitleColor, for: .selected)
        button.setBackgroundImage(UIImage(color: defaultBackgroundColor), for: .normal)
        button.setBackgroundImage(UIImage(color: selectedBackgroundColor), for: .selected)
        button.titleLabel?.font = font
        button.clipsToBounds = true
        
        switch selectionState {
        case .Selected:
            button.isSelected = true
            button.layer.borderWidth = selectedBorderWidth
            button.layer.borderColor = selectedBorderColor.cgColor
            
        case .NotSelected:
            button.layer.borderWidth = defaultBorderWidth
            button.layer.borderColor = defaultBorderColor.cgColor
            
        }
    }
    
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: buttonsArray)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc
    func buttonWasClicked(sender: UIButton) {
        guard !sender.isSelected else { return }
        
        for button in buttonsArray {
            if button.isSelected {
                button.isSelected = false
                button.layer.borderColor = defaultBorderColor.cgColor
                break
            }
        }
        
        sender.isSelected = true
        sender.layer.borderColor = selectedBorderColor.cgColor
    }
}
