
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem

protocol LoginPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func loginAction()
    func detachAction()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

    private let contentView = LoginView()

    weak var listener: LoginPresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addConfigure()
        self.makeConstraints()
        buttonSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.detachAction()
    }

    private func addConfigure() {
        self.view.backgroundColor = .Gray800
        self.navigationController?.navigationBar.isHidden = true
    }

    private func makeConstraints() {
        self.view.addSubview(contentView)

        self.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buttonSetup() {
        let action: (() -> Void) = {
            self.listener?.loginAction()
        }
        
        contentView.selectApple = action
        contentView.selectExplore = action
        contentView.selectKaKao = action
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = LoginViewController()

    return view.view
}
