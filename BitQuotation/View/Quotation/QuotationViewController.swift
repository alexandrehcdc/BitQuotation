import Charts

class QuotationViewController: UIViewController {
    
    var chartView: LineChartView!
    
    lazy var presenter: QuotationPresenter = { [unowned self] in
        return QuotationPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loadMainQuotation(period: .year)
    }
    
    deinit {
        self.chartView = nil
    }

}

extension QuotationViewController: QuotationViewContract {
    
    func redraw(with period: TimeEnum) {
        self.chartView.notifyDataSetChanged()

        self.presenter.loadMainQuotation(period: period)
    }
    
    func mountGraphWith(transaction: Transaction, period: Int) {
        
        DispatchQueue.main.async { [unowned self] in
            self.chartView = LineChartView(frame: CGRect(x: 16,
                                                         y: 16,
                                                         width: self.view.frame.width - 16,
                                                         height: self.view.frame.height * 6/8))
            
            self.view.addSubview(self.chartView)
            
            var values: [ChartDataEntry] = []
            
            for (index,value) in transaction.values.enumerated() {
                if index == (period - 1) { break }
                values.append(ChartDataEntry(x: Double(value.x), y: value.y))
            }
            
            let set           = LineChartDataSet(entries: values,
                                                 label: "To do - fix label"),
                data          = LineChartData(dataSet: set),
                dateFormatter = DateFormatter(),
                axisFormatter = AxisFormatter()
            
            dateFormatter.dateFormat = "dd MMM yy"
            dateFormatter.locale     = Locale.current
            
            axisFormatter.dateFormatter = dateFormatter
            
            self.chartView.data                    = data
            self.chartView.xAxis.valueFormatter    = axisFormatter
            self.chartView.legend.font             = UIFont.systemFont(ofSize: 16)
            self.chartView.xAxis.labelTextColor    = .white
            self.chartView.xAxis.axisLineColor     = .white
            self.chartView.leftAxis.labelTextColor = .white
            self.chartView.legend.textColor        = .white
            
            
            set.valueTextColor = UIColor(red: 150/255, green: 255/255, blue: 173/255, alpha: 1)
            set.circleColors = [UIColor(red: 150/255, green: 255/255, blue: 173/255, alpha: 1)]
            set.colors       = [UIColor(red: 0/255, green: 255/255, blue: 56/255, alpha: 1)]
            set.circleRadius = 3
            
            self.mountButtons()
        }
    }
    
    func startLoading() {
        
    }
    
    func endLoading() {
        
    }
    
    func mountCard() {
        
    }
    
    func mountButtons() {
        let stackview = OptionSelectionStackView(frame: CGRect(x: 0, y: 560, width: self.view.frame.width - 16, height: 40))
        
        self.view.addSubview(stackview)
        
        stackview.contract = self
        
        stackview.set(descriptions: ["1 Mês", "6 Meses", "12 Meses"])
        
        stackview.anchor(top: self.chartView.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
    }
    
}
