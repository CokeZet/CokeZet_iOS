
import ModernRIBs

protocol MyCardSetUpInteractable: Interactable {
    var router: MyCardSetUpRouting? { get set }
    var listener: MyCardSetUpListener? { get set }
}

protocol MyCardSetUpViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MyCardSetUpRouter: LaunchRouter<MyCardSetUpInteractable, MyCardSetUpViewControllable>, MyCardSetUpRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: MyCardSetUpInteractable,
        viewController: MyCardSetUpViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
