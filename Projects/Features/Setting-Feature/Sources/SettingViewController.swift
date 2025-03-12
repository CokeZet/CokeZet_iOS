
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_Components
import CokeZet_DesignSystem

protocol SettingPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func dettachSetting()
}

final class SettingViewController: BaseViewController, SettingPresentable, SettingViewControllable {
    
    typealias MenuState = MenuCell.State
    typealias VersionState = VersionFooterView.State
    typealias ProfileState = ProfileHeaderView.State
    
    // MARK: - UI Components
    private let backButton = UIButton()
    private let notificationButton = UIButton()
    private let homeButton = UIButton()
    private let collectionView: UICollectionView!
    
    // MARK: - Properties
    enum Section: Int, CaseIterable {
        case priceAlert
        case support
        case terms
    }
    
    struct MenuItem {
        let title: String
    }
    
    private let sectionItems: [Section: [MenuItem]] = [
        .priceAlert: [MenuItem(title: "가격 알림 설정")],
        .support: [MenuItem(title: "공지사항"), MenuItem(title: "문의하기")],
        .terms: [MenuItem(title: "서비스 이용약관"), MenuItem(title: "개인정보 처리방침"), MenuItem(title: "회원탈퇴")]
    ]
    
    weak var listener: SettingPresentableListener?
    
    override init(navigationBarType: NavigationBarType) {
        // CollectionView 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(navigationBarType: navigationBarType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func backButtonTapped() {
        super.backButtonTapped()
        listener?.dettachSetting()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = ZetColor.Gray500.color
        setupCollectionView()
        
        #warning("TODO: 네비게이션 타이틀 설정 값 확인")
        self.navigationItem.title = "내 설정"
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = ZetColor.Black.color
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        collectionView.register(ProfileHeaderView.self,
                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                               withReuseIdentifier: "ProfileHeader")
        
        collectionView.register(VersionFooterView.self,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                   withReuseIdentifier: "VersionFooter")
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        return sectionItems[sectionType]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.section, indexPath.row)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell,
              let sectionType = Section(rawValue: indexPath.section),
              let items = sectionItems[sectionType] else {
            return UICollectionViewCell()
        }
        
        cell.bind(MenuState(title: items[indexPath.item].title))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("header")
        print(indexPath.section, indexPath.row)
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0 {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ProfileHeader",
                for: indexPath) as! ProfileHeaderView
            
            headerView.bind(ProfileState(userName: "김콜라"))
            
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter && indexPath.section == 2 {
            // 마지막 섹션의 Footer로 버전 정보 표시
            let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "VersionFooter",
                for: indexPath) as! VersionFooterView
            
            footerView.bind(VersionState(version: "0.0.0"))
            
            return footerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 89)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == 2 ? CGSize(width: collectionView.frame.width, height: 50) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 첫 번째 섹션(가격 알림 설정)은 상단 간격 없음
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 하단에 8픽셀 간격 추가
        }
        // 마지막 섹션은 하단 간격 없음
        else if section == Section.allCases.count - 1 {
            return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0) // 상단에 8픽셀 간격 추가
        }
        // 중간 섹션은 상하단 모두 간격 추가
        else {
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0) // 상하단 모두 8픽셀 간격
        }
    }
}
