import Foundation
import SwiftUI

final class HeroesViewModel: ObservableObject {
    @Published var heroes: [HeroeListModel] = []
    @Published var showLoading: Bool = true
    
    private var client = NetworkingProvider.shared
    
    func getAllHeroes() {
        
        guard let endpoints = Utils.getEndpoints() else { return }
        guard let endpointsData = endpoints[Constants.EndpointKeys.heroes] as? [String: Any] else { return }
        guard let urlString = endpointsData[Constants.EndpointKeys.url] as? String else { return }
        
        let urlFormatted = String(format: urlString, arguments: ["all.json"])
        let url = Constants.baseUrl + urlFormatted
                
        client.fetchData(url: url) { ( result: [HeroeListModel]?, error) in
            self.showLoading = false
            if let error = error {
                print(error)
            } else if let result = result {
                self.heroes = result
            }
        }        
    }
}
