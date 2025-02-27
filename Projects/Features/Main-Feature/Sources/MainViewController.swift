
import ModernRIBs
import UIKit
import Then
import SnapKit

protocol MainPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func productDetailAttach()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    let label: UILabel = UILabel().then {
        $0.text = "안녕하세요 Main 입니다."
    }
    
    lazy var button: UIButton = UIButton().then {
        $0.setTitle("테스트용 버튼", for: .normal)
        $0.backgroundColor = .black
        let touchDownAction = UIAction(handler: { [weak self] _ in
            guard let self else { return }
            listener?.productDetailAttach()
        })
        
        $0.addAction(touchDownAction, for: .touchDown)
    }
    
    weak var listener: MainPresentableListener?
    
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
        [label, button].forEach {
            self.view.addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }}
