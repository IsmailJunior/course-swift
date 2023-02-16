import SwiftUI

struct PropertyComponent: View {
    // MARK: PROPERTIES
    var propertyName: String
    var iconName: String
    
    // MARK: BODY
    var body: some View {
        VStack (spacing: 5) {
            Image(systemName: iconName)
                .font(.title)
            Text(propertyName)
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

    // MARK: PREVIEW
struct PropertyComponent_Previews: PreviewProvider {
    static var previews: some View {
        PropertyComponent(propertyName: "Duration", iconName: "hourglass")
            .previewLayout(.sizeThatFits)
    }
}
