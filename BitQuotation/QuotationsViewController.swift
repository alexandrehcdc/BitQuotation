import Charts

class QuotationsViewController: UIViewController {
    
    let url = URL(string: "https://api.blockchain.info/charts/market-price?cors=true&format=json&lang=en")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let useCase = InjectionUseCase.provideTransactionUseCase()
        
        useCase.getTransactionDataBy(operation: .remote_only) {(response) in
            DispatchQueue.main.sync { [unowned self] in
                self.createLineChart(transaction: response)
            }
            
        }
        
    }
    
    func createLineChart(transaction: Transaction) {
        
        let chartView = LineChartView(frame: CGRect(x: 16,
                                                    y: 16,
                                                    width: self.view.frame.width - 32,
                                                    height: self.view.frame.height / 2))
        self.view.addSubview(chartView)
        
        let values = transaction.values.map { i -> ChartDataEntry in
            return ChartDataEntry(x: Double(i.x), y: Double(i.y))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "teste cansado")
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
        
    }

}
