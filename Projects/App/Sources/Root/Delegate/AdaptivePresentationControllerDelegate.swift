//
//  AdaptivePresentationControllerDelegate.swift
//  CokeZet-App
//
//  Created by 김진우 on 3/6/25.
//

import UIKit

public protocol AdaptivePresentationControllerDelegate: AnyObject {
  func presentationControllerDidDismiss()
}

public final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
  
  public weak var delegate: AdaptivePresentationControllerDelegate?
  
  public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    delegate?.presentationControllerDidDismiss()
  }
}
