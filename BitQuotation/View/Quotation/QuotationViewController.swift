import Charts

class QuotationViewController: UIViewController {
    
    var chartView: LineChartView?
    var buttonsGroup: OptionSelectionStackView!
    var cardView: QuotationCardView!
    var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView()
    
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
        self.chartView         = nil
        self.buttonsGroup      = nil
        self.activityIndicator = nil
    }

}
