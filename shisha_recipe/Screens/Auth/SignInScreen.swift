import SwiftUI

struct SignInScreen: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""

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
                
            }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(25)
        }
    }
}

#Preview {
    SignInScreen()
}
