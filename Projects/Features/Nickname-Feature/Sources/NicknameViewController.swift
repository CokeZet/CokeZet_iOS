
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem

protocol NicknamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func continueToNickname()
}

final class NicknameViewController: UIViewController, NicknamePresentable, NicknameViewControllable {
    
    let contentView = NicknameSettingView()
    
    weak var listener: NicknamePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        
        contentView.bind(
            state:
                NicknameSettingView.State(
                    defaultNickname: "",
                    selectConfirm: UIAction() { [weak self] _ in
                        print("Nickname Next Button Click")
                        self?.listener?.continueToNickname()
                    }
                )
        )
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardHeight: CGFloat
        if endFrame.origin.y >= UIScreen.main.bounds.height {
            // 키보드가 내려감
            keyboardHeight = 0
        } else {
            // 키보드가 올라옴
            keyboardHeight = endFrame.height - view.safeAreaInsets.bottom
        }
        contentView.updateButtonForKeyboard(keyboardHeight: keyboardHeight, animationDuration: duration)
    }
}
