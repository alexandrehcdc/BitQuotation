
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
            self.mountCard(transaction: transaction)
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
    
    func mountCard(transaction: Transaction) {
        DispatchQueue.main.async { [unowned self] in
            self.cardView = QuotationCardView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: self.view.frame.width,
                                                            height: self.view.frame.height * 1/8))
            
            self.view.addSubview(self.cardView)
            
            self.cardView.anchor(top: self.buttonsGroup.bottomAnchor,
                                 leading: self.view.leadingAnchor,
                                 bottom: self.view.bottomAnchor,
                                 trailing: self.view.trailingAnchor,
                                 padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            
            self.cardView.setTransactionValues(transaction: transaction)
        }
    }
    
    func mountButtons(selected: TimeInMonthsEnum) {
        DispatchQueue.main.async { [unowned self] in
            self.buttonsGroup = OptionSelectionStackView(frame: CGRect(x: 0, y: 560, width: self.view.frame.width - 16, height: self.view.frame.height * 1/12))
            
            self.view.addSubview(self.buttonsGroup)
            
            self.buttonsGroup.contract = self
            
            self.buttonsGroup.set(descriptions: ["\(TimeInMonthsEnum.month.rawValue) \(AppStrings.date_units_month)",
                                                 "\(TimeInMonthsEnum.semester.rawValue) \(AppStrings.date_units_month_plural)",
                                                 "\(TimeInMonthsEnum.year.rawValue) \(AppStrings.date_units_month_plural)"])
            
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
        
        if period == 365 {
            for value in transaction.values {
                values.append(ChartDataEntry(x: Double(value.x), y: value.y))
            }
        } else {
            for value in transaction.values.suffix(period) {
                values.append(ChartDataEntry(x: Double(value.x), y: value.y))
            }
        }
        
        
        
        let set = LineChartDataSet(entries: values, label: AppStrings.currency_btc_in_usd)
        
        set.valueTextColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        set.circleColors   = [UIColor(red: 0/255, green: 227/255, blue: 216/255, alpha: 1)]
        set.colors         = [UIColor(red: 0/255, green: 227/255, blue: 216/255, alpha: 1)]
        set.circleRadius   = 3
        
        return LineChartData(dataSet: set)
    }
    
}
