import UIKit

class LaunchCell: UITableViewCell
{
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    private lazy var missionImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "paperplane.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "name"
        return lbl
    }()

    private lazy var dateLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "date"
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
    }

    private func setup()
    {
        addSubview(missionImageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
    }

    private func layout()
    {
        missionImageView.layout([
            missionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            missionImageView.heightAnchor.constraint(equalToConstant: 100),
            missionImageView.widthAnchor.constraint(equalToConstant: 100),
            missionImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        nameLabel.layout([
            nameLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor)
        ])

        dateLabel.layout([
            dateLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
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
