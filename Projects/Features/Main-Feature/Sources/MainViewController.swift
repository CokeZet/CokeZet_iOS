
import ModernRIBs
import UIKit
import Then
import SnapKit

import CokeZet_DesignSystem
import CokeZet_Components
import CokeZet_Configurations

protocol MainPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func productDetailAttach()
    func alarmButtonTapped()
    func userButtonTapped()
}

class MainViewController: BaseViewController, MainPresentable, MainViewControllable {
    let contentView: MainView

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

    init(navigationBarType: NavigationBarType, userInfo: UserSetting) {
        let isGuest = userInfo.nickname == "" ? true : false
        self.contentView = MainView(isGuest: isGuest)
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
                    ),
                    BannerItemCell.State(
                        logoImage: CokeZetDesignSystemAsset.icGs25.image,
                        title: "[1+1] 펩시(디카페인) 라임 355ml",
                        description: "개당 2000원",
                        cokeImage: CokeZetDesignSystemAsset.icCanCocaLemon190.image,
                        bottleType: .can
                    )
                ],
            filterList: [
                AccordionItemView.State(
                    title: "브랜드",
                    list: [
                        FilterListView.State(title: "코카콜라", isSelected: false),
                        FilterListView.State(title: "펩시", isSelected: false)
                    ]
                ),
                AccordionItemView.State(
                    title: "용량",
                    list: [
                        FilterListView.State(title: "190ml ~ 210ml", isSelected: false),
                        FilterListView.State(title: "210ml", isSelected: false),
                        FilterListView.State(title: "350ml", isSelected: false),
                        FilterListView.State(title: "355ml", isSelected: false)
                    ]
                ),
                AccordionItemView.State(
                    title: "쇼핑몰",
                    list: CommerceType.allCases.map {
                        FilterListView.State(title: $0.name, isSelected: false)
                    }
                ),
                AccordionItemView.State(
                    title: "할인율",
                    list: DiscountRateType.allCases.sorted { $0.rawValue > $1.rawValue }.map {
                        FilterListView.State(title: $0.text, isSelected: false)
                    }
                ),
                AccordionItemView.State(
                    title: "카드혜택",
                    list: CardType.allCases.map {
                        FilterListView.State(title: $0.name, isSelected: false)
                    }
                )
            ],
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
