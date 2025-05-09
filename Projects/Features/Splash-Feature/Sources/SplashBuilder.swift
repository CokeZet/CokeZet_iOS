import ModernRIBs

public protocol SplashDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SplashComponent: Component<SplashDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol SplashBuildable: Buildable {
    func build(withListener listener: SplashListener) -> ViewableRouting
}

public final class SplashBuilder: Builder<SplashDependency>, SplashBuildable {
    
    public override init(dependency: SplashDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SplashListener) -> ViewableRouting {
        let component = SplashComponent(dependency: dependency)
        let viewController = SplashViewController()
        let interactor = SplashInteractor(presenter: viewController)
        interactor.listener = listener
        return SplashRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

