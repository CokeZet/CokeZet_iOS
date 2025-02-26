//
//  UITableView+Extension.swift
//  CokeZet-Utilities
//
//  Created by 김진우 on 2/24/25.
//

import UIKit

public extension UITableView {
    
     /// UITableViewCell을 register하는 함수입니다.
     /// - Parameters:
     ///   - type: 등록할 cell의 타입입니다.
     ///   - identifier: 재사용 식별자. 전달하지 않으면 타입의 identifier를 사용합니다.
     func registerCell(
         type: UITableViewCell.Type,
         identifier: String? = nil
     ) {
         let identifier = identifier ?? type.identifier
         self.register(type, forCellReuseIdentifier: identifier)
     }
     
     /// UITableViewCell을 dequeue하는 함수입니다.
     /// - Parameters:
     ///   - type: dequeue할 cell의 타입입니다.
     ///   - identifier: 재사용 식별자. 전달하지 않으면 타입의 identifier를 사용합니다.
     ///   - indexPath: cell이 위치할 indexPath입니다.
     /// - Returns: 지정된 타입의 UITableViewCell 인스턴스입니다.
     func dequeueCell<Cell: UITableViewCell>(
         withType type: Cell.Type,
         identifier: String? = nil,
         for indexPath: IndexPath
     ) -> Cell {
         let identifier = identifier ?? type.identifier
         guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
             fatalError("Identifier \(identifier)로 dequeue한 cell이 \(Cell.self)로 캐스팅되지 않습니다.")
         }
         return cell
     }
     
     /// UITableViewHeaderFooterView를 register하는 함수입니다.
     /// - Parameters:
     ///   - type: 등록할 header/footer view의 타입입니다.
     ///   - identifier: 재사용 식별자. 전달하지 않으면 타입의 identifier를 사용합니다.
     func registerHeaderFooterView(
         type: UITableViewHeaderFooterView.Type,
         identifier: String? = nil
     ) {
         let identifier = identifier ?? type.identifier
         self.register(type, forHeaderFooterViewReuseIdentifier: identifier)
     }
     
     /// UITableViewHeaderFooterView를 dequeue하는 함수입니다.
     /// - Parameters:
     ///   - type: dequeue할 header/footer view의 타입입니다.
     ///   - identifier: 재사용 식별자. 전달하지 않으면 타입의 identifier를 사용합니다.
     /// - Returns: 지정된 타입의 UITableViewHeaderFooterView 인스턴스입니다.
     func dequeueHeaderFooterView<View: UITableViewHeaderFooterView>(
         withType type: View.Type,
         identifier: String? = nil
     ) -> View? {
         let identifier = identifier ?? type.identifier
         return self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? View
     }
 }
