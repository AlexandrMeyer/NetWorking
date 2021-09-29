//
//  TableViewController.swift
//  NetWorking
//
//  Created by Александр on 23.09.21.
//

import UIKit
import Alamofire

class CoursesViewController: UITableViewController {
    
    private var courses: [Course] = []
    private var coursesV2: [CourseV2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.isEmpty ? coursesV2.count : courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        if courses.isEmpty {
            let courseV2 = coursesV2[indexPath.row]
            cell.configure(with: courseV2)
        } else {
            let course = courses[indexPath.row]
            cell.configure(with: course)
        }
        return cell
    }
}

// MARK: - Navigation
extension CoursesViewController {
    func fetchCourses() {
        NetworkManager.shared.fetch(dataType: [Course].self, from: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.courses = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCoursesV2() {
        NetworkManager.shared.fetch(
            dataType: [CourseV2].self,
            from: Link.exampleFive.rawValue,
            convertFromSnakeCase: false
        ) { result in

            switch result {
            case .success(let courses):
                self.coursesV2 = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alamofireGetButtonPressed() {
        NetworkManager.shared.fetchDataWithAlanofire(Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.courses = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
                    //  // Пример ручного создания
                    //     guard let coursesData = value as? [[String: Any]] else { return }
                    //     for courseData in coursesData {
                    //      let course = Course(
                    //          name: coursesData["name"] as? String,
                    //          imageUrl: coursesData["imageUrl"] as? String,
                    //          numberOfLessons: coursesData["number_of_lessons"] as? Int,
                    //          numberOfTests: coursesData["number_of_tests"] as? Int
                    //                            )
                    //    self.courses.append(course)
                    //  }
                    //     DispatchQueue.main.async {
                    //     self.tableView.reloadData()
                    //     }
                    
                    // Пример ручного создания (если не использовать .validate())
                    //                guard let statusCode = dataResponse.response?.statusCode else { return }
                    //
                    //                print("StatusCOde: ", statusCode)
                    //
                    //                if (200..<300).contains(statusCode) {
                    //                    guard let value = dataResponse.value else { return }
                    //                        print("Value: ", value)
                    //                } else {
                    //                    guard let error = dataResponse.error else { return }
                    //                    print(error)
                    //                    }
                    
                    }
                }
        
        func alamofirePostButtonPressed() {
            let course = CourseV3(
                name: "Networking",
                imageUrl: Link.courseImageURL.rawValue,
                numberOfLessons: "10",
                numberOfTests: "5"
            )
            
            NetworkManager.shared.postDataWithAlanofire(Link.postRequest.rawValue, data: course) { result in
                switch result {
                case .success(let course):
                    self.courses.append(course)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    

