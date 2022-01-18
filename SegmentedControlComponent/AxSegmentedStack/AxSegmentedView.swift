//
//  AxSegmentedView.swift
//  SegmentedControlComponent
//
//  Created by Jefferson Silva on 21/12/21.
//

import UIKit

class AxSegmentedView: UIView {
    // MARK: - Properties.
    private var buttonsArray = [UIButton]()
    
    weak var delegate: AxSegmentedViewDelegate?
    
    private var segmentedItems = [AxSegmentedViewDataProtocol]()
    private var defaultStyle: AxSegmentedViewStyleProtocol?
    private var selectedStyle: AxSegmentedViewStyleProtocol?
    
    var font: UIFont = UIFont.systemFont(ofSize: 14)
    
    // MARK: - Setup methods.
    func set(segmentedItems: [AxSegmentedViewDataProtocol], defaultStyle: AxSegmentedViewStyleProtocol = NormalSegment(), selectedStyle: AxSegmentedViewStyleProtocol = SelectedSegment(), forSelected index: Int = 0) {
        self.segmentedItems = segmentedItems
        self.defaultStyle = defaultStyle
        self.selectedStyle = selectedStyle
        
        setupButtonsArray(with: segmentedItems, selecting: index)
        setupStackView()
    }
    
    func set(selectedIndex: Int) {
        let selectedButton = buttonsArray[selectedIndex]
        guard !selectedButton.isSelected else { return }
        
        for button in buttonsArray {
            if button.isSelected {
                button.isSelected = false
                updateBorderStyle(for: button, with: NormalState())
                break
            }
        }
        
        selectedButton.isSelected = true
        updateBorderStyle(for: selectedButton, with: SelectedState())
        
        let segmentedProtocol = segmentedItems[selectedIndex]
        delegate?.didSelect(segmentedProtocol)
    }
    
    private func setupButtonsArray(with itemsArray: [AxSegmentedViewDataProtocol], selecting selectedIndex: Int) {
        let lastPositionIndex = itemsArray.count - 1
        
        for index in 0...lastPositionIndex {
            let currentTitle = itemsArray[index].title
            let segmentItem = UIButton(frame: CGRect.zero)
            segmentItem.addTarget(self, action: #selector(self.buttonWasClicked), for: .touchUpInside)
            
            if index == selectedIndex || (selectedIndex > lastPositionIndex && index == 0) {
                setupAppearance(for: segmentItem, named: currentTitle, selectionState: SelectedState())
            } else {
                setupAppearance(for: segmentItem, named: currentTitle, selectionState: NormalState())
            }
            
            if index == 0 {
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            }
            else if index == lastPositionIndex {
                segmentItem.layer.cornerRadius = self.frame.height / 2
                segmentItem.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            }
            
            buttonsArray.append(segmentItem)
        }
    }
    
    private func setupAppearance(for button: UIButton, named buttonTitle: String, selectionState: AxSegmentedViewSelectionStateProtocol) {
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(defaultStyle?.titleColor, for: .normal)
        button.setTitleColor(selectedStyle?.titleColor, for: .selected)
        button.setBackgroundImage(UIImage(color: defaultStyle?.backgroundColor ?? .clear), for: .normal)
        button.setBackgroundImage(UIImage(color: selectedStyle?.backgroundColor ?? .clear), for: .selected)
        button.titleLabel?.font = font
        button.clipsToBounds = true
        
        button.isSelected = selectionState.isSelected
        button.layer.borderWidth = selectionState.borderStyle.borderWidth
        button.layer.borderColor = selectionState.borderStyle.borderColor.cgColor
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
    
    private func updateBorderStyle(for sender: UIButton, with style: AxSegmentedViewSelectionStateProtocol) {
        sender.layer.borderWidth = style.borderStyle.borderWidth
        sender.layer.borderColor = style.borderStyle.borderColor.cgColor
    }
    
    // MARK: - Actions
    @objc
    func buttonWasClicked(sender: UIButton) {
        guard !sender.isSelected else { return }
        
        for button in buttonsArray {
            if button.isSelected {
                button.isSelected = false
                updateBorderStyle(for: button, with: NormalState())
                break
            }
        }
        sender.isSelected = true
        updateBorderStyle(for: sender, with: SelectedState())
        
        guard let senderIndex = buttonsArray.firstIndex(of: sender) else { return }
        let segmentedProtocol = segmentedItems[senderIndex]
        delegate?.didSelect(segmentedProtocol)
    }
}
