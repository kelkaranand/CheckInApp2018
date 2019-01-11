//
//  FilterStudentsViewController.swift
//  CheckIn
//
//  Created by Alexander Stevens on 1/7/19.
//  Copyright © 2019 Anand Kelkar. All rights reserved.
//

import UIKit

class FilterStudentsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let schoolPickerView = UIPickerView()
    let gradePickerView = UIPickerView()
    let schoolData = ["LJFF", "Hogwarts", "Durmstrang"]
    let gradeData = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons8-delete-filled-25"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.removeScreen), for: .touchUpInside)
        return button
    }()
    
    lazy var filterStudentsLabel: UnderLinedLabel = {
        let label = UnderLinedLabel()
        label.text = "Filter Students"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var studentsFromLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter students from: "
        return label
    }()
    
    lazy var schoolTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "School Name"
        textField.inputView = schoolPickerView
        textField.inputAccessoryView = setUpToolbar(functionType: #selector(cancelPicker))
        textField.addTarget(self, action: #selector(self.addSchoolPickerView), for: .touchUpInside)
        return textField
    }()
    
    lazy var gradeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Grade"
        textField.inputView = gradePickerView
        textField.inputAccessoryView = setUpToolbar(functionType: #selector(cancelPicker))
        textField.addTarget(self, action: #selector(self.addGradePickerView), for: .touchUpInside)
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.setTitle("Add", for: .normal)
        return button
    }()
    
    lazy var byLastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "By last name:"
        return label
    }()
    
    @objc func removeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addSchoolPickerView() {
        view.addSubview(schoolPickerView)
    }
    
    @objc func addGradePickerView() {
        view.addSubview(gradePickerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        preferredContentSize = CGSize(width: view.frame.width/2, height: view.frame.height/2)
        schoolPickerView.delegate = self
        schoolPickerView.dataSource = self
        gradePickerView.delegate = self
        gradePickerView.dataSource = self
        view.addSubview(xButton)
        view.addSubview(addButton)
        view.addSubview(filterStudentsLabel)
        view.addSubview(studentsFromLabel)
        view.addSubview(schoolTextField)
        view.addSubview(byLastNameLabel)
        view.addSubview(gradeTextField)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        xButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            xButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            xButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            xButton.widthAnchor.constraint(equalToConstant: 25),
            xButton.heightAnchor.constraint(equalToConstant: 25)
            ])
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width/4),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            filterStudentsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterStudentsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            filterStudentsLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        NSLayoutConstraint.activate([
            studentsFromLabel.topAnchor.constraint(equalTo: filterStudentsLabel.bottomAnchor, constant: 20),
            studentsFromLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ])
        NSLayoutConstraint.activate([
            schoolTextField.topAnchor.constraint(equalTo: studentsFromLabel.bottomAnchor, constant: 20),
            schoolTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ])
        
        
        NSLayoutConstraint.activate([
            byLastNameLabel.topAnchor.constraint(equalTo: schoolTextField.bottomAnchor, constant: 20),
            byLastNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ])
        
        NSLayoutConstraint.activate([
            gradeTextField.topAnchor.constraint(equalTo: byLastNameLabel.bottomAnchor, constant: 20),
            gradeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            ])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == schoolPickerView {
            return schoolData.count
        } else {
            return gradeData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == schoolPickerView {
            return schoolData[row]
        } else {
            return String(gradeData[row])
        }
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    func setUpToolbar(functionType: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: functionType)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        return toolbar
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == schoolPickerView {
            schoolTextField.text = schoolData[row]
        } else {
            gradeTextField.text = String(gradeData[row])
        }
    }
    
}
