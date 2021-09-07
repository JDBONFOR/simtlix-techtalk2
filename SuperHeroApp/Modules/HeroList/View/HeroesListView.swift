import SwiftUI

struct HeroesListView: View {
    
    @ObservedObject var viewModel = HeroesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    
                    NavigationLink(destination: HeroDetailView(HeroDetailViewModel(hero.id)),
                                   label: {
                                    HeroListRowView(heroName: hero.name,
                                                    heroImage: hero.images.lg)
                                   })
                    
                    
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                viewModel.getAllHeroes()
            }
        }
    }
}

struct HeroesListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesListView()
    }
}
