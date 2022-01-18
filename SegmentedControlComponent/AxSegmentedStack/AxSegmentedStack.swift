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
    
    weak var delegate: AxSegmentedStackDelegate?
    
    var segmentTitles = [SegmentedStackProtocol]()
    
    var font: UIFont = UIFont.systemFont(ofSize: 14)
    
    var defaultBorderWidth: CGFloat = 1
    var defaultBorderColor: UIColor = .lightGray
    var defaultTitleColor: UIColor = .lightGray
    var defaultBackgroundColor: UIColor = .clear
    
    var selectedBorderWidth: CGFloat = 1
    var selectedBorderColor: UIColor = .red
    var selectedTitleColor: UIColor = .red
    var selectedBackgroundColor: UIColor = .blue.withAlphaComponent(0.2)
    
    // MARK: - Setup methods.
    func setupSegments(forSelected index: Int = 0) {
        setupButtonsArray(with: segmentTitles, selecting: index)
        setupStackView()
    }
    
    private func setupButtonsArray(with itemsArray: [SegmentedStackProtocol], selecting selectedIndex: Int) {
        let lastIndex = itemsArray.count - 1
        
        for index in 0...lastIndex {
            let currentTitle = itemsArray[index].title
            let segmentItem = UIButton(frame: CGRect.zero)
            segmentItem.addTarget(self, action: #selector(self.buttonWasClicked), for: .touchUpInside)
            
            if index == selectedIndex || (selectedIndex > lastIndex && index == 0) {
                setupAppearance(for: segmentItem, named: currentTitle, .Selected)
            } else {
                setupAppearance(for: segmentItem, named: currentTitle, .NotSelected)
            }
            
            if index == 0 {
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            }
            else if index == lastIndex {
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            }
            
            buttonsArray.append(segmentItem)
        }
    }
    
    private func setupAppearance(for button: UIButton, named buttonTitle: String, _ selectionState: SelectionState) {
        
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
    
    private func setupStackView() {
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
        
        guard let senderIndex = buttonsArray.firstIndex(of: sender) else { return }
        let segmentedProtocol = segmentTitles[senderIndex]
        delegate?.didSelect(segmentedProtocol)
    }
}
