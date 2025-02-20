
import ModernRIBs
import CokeZet_Core
import CokeZet_Utilities

protocol ProductDetailInteractable: Interactable, PriceComparisonMoreListener {
    var router: ProductDetailRouting? { get set }
    var listener: ProductDetailListener? { get set }
}

protocol ProductDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ProductDetailRouter: LaunchRouter<ProductDetailInteractable, ProductDetailViewControllable>, ProductDetailRouting {
    
    private let priceComparisonMoreBuildable: PriceComparisonMoreBuildable
    private var priceComparisonMoreRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: ProductDetailInteractable,
        viewController: ProductDetailViewControllable,
        priceComparisonMoreBuildable: PriceComparisonMoreBuildable
    ) {
        self.priceComparisonMoreBuildable = priceComparisonMoreBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachPriceComparisonMore() {
        if priceComparisonMoreRouting != nil {
            return
        }
        
        let router = priceComparisonMoreBuildable.build(withListener: interactor)
        presentWithPushTransition(router.viewControllable, animated: true)
        attachChild(router)
        self.priceComparisonMoreRouting = router
    }
    
    func detachPriceComparisonMore() {
        guard let router = priceComparisonMoreRouting else {
            return
        }
        
//        viewController.dismiss(completion: nil)
        self.priceComparisonMoreRouting = nil
        detachChild(router)
    }
    
    private func presentWithPushTransition(_ viewControllable: ViewControllable, animated: Bool) {
        viewControllable.uiviewController.modalPresentationStyle  = .automatic
        viewControllable.uiviewController.sheetPresentationController?.prefersGrabberVisible = true
        viewController.present(viewControllable, animated: true, completion: nil)
    }
}
