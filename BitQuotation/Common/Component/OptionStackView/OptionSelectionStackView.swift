
import UIKit

class OptionSelectionStackView : UIStackView {
    
    weak var contract: QuotationViewContract?
    
    private var buttons: [OptionButton] = []
    
    private var descriptions: [String]  = [] {
        didSet {
            setButtonsBy(descriptions: self.descriptions)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonsBy(descriptions: [String]) {
        
        var optionButtons: [OptionButton] = []
        
        for (index, description) in self.descriptions.enumerated() {
            let button = OptionButton(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: (self.frame.width / CGFloat(self.descriptions.count)) - 3,
                                                    height: self.frame.height))
            
            let value = description.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            button.setLabelText(value: description, propertyValue: Int(value) ?? 0)
            
            button.tag      = index
            button.contract = self
            
            optionButtons.append(button)
        }
        
        self.buttons = optionButtons
        
        layButtons()
    }
    
    private func layButtons() {
        for button in self.buttons {
            self.addArrangedSubview(button)
        }
        
        self.spacing      = 3
        self.distribution = .fillEqually
        self.axis         = .horizontal
    }
    
    func set(descriptions: [String]) {
        self.descriptions = descriptions
    }
    
}

extension OptionSelectionStackView: OptionSelectionStackViewContract {
    
    func switchButton(tag: Int) {
        self.contract?.startLoading()
        
        for button in self.buttons {
            let isButtonSelected = button.tag == tag

            button.switchState(selected: isButtonSelected)
        }
        
        self.contract?.redraw(with: TimeEnum(rawValue: self.buttons[tag].propertyValue) ?? .year)
    }
    
}
