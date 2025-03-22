
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_Components
import CokeZet_DesignSystem
import CokeZet_Core

protocol ProductDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func backAction()
    func attachMoreView()
    func userButtonTapped()
    func alarmButtonTapped()
    func homeButtonTapped()
}

final class ProductDetailViewController: BaseViewController, ProductDetailPresentable, ProductDetailViewControllable {
    
    enum Section: Int, CaseIterable {
        case productImage = 0
        case productOver = 1
        case graphView = 2
        case priceComparison = 3
        case productInfo = 4
    }
    
    public struct State {
        var ProductImageCellData: ProductImageCell.State
        var ProductOverCellData: ProductOverCell.State
        var GraphViewData: [GraphView.State]
        var PriceComparisonCellData: PriceComparisonCell.State
        var ProductInfomationCellData: ProductInfomationCell.State
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
        
        collectionView.registerCell(type: ProductOverCell.self)
        collectionView.registerCell(type: GraphView.self)
        collectionView.registerCell(type: PriceComparisonCell.self)
        collectionView.registerCell(type: ProductInfomationCell.self)
        collectionView.registerCell(type: ProductImageCell.self)
        
        return collectionView
    }()
    
    weak var listener: ProductDetailPresentableListener?
    
    var cellData: State? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(navigationBarType: NavigationBarType) {
        super.init(navigationBarType: navigationBarType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setCellData(_ data: State) {
        cellData = data
    }
    
    override func backButtonTapped() {
        super.backButtonTapped()
        listener?.backAction()
    }
    
    override func userButtonTapped() {
        super.userButtonTapped()
        listener?.userButtonTapped()
    }
    
    override func alarmButtonTapped() {
        super.alarmButtonTapped()
        listener?.alarmButtonTapped()
    }
    
    override func homeButtonTapped() {
        super.homeButtonTapped()
        listener?.homeButtonTapped()
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard cellData != nil else { return 0 }
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
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
        
        guard let section = Section(rawValue: indexPath.section) else { return CGSize(width: 0, height: 0) }
        
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
        guard let cellData else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCell(withType: ProductImageCell.self, for: indexPath)
        cell.bind(cellData.ProductImageCellData)
        return cell
    }
    
    /// 두 번째 셀: ProductOverCell 구성
    private func configuredProductOverCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCell(withType: ProductOverCell.self, for: indexPath)
        cell.backgroundColor = .Gray800
        cell.bind(cellData.ProductOverCellData)
        return cell
    }
    
    /// 세 번째 셀: GraphView 구성
    private func configuredGraphViewCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: GraphView.self, for: indexPath)
        cell.backgroundColor = .Gray800
        return cell
    }
    
    /// 네 번째 셀: PriceComparisonCell 구성
    private func configuredPriceComparisonCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCell(withType: PriceComparisonCell.self, for: indexPath)
        cell.backgroundColor = .Gray800
        cell.bind(cellData.PriceComparisonCellData)
        
        cell.addMoreButtonAction { [weak self] in
            guard let self = self else { return }
            self.listener?.attachMoreView()
        }
        return cell
    }
    
    /// 다섯 번째 셀: ProductInfomationCell 구성
    private func configuredProductInfomationCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCell(withType: ProductInfomationCell.self, for: indexPath)
        cell.backgroundColor = .Gray800
        cell.bind(cellData.ProductInfomationCellData)
        return cell
    }
}
