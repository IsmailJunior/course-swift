import SwiftUI


// MARK: CUSTOME VIEW MODIFIER
extension View {
    
    func blurredSheet<Content: View>(_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .sheet(isPresented: show, onDismiss: onDismiss) {
                content()
                    .background(RemoveBackgroundColor())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    )
            }
    }
}

// MARK: HELPER VIEW
fileprivate struct RemoveBackgroundColor:  UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
}


// MARK: CORNER RADIUS HELPER

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


// MARK: CHECKMARK HELPER

extension Image {
    func checkMark(size: CGFloat, forgroundColors: [Color], shadowColor: Color) -> some View {
        self
            .font(.system(size: size))
            .foregroundStyle(
                LinearGradient(gradient: Gradient(colors: forgroundColors), startPoint: .leading, endPoint: .trailing)
            )
            .shadow(color: shadowColor.opacity(0.2) ,radius: 2, x: 3, y: 3);
    }
}

// MARK: TITLES HELPER

extension Text {
    func thickText() -> some View {
        self
            .font(.largeTitle)
            .fontWeight(.heavy)
            .padding(.horizontal, 25)
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        
    }
}
