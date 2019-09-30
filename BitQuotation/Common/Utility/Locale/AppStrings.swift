
import Foundation

struct AppStrings {
    
    static let appVersionNumber        = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    static let region_identifier       = localized("region.identifier")
    static let date_months_january     = localized("date.months.january")
    static let date_months_february    = localized("date.months.february")
    static let date_months_march       = localized("date.months.march")
    static let date_months_april       = localized("date.months.april")
    static let date_months_may         = localized("date.months.may")
    static let date_months_june        = localized("date.months.june")
    static let date_months_July        = localized("date.months.July")
    static let date_months_august      = localized("date.months.august")
    static let date_months_september   = localized("date.months.september")
    static let date_months_october     = localized("date.months.october")
    static let date_months_november    = localized("date.months.november")
    static let date_months_december    = localized("date.months.december")
    static let date_units_day          = localized("date.units.day")
    static let date_units_day_plural   = localized("date.units.day.plural")
    static let date_units_month        = localized("date.units.month")
    static let date_units_month_plural = localized("date.units.month.plural")
    static let date_units_year         = localized("date.units.year")
    static let date_units_year_plural  = localized("date.units.year.plural")
    static let currency_dollar_abbr    = localized("currency.dollar.abbr")
    static let currency_btc_in_usd     = localized("currency.btcinusd")
    static let date_units_week         = localized("date.units.week")
    
    
    public static func getLocalizedString(value: Any) -> String {
        if let value = value as? String {
            return localized(value)
        }
        
        return String(describing: value)
    }
    
    public static func localized(_ value: String) -> String {
        return NSLocalizedString(value, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
