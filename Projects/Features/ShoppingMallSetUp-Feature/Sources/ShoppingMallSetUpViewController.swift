
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem
import CokeZet_Configurations

protocol ShoppingMallSetUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func continueToShoppingMall(_ commerceType: [Int])
}

final class ShoppingMallSetUpViewController: UIViewController, ShoppingMallSetUpPresentable, ShoppingMallSetUpViewControllable {
    
    let contentView = ShoppingMallSetUpView()
    
    weak var listener: ShoppingMallSetUpPresentableListener?
    
    var nickName: String
    
    init(nickname: String) {
        self.nickName = nickname
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
        contentView.bind(
            state: ShoppingMallSetUpView.State(
                nickname: nickName,
                list: CommerceType.allCases.map {
                    ShoppingMallListView.State(image: $0.image, title: $0.name)
                },
                selectConfirm: UIAction() { [weak self] _ in
                    print("ShoppingMall Next Button Click")
                    guard let selectList = self?.contentView.getSelectList() else { return }
                    self?.listener?.continueToShoppingMall(selectList)
                }
            )
        )
    }
    
}
