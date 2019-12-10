import UIKit

final class WhiteRoundedView: UIView {
    var activityView: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Methods
extension WhiteRoundedView {
    func showActivityIndicator() {
        self.activityView = UIActivityIndicatorView(style: .gray)
        guard let activityView = self.activityView else { return }
        activityView.center = self.center
        self.addSubview(activityView)
        activityView.startAnimating()
    }

    func hideActivityIndicator() {
        self.activityView?.stopAnimating()
        self.activityView?.removeFromSuperview()
        self.activityView = nil
    }
}
