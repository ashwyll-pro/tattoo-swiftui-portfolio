//
//  DependencyContainer.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 06/07/2025.
//

class DependencyContainer {
    static let shared = DependencyContainer()
    
    func makeMyTattoosViewModel() -> MyTattoosViewModel{
       // let myTattooLocalSource = MyTattooLocalSource()
        //let localMyTattooRepositoryImp = LocalMyTattooRepositoryImp(myTattooLocalSource: myTattooLocalSource)

        //saved from local
        let savedTattooImageDataSource = SavedTattooImageDataSource()
        let savedTattooImageRepositoryImp = SavedTattooImageRepositoryImp(savedTattooImageDataSource: savedTattooImageDataSource)
       
        //mock data
        //let mockSavedTattooDataSource = MockSavedTattooDataSource()
        //let mockSavedTattooRepositoryImp = MockSavedTattooRepositoryImp(mockSavedTattooDataSource: mockSavedTattooDataSource)
        
        let savedTattooImageUseCase = SavedTattooImageUseCase(savedTattooImageRepository: savedTattooImageRepositoryImp)

         return MyTattoosViewModel(savedTattooImageUseCase: savedTattooImageUseCase)
    }
    
    func makeDashboardViewModel() -> DashboardViewModel{
        let tattooStyleLocalSource = TattooStyleLocalSource()
        let localTattooStyleRepositoryImp = LocalTattooStyleRepositoryImp(tattooStyleLocalSource: tattooStyleLocalSource)
        let tattooStyleUseCase = TattooStyleUseCase(tattooStyleRepository: localTattooStyleRepositoryImp)
        return DashboardViewModel(tattooStyleUseCase: tattooStyleUseCase)
    }
    
    func makeTattooGenerationModel()->TattooGenerationViewModel{
        let generationLimitRepositoryImp = GenerationLimitRepositoryImp()
        let generationLimitUseCase = GenerationLimitUseCase(generationLimitRepository: generationLimitRepositoryImp)
        
        let tattooStyleLocalSource = TattooStyleLocalSource()
        let localTattooStyleRepositoryImp = LocalTattooStyleRepositoryImp(tattooStyleLocalSource: tattooStyleLocalSource)
        let tattooStyleUseCase = TattooStyleUseCase(tattooStyleRepository: localTattooStyleRepositoryImp)
        
        return TattooGenerationViewModel(generationLimitUseCase: generationLimitUseCase, tattooStyleUseCase: tattooStyleUseCase)
    }
    
    func makeProcessingTattooModel() -> ProcessingTattooViewModel{
        let myTattooRemoteSource = MyTattooRemoteSource()
        let remoteMyTattooRepositoryImp = RemoteMyTattooRepositoryImp(myTattooRemoteSource: myTattooRemoteSource)
        let myTattooUseCase = MyTattooUseCase(myTattooRepository: remoteMyTattooRepositoryImp)
        
        let generationLimitRepositoryImp = GenerationLimitRepositoryImp()
        let generationLimitUseCase = GenerationLimitUseCase(generationLimitRepository: generationLimitRepositoryImp)
        return ProcessingTattooViewModel(myTattooUseCase: myTattooUseCase, generationLimitUseCase: generationLimitUseCase)
    }
    
    func makeDiscoveryModel() -> DiscoverViewModel{
        //let mockMyTattooDiscoverySource = MockMyTattooDiscoverySource()
        //let mockMyTattooDiscoveryRepositoryImp = MockDiscoveryImp(mockMyTattooDiscoverySource: mockMyTattooDiscoverySource)
        let myTattooDiscoveryRemoteSource = MyTattooDiscoveryRemoteSource()
        let discoveryRepositoryImp = DiscoveryRepositoryImp(myTattooDiscoveryRemoteSource: myTattooDiscoveryRemoteSource)
        
        let discoverUseCase = DiscoveryUseCase(discoveryRepository: discoveryRepositoryImp)
        return DiscoverViewModel(discoverUseCase: discoverUseCase)
    }
}
