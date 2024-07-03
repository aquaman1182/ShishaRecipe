import SwiftUI

struct ContentView: View {
    @State private var currentScreen: AppScreen = .signIn
    
    var body: some View {
        Group {
            switch currentScreen {
            case .signIn:
                SignInScreen(
                    onSignInSuccess: { self.currentScreen = .home },
                    onSignUpRequest: { self.currentScreen = .signUp }
                )
            case .signUp:
                SignUpScreen(
                    onSignUpSuccess: { self.currentScreen = .home },
                    onSignInRequest: { self.currentScreen = .signIn }
                )
            case .home:
                HomeScreen()
            }
        }
    }
}
