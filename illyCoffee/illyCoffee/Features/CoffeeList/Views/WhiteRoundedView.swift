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

// MARK: - Methods
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

// MARK: - Touch Methods
extension WhiteRoundedView {
    enum HighlightState {
        case highlight
        case unhighlight
    }

    func animate(state: HighlightState) {
        switch state {
        case .highlight:
            self.backgroundColor = .lightGray
        case .unhighlight:
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: [],
                           animations: { self.backgroundColor = .white },
                           completion: nil)
        }
    }
}
