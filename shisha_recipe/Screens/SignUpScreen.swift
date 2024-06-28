import SwiftUI

struct SignUpScreen: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Text("新規登録")
                .font(.title)
                .bold()
            TextField("メールアドレス", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("新規登録") {
                
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(25)
        }
    }
}

#Preview {
    SignUpScreen()
}
