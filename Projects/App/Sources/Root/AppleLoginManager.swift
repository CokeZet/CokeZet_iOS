//
//  AppleLoginManager.swift
//  CokeZet-App
//
//  Created by 김진우 on 3/23/25.
//

import AuthenticationServices

protocol AppleLoginManagerDelegate: AnyObject {
    func didCompleteAppleLogin(userId: String, email: String?)
    func didFailAppleLogin()
}

final class AppleLoginManager: NSObject {
    
    weak var delegate: AppleLoginManagerDelegate?
    
    init(delegate: AppleLoginManagerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func startAppleLogin() {
        print("Start sign in")
        
        let provider = ASAuthorizationAppleIDProvider()
        let requset = provider.createRequest()
        
        // 사용자에게 제공받을 정보를 선택 (이름 및 이메일) -- 아래 이미지 참고
        requset.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [requset])
        // 로그인 정보 관련 대리자 설정
        controller.delegate = self
        // 인증창을 보여주기 위해 대리자 설정
        controller.presentationContextProvider = self
        // 요청
        controller.performRequests()
    }
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    // 인증창을 보여주기 위한 메서드 (인증창을 보여 줄 화면을 설정)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first! ?? UIView() as! ASPresentationAnchor
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    
    // 로그인 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("로그인 실패", error.localizedDescription)
    }
    
    // Apple ID 로그인에 성공한 경우, 사용자의 인증 정보를 확인하고 필요한 작업을 수행합니다
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIdCredential.user
            let fullName = appleIdCredential.fullName
            let email = appleIdCredential.email
            
            // identityToken을 String으로 변환
            if let identityToken = appleIdCredential.identityToken,
               let identityTokenString = String(data: identityToken, encoding: .utf8) {
                print("Identity Token: \(identityTokenString)")
                // identityTokenString 사용
            } else {
                print("identityToken을 문자열로 변환할 수 없습니다.")
            }

            // authorizationCode를 String으로 변환
            if let authorizationCode = appleIdCredential.authorizationCode,
               let authorizationCodeString = String(data: authorizationCode, encoding: .utf8) {
                print("Authorization Code: \(authorizationCodeString)")
                // authorizationCodeString 사용
            } else {
                print("authorizationCode를 문자열로 변환할 수 없습니다.")
            }
            
            let identityToken = appleIdCredential.identityToken
            let authorizationCode = appleIdCredential.authorizationCode
            
            print("Apple ID 로그인에 성공하였습니다.")
            print("사용자 ID: \(userIdentifier)")
            print("전체 이름: \(fullName?.givenName ?? "") \(fullName?.familyName ?? "")")
            print("이메일: \(email ?? "")")
            print("Token: \(identityToken!)")
            print("authorizationCode: \(authorizationCode!)")
            
            // 여기에 로그인 성공 후 수행할 작업을 추가하세요.
            delegate?.didCompleteAppleLogin(userId: userIdentifier, email: email)
            
        // 암호 기반 인증에 성공한 경우(iCloud), 사용자의 인증 정보를 확인하고 필요한 작업을 수행합니다
        case let passwordCredential as ASPasswordCredential:
            let userIdentifier = passwordCredential.user
            let password = passwordCredential.password
            
            print("암호 기반 인증에 성공하였습니다.")
            print("사용자 이름: \(userIdentifier)")
            print("비밀번호: \(password)")
            
            // 여기에 로그인 성공 후 수행할 작업을 추가하세요.
            delegate?.didCompleteAppleLogin(userId: userIdentifier, email: "")
            
        default: break
            
        }
    }
}
