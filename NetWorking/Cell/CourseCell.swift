//
//  CourseCell.swift
//  NetWorking
//
//  Created by Александр on 23.09.21.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet var courseImageView: UIImageView!
    
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        DispatchQueue.global().async {
            guard let url = URL(string: course.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.courseImageView.image = UIImage(data: imageData)
        }
        }
   }
    
    func configure(with courseV2: CourseV2) {
        courseNameLabel.text = courseV2.name
        numberOfLessons.text = "Number of lessons: \(courseV2.numberOfLessons ?? 0)"
        numberOfTests.text = "Number of tests: \(courseV2.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: courseV2.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.courseImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
