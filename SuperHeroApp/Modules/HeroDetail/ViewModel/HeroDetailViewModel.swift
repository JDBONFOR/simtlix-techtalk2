import Foundation
import SwiftUI

final class HeroDetailViewModel: ObservableObject {
    @Published var hero: Hero?
    @Published var showLoading: Bool = true
    
    private var client = NetworkingProvider.shared
    var id: Int = 0
    
    func getHeroDetail() {
        guard let url = Utils.getResource(resourceType: .hero(id: id)) else {
            print("Resource error")
            return
        }
        
        client.fetchData(url: url) { ( result: Hero?, error) in
            self.showLoading = false
            if let error = error {
                print(error)
            } else if let result = result {
                self.hero = result
            }
        }
    }
}

