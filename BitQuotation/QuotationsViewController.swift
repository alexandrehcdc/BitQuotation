import Charts

class QuotationsViewController: UIViewController {
    
    let url = URL(string: "https://api.blockchain.info/charts/market-price?cors=true&format=json&lang=en")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(TransactionResponse.self, from: data)
                
                print(decodedData)
                
            } catch let error {
                print(error)
            }
            
        }
        
//        task.resume()
        
        self.createLineChart()
    }
    
    func createLineChart() {
        
        let chartView = LineChartView(frame: CGRect(x: 16,
                                                    y: 16,
                                                    width: self.view.frame.width - 32,
                                                    height: self.view.frame.height / 2))
        
        self.view.addSubview(chartView)
        
        let values = (0...20).map { i -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: 5)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "teste cansado")
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
        
    }

}
