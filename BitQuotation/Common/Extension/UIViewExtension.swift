
import UIKit

extension UIView {
    func removeSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
