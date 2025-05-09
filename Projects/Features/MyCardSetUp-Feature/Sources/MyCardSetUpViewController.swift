
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem
import CokeZet_Configurations

protocol MyCardSetUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func continueToMyCard(_ cardList: [Int])
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
                list: CardType.allCases.map {
                    MyCardListView.State(image: $0.image, title: $0.name)
                },
                confirmAction: UIAction() { [weak self] _ in
                    print("MyCard Next Button Click")
                    guard let list = self?.contentView.getSelectList() else { return }
                    self?.listener?.continueToMyCard(list)
                }
            )
        )

    }
}
