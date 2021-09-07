import SwiftUI

struct HeroesListView: View {
    
    @ObservedObject var viewModel = HeroesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                HeroListRowView(heroName: "Personaje 1",
                                heroImage: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")
                HeroListRowView(heroName: "Personaje 2",
                                heroImage: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")
                HeroListRowView(heroName: "Personaje 3",
                                heroImage: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")
                HeroListRowView(heroName: "Personaje 4",
                                heroImage: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")
            }
            .navigationTitle("Characters")
        }
    }
}

struct HeroesListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesListView()
    }
}
