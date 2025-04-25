
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
    func guestLogin()
    func appleLoginAction()
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
//        let kakaoAction: (() -> Void) = {
//            self.listener?.loginAction()
//        }
        
        let exploreAction: (() -> Void) = {
            self.listener?.guestLogin()
        }
        
        let appleAction: (() -> Void) = {
            self.listener?.appleLoginAction()
        }
        
        contentView.selectApple = appleAction
        contentView.selectExplore = exploreAction
//        contentView.selectKaKao = kakaoAction
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
