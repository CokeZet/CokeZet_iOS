
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem

protocol MyCardSetUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func continueToMyCard()
}

final class MyCardSetUpViewController: UIViewController, MyCardSetUpPresentable, MyCardSetUpViewControllable {

    let contentView = MyCardSetUpView()

    weak var listener: MyCardSetUpPresentableListener?

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
            state: MyCardSetUpView.State(
                list: [
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icNh.image, title: "농협"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icKb.image, title: "국민"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icShinhan.image, title: "신한"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icLotteCard.image, title: "롯데"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icHana.image, title: "하나"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icSamsung.image, title: "삼성"),
                    MyCardListView.State(image: CokeZetDesignSystemAsset.icHyundai.image, title: "현대"),
                ],
                confirmAction: UIAction() { [weak self] _ in
                    print("MyCard Next Button Click")
                    self?.listener?.continueToMyCard()
                }
            )
        )

    }
}
