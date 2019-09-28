import Charts

class QuotationViewController: UIViewController {
    
    lazy var presenter: QuotationPresenter = { [unowned self] in
        return QuotationPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackview = OptionSelectionStackView(frame: CGRect(x: 0, y: 560, width: self.view.frame.width - 16, height: 40))
        stackview.set(descriptions: ["1 Mês", "6 Mês", "12 Mês"])
        
        self.view.addSubview(stackview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.presenter.loadMainQuotation()
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


