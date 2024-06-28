import SwiftUI
import FirebaseAuth

struct SignInScreen: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

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
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    private func signIn() {
        AuthenticationService.shared.signIn(email: emailAddress, password: password) { result in
            switch result {
            case .success(let user):
                print("🎉ログイン成功")
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    SignInScreen()
}
