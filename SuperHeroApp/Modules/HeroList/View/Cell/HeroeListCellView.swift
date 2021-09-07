import SwiftUI
import SDWebImageSwiftUI

struct HeroListRowView: View {
    let heroName: String
    let heroImage: String
    
    var body: some View {
        HStack {
            if let image = heroImage,
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
                Text(heroName)
                    .font(.title3)
                    .foregroundColor(.accentColor)
            }
            .padding(.leading, 20)
        }
    }
}

struct HeroListRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListRowView(heroName: "Prueba SimTLiX",
                        heroImage: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")
    }
}
