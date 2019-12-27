import UIKit

class LaunchCell: UITableViewCell
{
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    private enum LayoutConstants
    {
        static let margin: CGFloat = 5
        static let imageHeight: CGFloat = 90
        static let labelHeight: CGFloat = 20
        static let imageAttachmentlabelHeight: CGFloat = 40
    }

    private var missionImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "rocket"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "name"
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var dateLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "date"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private var launchSuccessLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Mission Success :"
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    convenience init()
    {
        self.init(style: .default, reuseIdentifier: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: LaunchCellViewModel)
    {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        missionImageView.getLaunches(urlString: viewModel.missionPatchSmallImageLink)
        launchSuccessLabel.imageAttachment(with: viewModel.launchSuccess)
    }

    private func setup()
    {
        selectionStyle = .none
        backgroundColor = .white
        addSubview(missionImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(launchSuccessLabel)
    }

    private func layout()
    {
        missionImageView.layout([
            missionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.margin),
            missionImageView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.margin),
            missionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutConstants.margin),
            missionImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageHeight)
        ])

        nameLabel.layout([
            nameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: LayoutConstants.margin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.margin),
            nameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.labelHeight),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstants.margin)
        ])

        dateLabel.layout([
            dateLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: LayoutConstants.margin),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.margin),
            dateLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.labelHeight),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: LayoutConstants.margin)
        ])

        launchSuccessLabel.layout([
            launchSuccessLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: LayoutConstants.margin),
            launchSuccessLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.margin),
            launchSuccessLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LayoutConstants.margin),
            launchSuccessLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.imageAttachmentlabelHeight)
        ])
    }
}

extension UIView
{
    final func layout(_ constraints: [NSLayoutConstraint])
    {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        layoutIfNeeded()
    }
}

extension UILabel
{
    func imageAttachment(with launchSuccess: Bool)
    {
        let fullString = NSMutableAttributedString(string: "Mission Success: ")

        let imageAttachment = NSTextAttachment()

        imageAttachment.image = launchSuccess ? UIImage(named: "rocket")?.withTintColor(.green) : UIImage(named: "rocket")?.withTintColor(.red)
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)

        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)

        self.attributedText = fullString
    }
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView
{
    func setImageColor(color: UIColor) {
      let tempImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = tempImage
      self.tintColor = color
    }

    func getLaunches(urlString: String)
    {
        guard let url = URL(string: urlString) else { return }

        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) {
            data, response, error in

            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else { return }

                imageCache.setObject(image, forKey: urlString as NSString)
                self.contentMode = .scaleAspectFill
                self.image = image
                activityIndicator.removeFromSuperview()
            }
        }.resume()
    }
}
