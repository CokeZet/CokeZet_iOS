
import ModernRIBs
import UIKit
import Then
import SnapKit

protocol ShoppingMallSetUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ShoppingMallSetUpViewController: UIViewController, ShoppingMallSetUpPresentable, ShoppingMallSetUpViewControllable {

    let label: UILabel = UILabel().then {
        $0.text = "안녕하세요 ShoppingMallSetUp 입니다."
    }
    
    weak var listener: ShoppingMallSetUpPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
    }}
