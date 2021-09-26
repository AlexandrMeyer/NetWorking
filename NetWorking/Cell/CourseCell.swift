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
        numberOfLessons.text = "Number of lessons: \(course.number_of_lessons ?? 0)"
        numberOfTests.text = "Number of tests: \(course.number_of_tests ?? 0)"
        DispatchQueue.global().async {
            guard let url = URL(string: course.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.courseImageView.image = UIImage(data: imageData)
        }
     }
   }
}
