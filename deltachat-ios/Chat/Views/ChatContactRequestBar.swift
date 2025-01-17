import UIKit
import InputBarAccessoryView
import DcCore

public protocol ChatContactRequestDelegate: class {
    func onAcceptRequest()
    func onBlockRequest()
    func onDeleteRequest()
}

public class ChatContactRequestBar: UIView, InputItem {
    public var inputBarAccessoryView: InputBarAccessoryView?
    public var parentStackViewPosition: InputStackView.Position?
    public func textViewDidChangeAction(with textView: InputTextView) {}
    public func keyboardSwipeGestureAction(with gesture: UISwipeGestureRecognizer) {}
    public func keyboardEditingEndsAction() {}
    public func keyboardEditingBeginsAction() {}

    weak var delegate: ChatContactRequestDelegate?
    
    private var useDeleteButton: Bool = false

    private lazy var acceptButton: UIButton = {
        let view = UIButton()
        view.setTitle(String.localized("accept"), for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var blockButton: UIButton = {
        let view = UIButton()
        view.setTitle(useDeleteButton ? String.localized("delete") : String.localized("block"), for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var mainContentView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [blockButton, acceptButton])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public required init(useDeleteButton: Bool) {
        self.useDeleteButton = useDeleteButton
        super.init(frame: .zero)
        setupSubviews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupSubviews() {
        addSubview(mainContentView)

        addConstraints([
            mainContentView.constraintAlignTopTo(self, paddingTop: 4),
            mainContentView.constraintAlignBottomTo(self, paddingBottom: 4),
            mainContentView.constraintAlignLeadingTo(self),
            mainContentView.constraintAlignTrailingTo(self),
        ])

        backgroundColor = DcColors.chatBackgroundColor

        let acceptGestureListener = UITapGestureRecognizer(target: self, action: #selector(onAcceptPressed))
        acceptButton.addGestureRecognizer(acceptGestureListener)

        let blockGestureListener = UITapGestureRecognizer(target: self, action: #selector(onRejectPressed))
        blockButton.addGestureRecognizer(blockGestureListener)

    }

    @objc func onAcceptPressed() {
        delegate?.onAcceptRequest()
    }

    @objc func onRejectPressed() {
        if useDeleteButton {
            delegate?.onDeleteRequest()
        } else {
            delegate?.onBlockRequest()
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 44)
    }
}
