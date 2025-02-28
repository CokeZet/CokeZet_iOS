
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem

protocol NicknamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class NicknameViewController: UIViewController, NicknamePresentable, NicknameViewControllable {

    let contentView = NicknameSettingView()

    weak var listener: NicknamePresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Gray800
        setupViews()
    }

    func setupViews() {

    }
}
