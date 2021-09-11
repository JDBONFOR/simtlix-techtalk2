import Foundation
import SwiftUI

final class HeroesViewModel: ObservableObject {
    @Published var heroes: [HeroListModel] = []
    @Published var showLoading: Bool = true
    
    private var client = NetworkingProvider.shared
    
    func getAllHeroes() {
        guard let url = Utils.getResource(resourceType: .allHeroes) else {
            print("Resource error")
            return
        }
                
        client.fetchData(url: url) { ( result: [HeroListModel]?, error) in
            self.showLoading = false
            if let error = error {
                print(error)
            } else if let result = result {
                print(result)
                self.heroes = result
            }
        }        
    }
}
