
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem
import CokeZet_Components

protocol MainPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func productDetailAttach()
    func alarmButtonTapped()
    func userButtonTapped()
}

class MainViewController: BaseViewController, MainPresentable, MainViewControllable {

    let contentView = MainView()

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

    override init(navigationBarType: NavigationBarType) {
        super.init(navigationBarType: navigationBarType)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = contentView
        self.bind()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Gray800
    }

    private func bind() {
        self.bindAction()
        self.bindState()
    }

    // TODO: 추후 Interactor 작업 시 로그성 코드와 더미 데이터 삭제 필요

    private func bindAction() {
        self.contentView.selectProduct = { [weak self] indexPath in
            self?.listener?.productDetailAttach()
            print("product \(indexPath)")
        }

        self.contentView.selectBanner = { index in
            print("banner \(index)")
        }

        self.contentView.selectFilter = { index in
            print("filter \(index)")
        }
    }

    private func bindState() {
        self.contentView.bind(.init(
            bannerList:
                [
                    BannerItemCell.State(
                        logoImage: CokeZetDesignSystemAsset.icGs25.image,
                        title: "[1+1] 펩시(디카페인) 라임 355ml",
                        description: "개당 2000원",
                        cokeImage: CokeZetDesignSystemAsset.icCanPepsiZeroCaffeine355.image,
                        bottleType: .can
                    ),
                    BannerItemCell.State(
                        logoImage: CokeZetDesignSystemAsset.icGs25.image,
                        title: "[1+1] 펩시(디카페인) 라임 355ml",
                        description: "개당 2000원",
                        cokeImage: CokeZetDesignSystemAsset.icPetCoca500.image,
                        bottleType: .pet
                    ),
                    BannerItemCell.State(
                        logoImage: CokeZetDesignSystemAsset.icGs25.image,
                        title: "[1+1] 펩시(디카페인) 라임 355ml",
                        description: "개당 2000원",
                        cokeImage: CokeZetDesignSystemAsset.icCanCocaLemon190.image,
                        bottleType: .can
                    ),
                    BannerItemCell.State(
                        logoImage: CokeZetDesignSystemAsset.icGs25.image,
                        title: "[1+1] 펩시(디카페인) 라임 355ml",
                        description: "개당 2000원",
                        cokeImage: CokeZetDesignSystemAsset.icCanCocaLemon190.image,
                        bottleType: .can
                    )
                ],
            filterList: Array(
                repeating: AccordionItemView.State(
                    title: "쇼핑몰",
                    list: [
                        FilterListView.State(title: "쿠팡", isSelected: true),
                        FilterListView.State(title: "G마켓", isSelected: false),
                        FilterListView.State(title: "11번가", isSelected: false),
                        FilterListView.State(title: "네이버", isSelected: false),
                        FilterListView.State(title: "마켓컬리", isSelected: false),
                        FilterListView.State(title: "마켓컬리", isSelected: false)
                    ]
                ),
                count: 5
            ),
            productList: Array(
                repeating: ProductItemCell.State(
                    market: CokeZetDesignSystemAsset.icMarket11st.image,
                    info: CardInfoView.State(
                        image: CokeZetDesignSystemAsset.icCanPepsi355.image,
                        discountRateType: .zetPick,
                        productName: "코카 콜라 250ml 24개",
                        discountRate: 24,
                        price: 16000,
                        isDeliveryFee: true
                    ),
                    benefit: CardBenefitView.State(
                        list: [
                            CokeZetDesignSystemAsset.icShinhan.image,
                            CokeZetDesignSystemAsset.icKb.image,
                            CokeZetDesignSystemAsset.icLotteCard.image,
                            CokeZetDesignSystemAsset.icHyundai.image,
                            CokeZetDesignSystemAsset.icSamsung.image,
                        ]
                    )
                ),
                count: 10
            )))
    }
    
    override func alarmButtonTapped() {
        super.alarmButtonTapped()
        listener?.alarmButtonTapped()
    }
    
    override func userButtonTapped() {
        super.userButtonTapped()
        listener?.userButtonTapped()
    }

}
