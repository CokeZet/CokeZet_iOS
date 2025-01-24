
import ModernRIBs
import Features

protocol NicknameInteractable: Interactable {
    var router: NicknameRouting? { get set }
    var listener: NicknameListener? { get set }
}

protocol NicknameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class NicknameRouter: LaunchRouter<NicknameInteractable, NicknameViewControllable>, NicknameRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: NicknameInteractable,
        viewController: NicknameViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
