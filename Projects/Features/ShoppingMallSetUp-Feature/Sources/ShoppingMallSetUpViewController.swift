
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem

protocol ShoppingMallSetUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func continueToShoppingMall()
}

final class ShoppingMallSetUpViewController: UIViewController, ShoppingMallSetUpPresentable, ShoppingMallSetUpViewControllable {

    let contentView = ShoppingMallSetUpView()

    weak var listener: ShoppingMallSetUpPresentableListener?

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
        contentView.bind(
            state: ShoppingMallSetUpView.State(
                nickname: "복슬복슬한반달가슴곰",
                list: [
                    ShoppingMallListView.State(image: nil, title: "전체"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.ic11st.image, title: "11번가"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCoupang.image, title: "쿠팡"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icGmarket.image, title: "지마켓"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCurly.image, title: "마켓컬리"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
                       ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버")
                ],
                selectConfirm: UIAction() { [weak self] _ in
                    print("ShoppingMall Next Button Click")
                    self?.listener?.continueToShoppingMall()
                }
            )
        )
    }

}
