import SwiftUI
import FirebaseAuth

struct SignUpScreen: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text("新規登録")
                .font(.title)
                .bold()
            TextField("名前", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("メールアドレス", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("新規登録") {
                signUp()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(25)
        }
    }
    
    private func signUp() {
        AuthenticationService.shared.signUp(emailAddress: emailAddress, password: password, name: name)  { result in
            switch result {
            case .success(let user):
                print("新規登録完了: \(user.name)")
            case .failure(let error):
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}

#Preview {
    SignUpScreen()
}
