import SwiftUI

struct HeroesListView: View {
    
    @ObservedObject var viewModel = HeroesViewModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.showLoading {
                LoaderView()
            } else {
                NavigationView {
                    List {
                        ForEach(viewModel.heroes, id: \.id) { hero in
                            NavigationLink(
                                destination: HeroDetailView(hero.id),
                                label: {
                                    HeroListRowView(hero: hero)
                                })
                        }
                    }
                    .navigationTitle("Characters")
                }
            }
        }
        .onAppear {
            viewModel.getAllHeroes()
        }
    }
}

struct HeroesListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesListView()
    }
}
