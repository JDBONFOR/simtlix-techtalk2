import SwiftUI
import SDWebImageSwiftUI

struct HeroDetailView: View {
    @ObservedObject var viewModel: HeroDetailViewModel = HeroDetailViewModel()
    
    init(_ id: Int) {
        viewModel.id = id
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
         
            if viewModel.showLoading {
                
               LoaderView()
                
            } else if let hero = viewModel.hero {
                
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
                        Text("Occupation: ")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    
                    infoSection(hero: hero)
                    powerStatsSection(hero: hero)
                    locationSection(hero: hero)
                    
                }
                .listStyle(GroupedListStyle())
                .navigationTitle(hero.name)
                
            }
        }
        .onAppear {
            viewModel.getHeroDetail()
        }
    }
}
    
struct infoSection: View {
    let hero: Hero
    
    var body: some View {
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
}

struct powerStatsSection: View {
    let hero: Hero
    
    var body: some View {
        
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
}

struct locationSection: View {
    let hero: Hero
    
    var body: some View {
        
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
