
import Charts

extension QuotationViewController: QuotationViewContract {
    
    func redraw(with period: TimeInDaysEnum) {
        self.presenter.loadMainQuotation(period: period)
    }
    
    func mountGraphWith(transaction: Transaction, period: Int) {
        
        if self.chartView != nil {
            self.chartView?.notifyDataSetChanged()
            
            self.chartView?.data = self.mountChartData(transaction: transaction, period: period)
            
            return
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.chartView = LineChartView(frame: CGRect(x: 16,
                                                         y: 16,
                                                         width: self.view.frame.width - 16,
                                                         height: self.view.frame.height * 6/8))
            guard let chartView = self.chartView else { return }
            
            self.view.addSubview(chartView)
            
            let dateFormatter = DateFormatter(),
                axisFormatter = AxisFormatter()
            
            dateFormatter.dateFormat = "dd MMM yy"
            dateFormatter.locale     = Locale.current
            
            axisFormatter.dateFormatter = dateFormatter
            
            self.chartView?.data                    = self.mountChartData(transaction: transaction, period: period)
            self.chartView?.xAxis.valueFormatter    = axisFormatter
            self.chartView?.legend.font             = UIFont.systemFont(ofSize: 16)
            self.chartView?.xAxis.labelTextColor    = .white
            self.chartView?.xAxis.axisLineColor     = .white
            self.chartView?.leftAxis.labelTextColor = .white
            self.chartView?.legend.textColor        = .white
            
            self.mountButtons(selected: .year)
            
        }
    }
    
    func startLoading() {
        self.activityIndicator.center           = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style            = UIActivityIndicatorView.Style.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func endLoading() {
        self.activityIndicator.stopAnimating()
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func mountCard() {
        // to do
    }
    
    func mountButtons(selected: TimeInMonthsEnum) {
        DispatchQueue.main.async { [unowned self] in
            self.buttonsGroup = OptionSelectionStackView(frame: CGRect(x: 0, y: 560, width: self.view.frame.width - 16, height: 40))
            
            self.view.addSubview(self.buttonsGroup)
            
            self.buttonsGroup.contract = self
            
            self.buttonsGroup.set(descriptions: ["1 Mês", "6 Meses", "12 Meses"])
            
            self.buttonsGroup.anchor(top: self.chartView?.bottomAnchor,
                                     leading: self.view.leadingAnchor,
                                     trailing: self.view.trailingAnchor,
                                     padding: UIEdgeInsets(top: 8,
                                                           left: 8,
                                                           bottom: 0,
                                                           right: 8))
        }
        
    }
    
    private func mountChartData(transaction: Transaction, period: Int) -> LineChartData {
        var values: [ChartDataEntry] = []
        
        for (index,value) in transaction.values.enumerated() {
            if index == (period - 1) { break }
            values.append(ChartDataEntry(x: Double(value.x), y: value.y))
        }
        
        let set = LineChartDataSet(entries: values, label: "To do - fix label")
        
        set.valueTextColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        set.circleColors   = [UIColor(red: 0/255, green: 227/255, blue: 216/255, alpha: 1)]
        set.colors         = [UIColor(red: 0/255, green: 227/255, blue: 216/255, alpha: 1)]
        set.circleRadius   = 3
        
        return LineChartData(dataSet: set)
    }
    
}
