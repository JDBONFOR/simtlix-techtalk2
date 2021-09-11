import SwiftUI
import Lottie

struct LoaderView: View {
    var body: some View {
        LottieView("superhero")
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
