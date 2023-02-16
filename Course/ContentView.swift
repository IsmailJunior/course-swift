import SwiftUI

struct ContentView: View {
    // MARK: PROPERTIES
    
    // MARK: BODY
    var body: some View {
        NavigationStack {
            HomeView()
                .padding(.top ,5)
        } // NavigationStack
    }

}

// MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
