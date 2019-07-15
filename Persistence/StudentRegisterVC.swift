//
//  StudentRegisterVC.swift
//  Persistence
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 NessaHope. All rights reserved.
//

import UIKit

class StudentRegisterVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var semseterTF: UITextField!
    @IBOutlet weak var studentIDTF: UITextField!
    @IBOutlet weak var passwordLoginTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if studentDao!.getAllUsers().isEmpty {
            var student = Student(context: studentDao!.getManagedContext()!)
            _ = studentDao!.saveStudent(student: studentForm(name: "nessa", semester: "fall", password: "a", stID: "st1820"))
        }
    }
    
    @IBAction func RegisterTapped(_ sender: Any) {
        
        let name = nameTF.text!
        let pass = passwordTF.text!
        let sem = semseterTF.text!.lowercased()
        
        let newStudent = studentForm(name: name, semester: sem, password: pass, stID: createStudentID(semester: sem))
        studentDao?.saveStudent(student: newStudent)
        print(newStudent.stID)
    
    }
    
    func createStudentID(semester:String) -> String{
        switch semester.lowercased() {
        case "winter":
            let id = "180\(studentDao?.getAllUsers().count)"
            return id
        case "summer":
            let id = "181\(studentDao?.getAllUsers().count)"
            return id
        case "fall":
            let id = "182\(studentDao?.getAllUsers().count)"
            return id
        default:
            return "N/A"
        }
        
    }
    
    
    @IBAction func LoginTapped(_ sender: Any) {
        
        shouldPerformSegue(withIdentifier: "studentLogin", sender: self)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "studentLogin"{
            if true{
                let id = studentIDTF.text!
                let password = passwordLoginTF.text!
                if let student = studentDao?.getStudentByID(id: id){
                    if student.password! == password{
                        return true
                    } else {
                        return false
                    }
                }
            }
        }
        return false
    }

}
