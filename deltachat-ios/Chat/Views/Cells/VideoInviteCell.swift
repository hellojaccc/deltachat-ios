import Foundation
import UIKit
import DcCore

public class VideoInviteCell: UITableViewCell {

    private lazy var messageBackgroundContainer: BackgroundContainer = {
        let container = BackgroundContainer()
        container.image = UIImage(color: DcColors.systemMessageBackgroundColor)
        container.contentMode = .scaleToFill
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    lazy var avatarView: InitialsBadge = {
        let view = InitialsBadge(size: 28)
        view.setColor(DcColors.systemMessageBackgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()

    lazy var videoIcon: InitialsBadge = {
        let view = InitialsBadge(size: 28)
        view.setColor(DcColors.systemMessageBackgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setImage(#imageLiteral(resourceName: "ic_videochat").withRenderingMode(.alwaysTemplate))
        view.tintColor = DcColors.defaultInverseColor
        return view
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(for: .body, weight: .regular)
        return label
    }()

    lazy var openLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(for: .body, weight: .bold)
        label.text = String.localized("open")
        return label
    }()

    lazy var bottomLabel: PaddingTextView = {
        let label = PaddingTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .caption1, weight: .regular)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.layer.cornerRadius = 4
        label.paddingLeading = 4
        label.paddingTrailing = 4
        label.clipsToBounds = true
        label.isAccessibilityElement = false
        label.backgroundColor = UIColor(alpha: 200, red: 50, green: 50, blue: 50)
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        clipsToBounds = false
        backgroundColor = .none
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSubviews() {
        contentView.addSubview(videoIcon)
        contentView.addSubview(avatarView)
        contentView.addSubview(messageBackgroundContainer)
        contentView.addSubview(messageLabel)
        contentView.addSubview(openLabel)
        contentView.addSubview(bottomLabel)
        contentView.addConstraints([
            videoIcon.constraintAlignTopTo(contentView, paddingTop: 12),
            videoIcon.constraintCenterXTo(contentView, paddingX: -36),
            avatarView.constraintAlignTopTo(contentView, paddingTop: 12),
            avatarView.constraintCenterXTo(contentView, paddingX: 36),
            messageLabel.constraintToBottomOf(videoIcon, paddingTop: 16),
            messageLabel.constraintAlignLeadingMaxTo(contentView, paddingLeading: UIDevice.current.userInterfaceIdiom == .pad ? 150 : 50),
            messageLabel.constraintAlignTrailingMaxTo(contentView, paddingTrailing: UIDevice.current.userInterfaceIdiom == .pad ? 150 : 50),
            messageLabel.constraintCenterXTo(contentView),
            openLabel.constraintToBottomOf(messageLabel),
            openLabel.constraintCenterXTo(contentView),
            openLabel.constraintAlignLeadingMaxTo(contentView, paddingLeading: UIDevice.current.userInterfaceIdiom == .pad ? 150 : 50),
            openLabel.constraintAlignTrailingMaxTo(contentView, paddingTrailing: UIDevice.current.userInterfaceIdiom == .pad ? 150 : 50),
            messageBackgroundContainer.constraintAlignLeadingTo(messageLabel, paddingLeading: -6),
            messageBackgroundContainer.constraintAlignTopTo(messageLabel, paddingTop: -6),
            messageBackgroundContainer.constraintAlignBottomTo(openLabel, paddingBottom: -6),
            messageBackgroundContainer.constraintAlignTrailingTo(messageLabel, paddingTrailing: -6),
            bottomLabel.constraintAlignTrailingTo(messageBackgroundContainer),
            bottomLabel.constraintToBottomOf(messageBackgroundContainer, paddingTop: 8),
            bottomLabel.constraintAlignLeadingMaxTo(contentView, paddingLeading: UIDevice.current.userInterfaceIdiom == .pad ? 150 : 50),
            bottomLabel.constraintAlignBottomTo(contentView, paddingBottom: 12)
        ])
        selectionStyle = .none
    }

    func update(dcContext: DcContext, msg: DcMsg) {
        messageLabel.text = msg.text
        let fromContact = dcContext.getContact(id: msg.fromContactId)
        avatarView.setName(msg.getSenderName(fromContact))
        avatarView.setColor(fromContact.color)
        if let profileImage = fromContact.profileImage {
            avatarView.setImage(profileImage)
        }

        bottomLabel.attributedText = MessageUtils.getFormattedBottomLine(message: msg, tintColor: DcColors.checkmarkGreen)
        
        var corners: UIRectCorner = []
        corners.formUnion(.topLeft)
        corners.formUnion(.bottomLeft)
        corners.formUnion(.topRight)
        corners.formUnion(.bottomRight)
        messageBackgroundContainer.update(rectCorners: corners, color: DcColors.systemMessageBackgroundColor)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
        messageLabel.attributedText = nil
        bottomLabel.text = nil
        bottomLabel.attributedText = nil
        avatarView.reset()
    }

}
