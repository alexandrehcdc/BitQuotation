
import UIKit

class OptionButton: UIButton {
    
    weak var contract: OptionSelectionStackViewContract?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(teste), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelText(value: String) {
        self.setTitle(value, for: .normal)
        self.setLayout()
    }
    
    private func setLayout() {
        self.layer.cornerRadius        = 4
        self.titleLabel?.textAlignment = .center
        
        self.backgroundColor           = UIColor(red: 66/255,
                                                 green: 158/255,
                                                 blue: 245/255,
                                                 alpha: 1)
        
        self.titleLabel?.fillSuperView()
    }
    
    func switchState(selected: Bool) {
        if selected {
            self.backgroundColor = UIColor(red: 252/255,
                                           green: 148/255,
                                           blue: 3/255,
                                           alpha: 1)
        } else {
            self.backgroundColor = UIColor(red: 66/255,
                                           green: 158/255,
                                           blue: 245/255,
                                           alpha: 1)
        }
    }
    
    @objc func teste(sender: UIButton) {
        self.contract?.switchButton(tag: sender.tag)
    }
    
}
