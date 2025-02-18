
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_Components

protocol ProductDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func swipeToBack()
}

final class ProductDetailViewController: UIViewController, ProductDetailPresentable, ProductDetailViewControllable {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductOverCell.self, forCellWithReuseIdentifier: "ProductOverCell")
        collectionView.register(GraphView.self, forCellWithReuseIdentifier: "GraphView")
        collectionView.register(PriceComparisonCell.self, forCellWithReuseIdentifier: "PriceComparisonView")
        collectionView.register(ProductInfomationCell.self, forCellWithReuseIdentifier: "ProductInfomationCell")
        
        return collectionView
    }()
    
    weak var listener: ProductDetailPresentableListener?
    
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
        
        collectionView.reloadData()
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOverCell", for: indexPath) as? ProductOverCell else { return UICollectionViewCell() }
            cell.backgroundColor = .Gray800
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphView", for: indexPath) as? GraphView else { return UICollectionViewCell() }
            cell.backgroundColor = .Gray800
            return cell
        } else if indexPath.row == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceComparisonView", for: indexPath) as? PriceComparisonCell else { return UICollectionViewCell() }
            cell.backgroundColor = .Gray800
            return cell
        } else if indexPath.row == 3 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfomationCell", for: indexPath) as? ProductInfomationCell else { return UICollectionViewCell() }
            cell.backgroundColor = .Gray800
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: self.view.bounds.width, height: 542)
        } else if indexPath.row == 1 {
            return CGSize(width: self.view.bounds.width, height: 360)
        } else if indexPath.row == 2 {
            return CGSize(width: self.view.bounds.width, height: 523)
        } else if indexPath.row == 3 {
            return CGSize(width: self.view.bounds.width, height: 290)
        }
        
        
        return CGSize(width: self.view.bounds.width, height: 542)
    }
}
