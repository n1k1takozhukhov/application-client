import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
//        registerServices()
        registerLoginViewModel()
    }
    
//    private static func registerServices() {
//        register { } //network
//    }
    
    private static func registerLoginViewModel() {
        register { LoginViewModel() }
            .implements(LoginViewModelProtocol.self)
    }
}
