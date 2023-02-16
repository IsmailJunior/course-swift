import Foundation

struct Lecture: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let instructor: String
    let duration: String
    let time: String
    let image: String
    let hall: String
}

struct Course: Identifiable, Codable {
    let id: Int
    let day: String
    let lectures: [Lecture]
}
