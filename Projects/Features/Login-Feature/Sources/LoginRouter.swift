
import ModernRIBs

protocol LoginInteractable: Interactable {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoginRouter: LaunchRouter<LoginInteractable, LoginViewControllable>, LoginRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
