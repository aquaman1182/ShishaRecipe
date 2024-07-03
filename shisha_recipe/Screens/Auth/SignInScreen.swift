import SwiftUI
import FirebaseAuth

struct SignInScreen: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    let onSignInSuccess: () -> Void
    let onSignUpRequest: () -> Void

    var body: some View {
        VStack {
            Text("ログイン")
                .font(.title)
                .bold()
            TextField("メールアドレス", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("ログイン") {
                signIn()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(25)
            .padding()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            Button("新規登録がまだの方") {
                onSignUpRequest()
            }
            
        }
    }
    
    private func signIn() {
        AuthenticationService.shared.signIn(email: emailAddress, password: password) { result in
            switch result {
            case .success(let user):
                print("🎉ログイン成功")
                onSignInSuccess()
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}
