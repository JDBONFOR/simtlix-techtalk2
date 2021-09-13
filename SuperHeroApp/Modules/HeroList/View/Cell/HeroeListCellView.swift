import SwiftUI
import SDWebImageSwiftUI

struct HeroListCellView: View {
    let hero: HeroListModel
    
    var body: some View {
        HStack {
            if let image = hero.images.sm,
               let url = URL(string: image) {
                WebImage(url: url)
                    .resizable()
                    .placeholder {
                        ImagePlaceholderView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
            } else {
                ImagePlaceholderView()
            }
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.title3)
                    .foregroundColor(.accentColor)
            }
            .padding(.leading, 20)
        }
    }
}

struct HeroListRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListCellView(hero: HeroListModel(id: 1, name: "Prueba SimTLiX", images: HeroListImage(sm: "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/730-zatanna.jpg")))
    }
}

struct ImagePlaceholderView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .frame(width: 100, height: 100)
            .foregroundColor(.gray)
    }
}
