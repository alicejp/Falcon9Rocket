import UIKit

class HeaderView: UIView
{
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "FALCON 9 launches"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        return titleLabel
    }()

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(frame: CGRect)
    {
        titleLabel.frame = frame
        addSubview(titleLabel)
    }
}
