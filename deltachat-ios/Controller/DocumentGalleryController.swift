import UIKit
import DcCore

class DocumentGalleryController: UIViewController {

    private var fileMessageIds: [Int]
    private let dcContext: DcContext
    private let chatId: Int

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DocumentGalleryFileCell.self, forCellReuseIdentifier: DocumentGalleryFileCell.reuseIdentifier)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 60
        return table
    }()

    private lazy var emptyStateView: EmptyStateLabel = {
        let label = EmptyStateLabel()
        label.text = String.localized("tab_docs_empty_hint")
        label.isHidden = true
        return label
    }()

    private lazy var contextMenu: ContextMenuProvider = {
        let deleteItem = ContextMenuProvider.ContextMenuItem.init(
            title: String.localized("delete"),
            imageName: "trash",
            isDestructive: true,
            action: #selector(DocumentGalleryFileCell.itemDelete(_:)),
            onPerform: { [weak self] indexPath in
                self?.askToDeleteItem(at: indexPath)
            }
        )
        let showInChatItem = ContextMenuProvider.ContextMenuItem(
            title: String.localized("show_in_chat"),
            imageName: "doc.text.magnifyingglass",
            action: #selector(DocumentGalleryFileCell.showInChat(_:)),
            onPerform: { [weak self] indexPath in
                self?.redirectToMessage(of: indexPath)
            }
        )

        let menu = ContextMenuProvider()
        menu.setMenu([showInChatItem, deleteItem])
        return menu
    }()

    init(context: DcContext, chatId: Int, fileMessageIds: [Int]) {
        self.dcContext = context
        self.fileMessageIds = fileMessageIds
        self.chatId = chatId
        super.init(nibName: nil, bundle: nil)
        self.title = String.localized("files")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        if fileMessageIds.isEmpty {
            emptyStateView.isHidden = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setupContextMenuIfNeeded()
    }

    // MARK: - layout
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        emptyStateView.addCenteredTo(parentView: view)
    }

    private func setupContextMenuIfNeeded() {
        UIMenuController.shared.menuItems = contextMenu.menuItems
        UIMenuController.shared.update()
    }

    // MARK: - actions
    private func askToDeleteItem(at indexPath: IndexPath) {
        let chat = dcContext.getChat(chatId: chatId)
        let title = chat.isDeviceTalk ?
            String.localized(stringID: "ask_delete_messages_simple", count: 1) :
            String.localized(stringID: "ask_delete_messages", count: 1)
        let alertController =  UIAlertController(title: title, message: nil, preferredStyle: .safeActionSheet)
        let okAction = UIAlertAction(title: String.localized("delete"), style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(at: indexPath)
        })
        let cancelAction = UIAlertAction(title: String.localized("cancel"), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func deleteItem(at indexPath: IndexPath) {
        let msgId = fileMessageIds.remove(at: indexPath.row)
        self.dcContext.deleteMessage(msgId: msgId)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DocumentGalleryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileMessageIds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DocumentGalleryFileCell.reuseIdentifier, for: indexPath)
                as? DocumentGalleryFileCell else {
            return UITableViewCell()
        }
        let msg = dcContext.getMessage(id: fileMessageIds[indexPath.row])
        cell.update(msg: msg)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let msgId = fileMessageIds[indexPath.row]
        showPreview(msgId: msgId)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    // MARK: - context menu
    // context menu for iOS 11, 12
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        let action = contextMenu.canPerformAction(action: action)
        return action
    }

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        contextMenu.performAction(action: action, indexPath: indexPath)
    }

    // context menu for iOS 13+
    @available(iOS 13, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { [weak self] _ in
                self?.contextMenu.actionProvider(indexPath: indexPath)
            }
        )
    }
}

// MARK: - coordinator
extension DocumentGalleryController {
    func showPreview(msgId: Int) {
        guard let index = fileMessageIds.index(of: msgId) else {
            return
        }
        let previewController = PreviewController(dcContext: dcContext, type: .multi(fileMessageIds, index))
        present(previewController, animated: true, completion: nil)
    }

    func redirectToMessage(of indexPath: IndexPath) {
        let msgId = fileMessageIds[indexPath.row]
        let chatId = dcContext.getMessage(id: msgId).chatId

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.appCoordinator.showChat(chatId: chatId, msgId: msgId, animated: false, clearViewControllerStack: true)
        }
    }
}
