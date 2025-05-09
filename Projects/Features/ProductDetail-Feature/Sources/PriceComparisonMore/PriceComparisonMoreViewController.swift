//
//  PriceComparisonMoreViewController.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import ModernRIBs
import UIKit
import CokeZet_DesignSystem

protocol PriceComparisonMorePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func closeAction()
}

final class PriceComparisonMoreViewController: UIViewController, PriceComparisonMorePresentable, PriceComparisonMoreViewControllable {
    typealias Cell = PriceComparisonTableViewCell
    
    weak var listener: PriceComparisonMorePresentableListener?
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.rowHeight = 80
        
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        
        $0.registerCell(type: Cell.self)
    }
    
    private let titleLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .white).then {
        $0.text = "더보기"
    }
    
    private let exitButton: UIButton = UIButton().then {
        let image = UIImage(systemName: "xmark")?
            .withTintColor(.white, renderingMode: .alwaysTemplate)
            .resize(targetSize: CGSize(width: 22, height: 22))
        $0.setImage(image, for: .normal)
    }
    
    var dataSource: [PriceComparisonTableViewCell.State] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Bottom Sheet did disappear")
        listener?.closeAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = ZetColor.Gray800.color
        
        [tableView, titleLabel, exitButton].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        exitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(32)
        }
    }
    
    func setPriceComparisonData(_ data: [PriceComparisonTableViewCell.State]) {
        for _ in 0..<1 {
            dataSource += data
        }
    }
    
}

extension PriceComparisonMoreViewController: UITableViewDelegate {
    
}

extension PriceComparisonMoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: Cell.self, for: indexPath)
        cell.bind(state: dataSource[indexPath.row])
        return cell
    }
    
    
}
