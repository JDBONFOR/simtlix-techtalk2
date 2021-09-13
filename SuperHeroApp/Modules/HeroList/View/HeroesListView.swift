import SwiftUI

struct HeroesListView: View {
    
    @ObservedObject var viewModel = HeroesViewModel()
    @State var darkMode: Bool = false
    
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
                                    HeroListCellView(hero: hero)
                                })
                        }
                    }
                    .navigationBarTitle("Characters", displayMode: .automatic)
                    .navigationBarItems(trailing:
                        Button(action: {
                            darkMode.toggle()
                        }) {
                            Image(systemName: "switch.2")
                        }
                    )
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
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
