import Charts

class QuotationViewController: UIViewController {
    
    lazy var presenter: QuotationPresenter = { [unowned self] in
        return QuotationPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.presenter.loadMainQuotation()
        
        let stackview = OptionSelectionStackView(frame: CGRect(x: 0, y: 560, width: self.view.frame.width - 16, height: 40))
        
        self.view.addSubview(stackview)
        
        stackview.set(descriptions: ["3 Meses", "12 Meses", "24 Meses"])
        
        stackview.anchor(top: nil, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
    }

}

extension QuotationViewController: QuotationViewContract {
    
    func mountGraphWith(transaction: Transaction) {
        
        DispatchQueue.main.sync { [unowned self] in
            let chartView = LineChartView(frame: CGRect(x: 16,
                                                        y: 16,
                                                        width: self.view.frame.width - 16,
                                                        height: self.view.frame.height * 6/8))
            
            self.view.addSubview(chartView)
            
            let values = transaction.values.map { ChartDataEntry(x: Double($0.x), y: $0.y) }
            
            let set           = LineChartDataSet(entries: values,
                                                 label: "To do - fix label"),
                data          = LineChartData(dataSet: set),
                dateFormatter = DateFormatter(),
                axisFormatter = AxisFormatter()
            
            dateFormatter.dateFormat       = "MMM yy"
            dateFormatter.locale           = Locale.current
            
            axisFormatter.dateFormatter    = dateFormatter
            
            chartView.data                 = data
            chartView.xAxis.valueFormatter = axisFormatter
            
            chartView.xAxis.labelTextColor = .white
            chartView.xAxis.axisLineColor  = .white
            
            chartView.leftAxis.labelTextColor = .white
            chartView.legend.textColor = .white
            chartView.legend.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
}


