
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_Components
import CokeZet_DesignSystem

protocol ProductDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func swipeToBack()
    func attachMoreView()
}

final class ProductDetailViewController: UIViewController, ProductDetailPresentable, ProductDetailViewControllable {
    
    enum DetailSection: Int, CaseIterable {
        case productImage = 0
        case productOver = 1
        case graphView = 2
        case priceComparison = 3
        case productInfo = 4
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ZetColor.Gray900.color
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductOverCell.self, forCellWithReuseIdentifier: "ProductOverCell")
        collectionView.register(GraphView.self, forCellWithReuseIdentifier: "GraphView")
        collectionView.register(PriceComparisonCell.self, forCellWithReuseIdentifier: "PriceComparisonView")
        collectionView.register(ProductInfomationCell.self, forCellWithReuseIdentifier: "ProductInfomationCell")
        collectionView.register(ProductImageCell.self, forCellWithReuseIdentifier: "ProductImageCell")
        
        return collectionView
    }()
    
    weak var listener: ProductDetailPresentableListener?
    
    var PriceComparisonCellData: [PriceComparisonTableViewCell.State] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // 스와이프 제스처 추가
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDownGesture.direction = .right
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    // 스와이프 동작 처리
    @objc private func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        // 화면 닫기
        listener?.swipeToBack()
    }
    
    func setupViews() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setCellData(_ data: [PriceComparisonTableViewCell.State]) {
        PriceComparisonCellData = data
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = DetailSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .productImage:
            return configuredProductImageCell(for: collectionView, at: indexPath)
        case .productOver:
            return configuredProductOverCell(for: collectionView, at: indexPath)
        case .graphView:
            return configuredGraphViewCell(for: collectionView, at: indexPath)
        case .priceComparison:
            return configuredPriceComparisonCell(for: collectionView, at: indexPath)
        case .productInfo:
            return configuredProductInfomationCell(for: collectionView, at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let section = DetailSection(rawValue: indexPath.section) else { return CGSize(width: 0, height: 0) }
        
        switch section {
        case .productImage:
            return CGSize(width: self.view.bounds.width, height: 180)
        case .productOver:
            return CGSize(width: self.view.bounds.width, height: 542)
        case .graphView:
            return CGSize(width: self.view.bounds.width, height: 360)
        case .priceComparison:
            return CGSize(width: self.view.bounds.width, height: 523)
        case .productInfo:
            return CGSize(width: self.view.bounds.width, height: 290)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }
    
    // MARK: - 셀 구성 메서드
    
    /// 첫 번째 셀: ProductImageCell 구성
    private func configuredProductImageCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImageCell", for: indexPath) as? ProductImageCell else {
            return UICollectionViewCell()
        }
        cell.bind(.init(cokeImage: CokeZetDesignSystemAsset.icCanPepsi190.image, badgeType: .zetPick))
        return cell
    }
    
    /// 두 번째 셀: ProductOverCell 구성
    private func configuredProductOverCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOverCell", for: indexPath) as? ProductOverCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .Gray800
        cell.bind(
            .init(
                infomationState: ProductInfomationView.State(priceText: "13000",
                                                             permlPrice: "193",
                                                             sellerImage: CokeZetDesignSystemAsset.icKb.image,
                                                             shipFeetext: "3000",
                                                             carddiscountText: "신한카드 12300"),
                buyButtonAction: {
                    print("Buy 버튼 클릭 클릭")
                },
                adBannerButtonAction: {
                    print("Banner 버튼 클릭 클릭")
                }
            )
        )
        return cell
    }
    
    /// 세 번째 셀: GraphView 구성
    private func configuredGraphViewCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphView", for: indexPath) as? GraphView else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .Gray800
        return cell
    }
    
    /// 네 번째 셀: PriceComparisonCell 구성
    private func configuredPriceComparisonCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceComparisonView", for: indexPath) as? PriceComparisonCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .Gray800
        cell.bind(
            .init(
                cellData: PriceComparisonCellData
            )
        )
        
        cell.addMoreButtonAction { [weak self] in
            guard let self = self else { return }
            self.listener?.attachMoreView()
        }
        return cell
    }
    
    /// 다섯 번째 셀: ProductInfomationCell 구성
    private func configuredProductInfomationCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfomationCell", for: indexPath) as? ProductInfomationCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .Gray800
        cell.bind(.init(foodType: "음료", packType: "캔류", capacity: "190ml", quantity: "12캔", features: ["무가당", "무설탕"]))
        return cell
    }
}
