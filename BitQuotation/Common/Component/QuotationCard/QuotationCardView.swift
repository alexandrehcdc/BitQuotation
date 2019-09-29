

import UIKit

class QuotationCardView: UIView {
    
    var statusImageView: UIImageView!
    var dayValueLabel: UILabel!
    var dayValuePercentageLabel: UILabel!
    var weekDescLabel: UILabel!
    var weekValueLabel: UILabel!
    var monthDescLabel: UILabel!
    var monthValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        
        self.statusImageView         = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.height/2, height: self.frame.height/2))
        self.dayValueLabel           = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height/2))
        self.dayValuePercentageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.height/2, height: self.frame.height/2))
        self.weekDescLabel           = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height/2))
        self.weekValueLabel          = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height/2))
        self.monthDescLabel          = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height/2))
        self.monthValueLabel         = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/4, height: self.frame.height/2))
        
        let upperContainer = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2))
        let lowerContainer = UIStackView(frame: CGRect(x: 0, y: self.frame.midY, width: self.frame.width, height: self.frame.height/2))
        
        upperContainer.addArrangedSubviews(views: statusImageView,
                                           dayValueLabel,
                                           dayValuePercentageLabel)
        
        lowerContainer.addArrangedSubviews(views: weekDescLabel,
                                           weekValueLabel,
                                           monthDescLabel,
                                           monthValueLabel)
        
        upperContainer.distribution = .fillProportionally
        lowerContainer.distribution = .fillProportionally
        
        self.addSubviews(upperContainer, lowerContainer)
        
        upperContainer.anchor(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                              size: CGSize(width: self.frame.width, height: self.frame.height/2))
        
        lowerContainer.anchor(top: upperContainer.bottomAnchor,
                              leading: self.leadingAnchor,
                              bottom: self.bottomAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                              size: CGSize(width: self.frame.width, height: self.frame.height/2))
        
        setComponents()
    }
    
    private func setComponents() {
        self.statusImageView.backgroundColor = .yellow
        self.dayValueLabel.backgroundColor = .green
        self.dayValuePercentageLabel.backgroundColor = .white
        self.weekDescLabel.backgroundColor = .purple
        self.weekValueLabel.backgroundColor = .orange
        self.monthDescLabel.backgroundColor = .cyan
        self.monthValueLabel.backgroundColor = .black
    }
    
}
