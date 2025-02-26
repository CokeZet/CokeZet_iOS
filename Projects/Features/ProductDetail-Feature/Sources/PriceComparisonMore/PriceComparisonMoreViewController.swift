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
        $0.rowHeight = 88
        
        $0.registerCell(type: Cell.self)
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
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20))
        }
    }
    
    func setPriceComparisonData(_ data: [PriceComparisonTableViewCell.State]) {
        for i in 0..<3 {
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
