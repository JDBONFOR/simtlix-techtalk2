
import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var heroesViewModel = HeroesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(heroesViewModel.heroes, id: \.id) { hero in
                    NavigationLink(
                        destination: HeroDetailView(hero: hero),
                        label: {
                            HeroListRowView(hero: hero)
                        })
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                heroesViewModel.getAllHeroes()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class HeroesViewModel: ObservableObject {
    
    @Published var heroes: [Hero] = []
    @Published var hero: Hero? = nil
    
    private var client = NetworkingProvider.shared
    
    func getAllHeroes() {
        if let data = client.loadHeroesJson() {
            self.heroes = data.heroes
        }
    }
    
    func getCharacter() {
        client.fetchData(url: Constants.baseUrl + "71", callback: { (response: Hero?, error: Error?) in
            if let hero = response {
                self.hero = hero
            }
        })
    }
}

struct HeroListRowView: View {
    let hero: Hero
    
    var body: some View {
        HStack {
            if let image = hero.images.url,
               let url = URL(string: image) {
                WebImage(url: url)
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
            } else {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.title3)
                    .foregroundColor(.accentColor)
                Text("\(hero.appearance.race ?? "-")")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .redacted(reason: hero.appearance.race == "null" ? .placeholder : [])
            }
        }
    }
}

///

struct HeroDetailView: View {
    let hero: Hero
    
    var body: some View {
        List {
            Section(header: Text("Mugshot")) {
                HStack {
                    Spacer()
                    if let image = hero.images.url,
                       let url = URL(string: image) {
                        WebImage(url: url)
                            .resizable()
                            .placeholder {
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.gray)
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(25)
                    } else {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
            
            Section(header: Text("Work info")) {
                Text("Occupation: \(hero.work.occupation)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            infoSection
            powerStatsSection
            locationSection

//            if let episodes = hero?.episode?.compactMap{ $0 } {
//                Section(header: Text("Episodes")) {
//                    ForEach(episodes, id: \.id) { episode in
//                        NavigationLink(
////                            destination: EpisodeDetailView(id: episode.id!),
//                            destination: EmptyView(),
//                            label: {
//                                HStack {
//                                    Text(episode.name!)
//                                    Spacer()
//                                    Text(episode.airDate!)
//                                        .foregroundColor(.gray)
//                                        .font(.footnote)
//                                }
//                            })
//                    }
//                }
//            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(hero.name)
    }
    
    private var infoSection: some View {
        Section(header: Text("Info"),
                content: {
                    InfoRowView(label: "Species",
                                icon: "figure.stand",
                                value: hero.appearance.race ?? "-")
                    InfoRowView(label: "Gender",
                                icon: "face.smiling",
                                value: hero.appearance.gender)
                    InfoRowView(label: "Eye color",
                                icon: "eye",
                                value: hero.appearance.eyeColor)
                    InfoRowView(label: "Hair color",
                                icon: "wind",
                                value: hero.appearance.hairColor)
                })
    }
    
    private var powerStatsSection: some View {
        Section(header: Text("Powerstats"),
                content: {
                    ProgressInfoRowView(label: "Strength",
                                        icon: "flame",
                                        value: hero.powerstats.strength,
                                        percentValue: hero.powerstats.strengthPercent,
                                        color: .blue)
                    ProgressInfoRowView(label: "Speed",
                                        icon: "hare",
                                        value: hero.powerstats.speed,
                                        percentValue: hero.powerstats.speedPercent,
                                        color: .green)
                    ProgressInfoRowView(label: "Intelligence",
                                        icon: "leaf",
                                        value: hero.powerstats.intelligence,
                                        percentValue: hero.powerstats.intelligencePercent,
                                        color: .red)
                    ProgressInfoRowView(label: "Power",
                                        icon: "bolt",
                                        value: hero.powerstats.power,
                                        percentValue: hero.powerstats.powerPercent,
                                        color: .orange)
                    ProgressInfoRowView(label: "Combat",
                                        icon: "person",
                                        value: hero.powerstats.combat,
                                        percentValue: hero.powerstats.combatPercent,
                                        color: .black)
                    ProgressInfoRowView(label: "Durability",
                                        icon: "figure.walk",
                                        value: hero.powerstats.durability,
                                        percentValue: hero.powerstats.durabilityPercent,
                                        color: .purple)
                })
    }
    
    private var locationSection: some View {
        Section(header: Text("Location")) {
            NavigationLink(
                destination:
                    EmptyView(),
                label: {
                    InfoRowView(label: "Location",
                                icon: "map",
                                value: hero.biography.fullName)
                })
            NavigationLink(
                destination:
                    EmptyView(),
                label: {
                    InfoRowView(label: "Origin",
                                icon: "paperplane",
                                value: hero.biography.placeOfBirth)
                })
        }
    }
}

struct InfoRowView: View {
    let label: String
    let icon: String
    let value: String
    
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text(value)
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
        }
    }
}

struct ProgressInfoRowView: View {
    let label: String
    let icon: String
    let value: Int
    let percentValue: Float
    let color: Color
    
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text("\(value)")
            ProgressBar(value: percentValue, color: color)
                .frame(width: 50, height: 10)
        }
    }
}

struct ProgressBar: View {
    var value: Float
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(color)
                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}
