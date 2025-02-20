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

    weak var listener: PriceComparisonMorePresentableListener?
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PriceComparisonTableViewCell.self, forCellReuseIdentifier: "PriceComparisonTableViewCell")
        $0.backgroundColor = .clear
        $0.rowHeight = 88
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
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20))
        }
    }
    
}

extension PriceComparisonMoreViewController: UITableViewDelegate {
    
}

extension PriceComparisonMoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceComparisonTableViewCell") as? PriceComparisonTableViewCell else { return UITableViewCell() }
        cell.bind(state: .init(image: CokeZetDesignSystemAsset.icNaver.image))
        return cell
    }
    
    
}
