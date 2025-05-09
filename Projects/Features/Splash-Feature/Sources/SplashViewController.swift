
import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_DesignSystem

protocol SplashPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SplashViewController: UIViewController, SplashPresentable, SplashViewControllable {
    
    weak var listener: SplashPresentableListener?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = CokeZetDesignSystemAsset.logo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let logoTextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = CokeZetDesignSystemAsset.logoText.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = ZetColor.Gray800.color
        view.addSubview(logoImageView)
        view.addSubview(logoTextImageView)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        logoTextImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
    }
}
