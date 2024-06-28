import Firebase
import FirebaseFireStoreSwift

class AuthenticationService {
    static let shared = AuthenticationService()
    private init() {}
    
    func signUp(email: String, password: String, name: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>)
    }
}
