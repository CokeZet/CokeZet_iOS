
import ModernRIBs
import Features

protocol ShoppingMallSetUpInteractable: Interactable {
    var router: ShoppingMallSetUpRouting? { get set }
    var listener: ShoppingMallSetUpListener? { get set }
}

protocol ShoppingMallSetUpViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ShoppingMallSetUpRouter: LaunchRouter<ShoppingMallSetUpInteractable, ShoppingMallSetUpViewControllable>, ShoppingMallSetUpRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: ShoppingMallSetUpInteractable,
        viewController: ShoppingMallSetUpViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
