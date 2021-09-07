import Foundation
import SwiftUI

final class HeroDetailViewModel: ObservableObject {
    @Published var hero: Hero?
    
    private var client = NetworkingProvider.shared
    var id: Int
    
    init(_ id: Int) {
        self.id = id
    }
    
    func getHeroDetail() {
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.heroe] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: [String(self.id)])
        let url = Constants.baseUrl + urlFormatted
        
        client.fetchData(url: url) { ( result: Hero?, error) in
            if let error = error {
                print(error)
            } else if let result = result {
                self.hero = result
            }
        }
        
    }
    
}
