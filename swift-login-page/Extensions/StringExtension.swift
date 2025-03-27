import Foundation

extension String {
    enum ValidTypes {
        case name
        case email
        case phoneNumber
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-z0-9._]+@[a-z]+\\.[a-z]{2,}"
        case phoneNumber = "[0-9]{10,10}"
        case password = "(?=.*[A-Z])(?=.*[a-z]).{6,}"
    }
    
    func isValid(validtype: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        switch validtype {
        case .name:
            regex = Regex.name.rawValue
        case .phoneNumber:
            regex = Regex.phoneNumber.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}
