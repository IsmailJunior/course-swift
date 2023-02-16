import SwiftUI

struct CardView: View {
     // MARK: PROPERTIES
    var title: String?
    var description: String?
    var instructor: String?
    var duration: String?
    var time: String?
    var hall: String?
    @Binding var isBadgeModalShowing: Bool
    var checkMarkColors: [Color] = [.blue, .cyan]
    // MARK: BODY
    var body: some View {
                    VStack {
                        HStack {
                            Text(title ?? "Literature")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(15)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(20, corners: [.bottomRight, .topLeft])
                                .offset(y: -5)
                            Spacer()
                            Text(description ?? "N/A")
                                .font(.headline)
                                .padding(20)
                        } // HStack
                        VStack {
                            Image(instructor ?? "DR.Israa")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .clipShape(Circle())
                                .padding()
                            Spacer()
                            Text("Our Host")
                                .font(.title3)
                                .fontWeight(.black)
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .trailing, endPoint: .leading)
                                )
                            HStack (alignment: .center, spacing: 15) {
                                Text(instructor ?? "DR.Israa")
                                    .font(.largeTitle)
                                Image(systemName: "checkmark.seal.fill")
                                    .checkMark(size: 20, forgroundColors: checkMarkColors,shadowColor: .cyan)
                                    .onTapGesture {
                                        isBadgeModalShowing.toggle()
                                    }
                            } // HStack
                            .padding(.vertical)
                        } // VStack
                        Spacer()
                        Divider()
                        HStack {
                           PropertyComponent(propertyName: duration ?? "50min", iconName: "hourglass")
                            PropertyComponent(propertyName: time ?? "@8:00", iconName: "clock")
                            PropertyComponent(propertyName: hall ?? "EC17", iconName: "paperclip")
                        } // HStack
                    } // VStack
                    .frame(width: 320, height: 450)
                    .background(.white)
                    .cornerRadius(20)
    }
}

// MARK: PREVIEW
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(isBadgeModalShowing: .constant(false))
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 300, height: 570))
    }
}
