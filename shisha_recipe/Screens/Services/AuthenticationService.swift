import Firebase
import FirebaseAuth

class AuthenticationService {
    static let shared = AuthenticationService()
    private let auth = Auth.auth()
    private init() {}
    
    func signUp(emailAddress: String, password: String, name: String, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: emailAddress, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let authResult = authResult else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
                return
            }
            
            let user = User(id: authResult.user.uid, name: name, email: emailAddress, imageURL: nil)
            self.saveUserToFirestore(user) { result in
                switch result {
                case.success:
                    completion(.success(user))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let userId = authResult?.user.uid else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"])))
                return
            }
            
            self.fetchUser(userId: userId, completion: completion)
        }
    }
    
    private func saveUserToFirestore(_ userData: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let userDict: [String: Any] = [
            "id": userData.id,
            "name": userData.name,
            "email": userData.email,
            "imageURL": userData.imageURL as Any
        ]
        
        Firestore.firestore().collection("users").document(userData.id).setData(userDict) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private func fetchUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        Firestore.firestore().collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user data found"])))
                return
            }
            
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let email = data["email"] as? String else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data"])))
                return
            }
            
            let imageURL = data["imageURL"] as? String
            
            let user = User(id: id, name: name, email: email, imageURL: imageURL)
            completion(.success(user))
        }
    }
}
