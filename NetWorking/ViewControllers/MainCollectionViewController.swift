//
//  MainCollectionViewController.swift
//  NetWorking
//
//  Created by Александр on 23.09.21.
//

import UIKit

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case ourCoursesV2 = "Capital to Lowcase"
    case postRequestWithDict = "POST RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
    case alamofireGet = "Alamofire GET"
    case alamofirePost = "Alamofire POST"
}

class MainCollectionViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
    
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }

    // метод позволяет узнать на какую ячейку мы нажали и сделать соответствующий переход
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne: exampleOneButtonPressed()
        case .exampleTwo: exampleTwoButtonPressed()
        case .exampleThree: exampleThreeButtonPressed()
        case .exampleFour: exampleFourButtonPressed()
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .ourCoursesV2: performSegue(withIdentifier: "showCoursesV2", sender: nil)
        case .postRequestWithDict: postRequestWithDictionary()
        case .postRequestWithModel: postRequestWithModel()
        case .alamofireGet: performSegue(withIdentifier: "alamofireGet", sender: nil)
        case .alamofirePost: performSegue(withIdentifier: "alamofirePost", sender: nil)
        }
    }
    
    //MARK: - Navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier != "showImage" {
        guard let coursesVC = segue.destination as? CoursesViewController else { return }
        switch segue.identifier {
        case "showCourses": coursesVC.fetchCourses()
        case "showCoursesV2": coursesVC.fetchCoursesV2()
        case "alamofireGet": coursesVC.alamofireGetButtonPressed()
        case "alamofirePost": coursesVC.alamofirePostButtonPressed()
        default: break
        }
    }
}
    
    //MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

    //MARK: - Networking
extension MainCollectionViewController {
    private func exampleOneButtonPressed() {
        NetworkManager.shared.fetch(dataType: Course.self, from: Link.exampleOne.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleTwoButtonPressed() {
        NetworkManager.shared.fetch(dataType: [Course].self, from: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.successAlert()
                for course in courses {
                    print("Course \(course.name ?? "")")
                }
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleThreeButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, from: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleFourButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, from: Link.exampleFour.rawValue) { result in
            switch result {
            case .success(let websiteDescription):
                self.successAlert()
                print(websiteDescription)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func postRequestWithDictionary() {
        let course = [
            "name": "Networking",
            "imageUrl": "image url",
            "numberOfLessons": "10",
            "numberOfTests": "8"
        ]
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = CourseV3(
            name: "Networking",
            imageUrl: Link.courseImageURL.rawValue,
            numberOfLessons: "10",
            numberOfTests: "5"
        )
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
}

// протокол позволяет настоить внешний вид ячейки
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
