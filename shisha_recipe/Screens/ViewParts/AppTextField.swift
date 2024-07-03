import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(keyboardType)
            .autocapitalization(.sentences)
            .disableAutocorrection(false)
            .padding(.vertical, 8)
    }
}
