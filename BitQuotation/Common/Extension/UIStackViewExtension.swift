
import UIKit

extension UIStackView {
    
    func addArrangedSubviews(views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
}
