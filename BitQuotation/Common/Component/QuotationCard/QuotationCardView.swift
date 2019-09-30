
import UIKit

class QuotationCardView: UIView {
    
    var statusImageView: UIImageView!
    var dayValueLabel: UILabel!
    var dayValuePercentageLabel: UILabel!
    var weekDescLabel: UILabel!
    var weekValueLabel: UILabel!
    var monthDescLabel: UILabel!
    var monthValueLabel: UILabel!
    
    let gray = UIColor(red: 151/255, green: 155/255, blue: 161/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setCardLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTransactionValues(transaction: Transaction) {
        let quotations    = transaction.values.reversed()
        let previousValue = Array(quotations)[1]
        let currentValue  = quotations.first
        let weekValues    = quotations.prefix(7)
        let monthValues   = quotations.prefix(30)
        
        guard let dailyValue = currentValue else { return }
        
        var weekAmount  = 0.0
        var monthAmount = 0.0
        
        for value in Array(weekValues) {
            weekAmount += value.y
        }
        
        for value in Array(monthValues) {
            monthAmount += value.y
        }
        
        let dailyQuotationPercentage = (dailyValue.y - previousValue.y) * 100 / previousValue.y
        let weekQuotationPercentage  = (dailyValue.y - (weekAmount / Double(weekValues.count))) * 100 / previousValue.y
        let monthQuotationPercentage = (dailyValue.y - (weekAmount / Double(weekValues.count))) * 100 / previousValue.y
        
        setValues(dailyValue: dailyValue.y,
                  dailyPercentage: dailyQuotationPercentage,
                  weekPercentage: weekQuotationPercentage,
                  monthPercentage: monthQuotationPercentage)
    }
    
    private func setCardLayout() {
        self.layer.cornerRadius = 5
        self.backgroundColor    = gray
    }
    
    private func setLayout() {
        
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
        
        upperContainer.distribution = .equalCentering
        lowerContainer.distribution = .fillProportionally
        
        self.addSubviews(upperContainer, lowerContainer)
        
        upperContainer.anchor(top: self.topAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                              size: CGSize(width: self.frame.width, height: self.frame.height/2))
        
        lowerContainer.anchor(top: upperContainer.bottomAnchor,
                              leading: self.leadingAnchor,
                              bottom: self.bottomAnchor,
                              trailing: self.trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                              size: CGSize(width: self.frame.width, height: self.frame.height/2))
    }
    
    private func setValues(dailyValue: Double, dailyPercentage: Double, weekPercentage: Double, monthPercentage: Double) {
        
        self.statusImageView.image       = UIImage.arrow.withRenderingMode(.alwaysTemplate)
        self.statusImageView.contentMode = .scaleAspectFit
        
        if !isValueNegative(value: dailyPercentage) {
            self.statusImageView.tintColor         = .green
            self.dayValuePercentageLabel.text      = "\(String(format: "%.2f", dailyPercentage))%"
            self.dayValuePercentageLabel.textColor = .green
        } else {
            self.statusImageView.transform         = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.statusImageView.tintColor         = .red
            self.dayValuePercentageLabel.textColor = .red
            self.dayValuePercentageLabel.text      = "-\(String(format: "%.2f", dailyPercentage))%"
        }
        
        self.statusImageView.anchor(size: CGSize(width: (self.frame.height/2) - 8,
                                                 height: (self.frame.height/2) - 8))
        
        self.dayValueLabel.text   = " \(AppStrings.currency_dollar_abbr) \(String(format: "%.2f", dailyValue))"
        self.weekDescLabel.text   = "\(AppStrings.date_units_week.capitalized):"
        self.weekValueLabel.text  = "\(String(format: "%.2f", weekPercentage))%"
        self.monthDescLabel.text  = "\(AppStrings.date_units_month.capitalized):"
        self.monthValueLabel.text = "\(String(format: "%.2f", monthPercentage))%"
        
        self.backgroundColor = .white
    }
    
    private func isValueNegative(value: Double) -> Bool {
        return value < 0 ? true : false
    }
    
}
