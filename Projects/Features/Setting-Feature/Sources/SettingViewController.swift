
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_Components

protocol SettingPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func dettachSetting()
}

final class SettingViewController: BaseViewController, SettingPresentable, SettingViewControllable {
    
    let label: UILabel = UILabel().then {
        $0.text = "안녕하세요 Setting 입니다."
    }
    
    weak var listener: SettingPresentableListener?
    
    override init(navigationBarType: NavigationBarType) {
        super.init(navigationBarType: navigationBarType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func backButtonTapped() {
        super.backButtonTapped()
        listener?.dettachSetting()
    }
}
