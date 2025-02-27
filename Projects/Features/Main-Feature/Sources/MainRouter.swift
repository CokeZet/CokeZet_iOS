
import ModernRIBs
import ProductDetail_Feature
import CokeZet_Utilities
import CokeZet_Core

protocol MainInteractable: Interactable, ProductDetailListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    private let productDetailBuildable: ProductDetailBuildable
    private var productDetailRouting: Routing?
    private let transitioningDelegate: PushModalPresentationController
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: MainInteractable,
        productDetailBuildable: ProductDetailBuildable,
        viewController: MainViewControllable
    ) {
        self.transitioningDelegate = PushModalPresentationController()
        self.productDetailBuildable = productDetailBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachProductDetail() {
        if productDetailRouting != nil {
            return
        }
        
        let router = productDetailBuildable.build(withListener: interactor)
        presentWithPushTransition(router.viewControllable, animated: true)
        attachChild(router)
        self.productDetailRouting = router
    }
    
    func deatchProductDetail() {
        guard let router = productDetailRouting else {
            return
        }
        
        viewController.dismiss(completion: nil)
        self.productDetailRouting = nil
        detachChild(router)
    }
    
    private func presentWithPushTransition(_ viewControllable: ViewControllable, animated: Bool) {
        viewControllable.uiviewController.modalPresentationStyle = .custom
        viewControllable.uiviewController.transitioningDelegate = transitioningDelegate
        viewController.present(viewControllable, animated: true, completion: nil)
    }
}
