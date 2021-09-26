//
//  Course.swift
//  NetWorking
//
//  Created by Александр on 23.09.21.
//

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescription: Decodable  {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
