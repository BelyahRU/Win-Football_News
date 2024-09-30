import UIKit

// ErrorHandler for managing errors
final class ErrorHandler {
    static let shared = ErrorHandler()
    private init() {}

    func showErrorAlert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
