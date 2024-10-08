import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerNetworkWorker()
        registerAPIService()
        registerAPIRepository()
        registerLoginViewModel()
        registerFeedViewModel()
    }
    
    private static func registerNetworkWorker() {
        register { NetworkWorker() }
            .implements(NetworkWorkerProtocol.self)
    }
    
    private static func registerAPIService() {
        register { APIService() }
            .implements(APIServiceProtocol.self)
    }
    
    private static func registerAPIRepository() {
        register { APIRepository() }
            .implements(APIRepositoryProtocol.self)
    }
    
    private static func registerLoginViewModel() {
        register { LoginViewModel() }
            .implements(LoginViewModelProtocol.self)
    }
    
    private static func registerFeedViewModel() {
        register { FeedCollectionViewModel() }
            .implements(FeedCollectionViewModelProtocol.self)
    }
}
