import ModernRIBs

public protocol SettingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SettingComponent: Component<SettingDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol SettingBuildable: Buildable {
    func build(withListener listener: SettingListener) -> ViewableRouting
}

public final class SettingBuilder: Builder<SettingDependency>, SettingBuildable {
    
    public override init(dependency: SettingDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SettingListener) -> ViewableRouting {
        let component = SettingComponent(dependency: dependency)
        let viewController = SettingViewController(navigationBarType: .alarm_Home)
        let interactor = SettingInteractor(presenter: viewController)
        interactor.listener = listener
        return SettingRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

