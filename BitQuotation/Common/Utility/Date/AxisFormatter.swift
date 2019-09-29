import Charts

class AxisFormatter: IAxisValueFormatter {
    
    var dateFormatter: DateFormatter?
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        if let dateFormatter = dateFormatter {
            let date = Date(timeIntervalSince1970: value)
            
            return dateFormatter.string(from: date)
        }
        
        return String()
    }
    
    
    
}
