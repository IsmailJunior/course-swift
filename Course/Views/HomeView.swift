import SwiftUI

class CourseViewModel: ObservableObject {
    
    // Data from api
    @Published var courses: [Course] = []
    
    // Initializing
    init() {
        getData(isAsync: false)
    }
    // Append data function has two types asyncAfter and async
    func appendData(fromData data: Data, isAsync: Bool) {
        // Decode the payload data coming from the URL
        guard let data = try? JSONDecoder().decode([Course].self, from: data) else {return}
        // Append the payload data to courses array (on the main thread)
        if isAsync {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.courses.append(contentsOf: data)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.courses.append(contentsOf: data)
            }
        }
    }
    
    // Refresh function
    func update() async {
        DispatchQueue.main.async { [weak self] in
            self?.courses.removeAll()
        }
        getData(isAsync: true)
    }
    
    // Fetch and append data Function
    func getData(isAsync async: Bool) {
        // URL
        guard let url = URL(string: "http://localhost:8080/") else { return }
    
        // Escaping Function
        downloadData(fromUrl: url) { [weak self] returnedData in
            if let data = returnedData {
                print("Check if Downloading data is on main thread: \(Thread.isMainThread)")
                print("Check if Downloading data is on main thread: \(Thread.current)")
                
                // Append Data
                if async {
                    self?.appendData(fromData: data, isAsync: true)
                } else {
                    self?.appendData(fromData: data, isAsync: false)
                }
            } else {
                print("No data returned.")
            }
        } // downloadData
        
        // Async Function
        func downloadData(fromUrl url: URL, competionHandler: @escaping (_ data: Data?) -> ()) {
            
            // Download Data Task
            URLSession.shared.dataTask(with: url) { data, response , error in
                // Check if there data
                guard let data = data,
                // Check if there's no error
                    error == nil,
                // Check if the response is an http response
                    let response = response as? HTTPURLResponse,
                // Check if the status code is a successful code
                    response.statusCode >= 200 && response.statusCode < 300
                else {
                    print("Error downloading data.")
                // Clean up the the payload and do not append anything to courses array if there an error
                    competionHandler(nil)
                    return
                }
                // Pass the payload data coming from the url to escaping function to decode and append
                competionHandler(data)
            } // URLSession
            .resume()
        }
    } // getData
} // CourseViewModel

struct HomeView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModelData = CourseViewModel()
    var columns: [GridItem] = [GridItem(.flexible()),]
    @State private var isBadgeModalShowing: Bool = false
    var checkMarkColors: [Color] = [.blue, .cyan]
    // MARK: BODY
    
    var body: some View {
        NavigationStack {
                MainContent
                .blurredSheet(.init(.ultraThinMaterial), show: $isBadgeModalShowing) {
                } content: {
                    Bagde
                        .presentationDetents([.fraction(0.30)])
                        .presentationDragIndicator(.visible)
                }
        } // NavigationStack
    }
    // MARK: VIEWS
    private var MainContent: some View {
        VStack {
            ScrollView {
                Text("Lectures")
                    .thickText()
                Text(month())
                    .thickText()
                    .foregroundColor(.gray)
                Divider()
                    .background(Color.gray)
                    .padding(.horizontal, 20)
                LazyVGrid(columns: columns) {
                    ForEach(viewModelData.courses) { day in
                        VStack {
                            Text(day.day)
                                .thickText()
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                            TabView {
                                ForEach(day.lectures) {lecture in
                                    CardView(title: lecture.title, description: lecture.description, instructor: lecture.instructor, duration: lecture.duration, time: lecture.time, hall: lecture.hall, isBadgeModalShowing: $isBadgeModalShowing)
                                }
                            } // TabView
                            .frame(width: 380 ,height: 450)
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .shadow(color: .gray.opacity(0.3), radius: 10, y: 20)
                        } // VStack
                    }
                } // LazyVGrid
            } // ScrollView
            .scrollIndicators(ScrollIndicatorVisibility.never)
            .refreshable {
               await viewModelData.update()
            }
        } // VStack
    } // TabContent
    
    // MARK: VIEWS
    private var Bagde: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .checkMark(size: 50, forgroundColors: checkMarkColors, shadowColor: .cyan)
                .background(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30)
                )
            Divider()
            Text("This instructor is qualified to teach in this organization.")
                .font(.headline)
                .multilineTextAlignment(.center)
        } // VStack
    } // Badge
}
    // MARK: PREVIEW
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .preferredColorScheme(.light)
        }
    }
