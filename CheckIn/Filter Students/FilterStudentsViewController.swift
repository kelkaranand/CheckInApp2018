//
//  FilterStudentsViewController.swift
//  CheckIn
//
//  Created by Alexander Stevens on 1/7/19.
//  Copyright © 2019 Anand Kelkar. All rights reserved.
//

import UIKit

class FilterStudentsViewController: UIViewController, UIPickerViewDataSource {
    
    var schoolData = [String]()
    static var currentSelectedSchool: String?
    static var currentSelectedLastNameFilter: [String] = ["A", "A"]
    
    static var schoolFilterFlag = false
    static var nameFilterFlag = false
    
    fileprivate let alphabet = ["A","B","C","D","E","F","G",
                                "H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    let cardContrainerView: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        card.layer.cornerRadius = 10
        card.layer.shouldRasterize = false
        card.layer.borderWidth = 1
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowOffset = CGSize.zero
        card.layer.shadowRadius = 10
        return card
    }()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "wyuDMzgk"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let schoolPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    let lastNamePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var schoolFilterSwitch: UISwitch = {
        let schoolSwitch = UISwitch()
        schoolSwitch.isOn = FilterStudentsViewController.schoolFilterFlag
        schoolSwitch.addTarget(self, action: #selector(schoolFilterWasSwitched), for: .valueChanged)
        schoolSwitch.translatesAutoresizingMaskIntoConstraints = false
        return schoolSwitch
    }()
    
    
    lazy var lastNameFilterSwitch: UISwitch = {
        let schoolSwitch = UISwitch()
        schoolSwitch.isOn = FilterStudentsViewController.nameFilterFlag
        schoolSwitch.addTarget(self, action: #selector(nameFilterWasSwitched), for: .valueChanged)
        schoolSwitch.translatesAutoresizingMaskIntoConstraints = false
        return schoolSwitch
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
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Only check in students from: "
        return label
    }()
    
    lazy var byLastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Only check in students with the last name:"
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var schoolContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    lazy var lastNameContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            //pickerLabel?.adjustsFontSizeToFitWidth = true
            //pickerLabel?.font = UIFont(name: "<Your Font Name>", size: <Font Size>)
            pickerLabel?.textAlignment = .center
            if pickerView == schoolPickerView {
                pickerLabel?.text = schoolData[row]
            } else {
                 pickerLabel?.text = String(alphabet[row])
            }
        }
        return pickerLabel!
    }

    @objc func addSchoolPickerView() {
        view.addSubview(schoolPickerView)
    }
    
    @objc func addGradePickerView() {
        view.addSubview(lastNamePickerView)
    }
    
    @objc func schoolFilterWasSwitched(){
        FilterStudentsViewController.schoolFilterFlag = schoolFilterSwitch.isOn
        if lastNameFilterSwitch.isOn {
            FilterStudentsViewController.nameFilterFlag = false
            lastNameFilterSwitch.isOn = false
        }
    }
    
    @objc func nameFilterWasSwitched(){
        FilterStudentsViewController.nameFilterFlag = lastNameFilterSwitch.isOn
        if schoolFilterSwitch.isOn {
            FilterStudentsViewController.schoolFilterFlag = false
            schoolFilterSwitch.isOn = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        schoolPickerView.delegate = self
        schoolPickerView.dataSource = self
        lastNamePickerView.delegate = self
        lastNamePickerView.dataSource = self
        
        
        let firstLetterIndex = returnIndexOfAlphabet(FilterStudentsViewController.currentSelectedLastNameFilter.first!)
        let lastLetterIndex = returnIndexOfAlphabet(FilterStudentsViewController.currentSelectedLastNameFilter.last!)
        lastNamePickerView.selectRow(firstLetterIndex, inComponent: 0, animated: false)
        lastNamePickerView.selectRow(lastLetterIndex, inComponent: 1, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.title = "Filter Students"
        let schools = CoreDataHelper.retrieveData("School")
        
        for school in schools {
            schoolData.append((school as AnyObject).value(forKey: "sname") as! String)
        }
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            backgroundImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height),
            backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width)
            
            ])
        
        view.addSubview(cardContrainerView)
        NSLayoutConstraint.activate([
            cardContrainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            cardContrainerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            cardContrainerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.8),
            cardContrainerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8)
            
            ])
        
        cardContrainerView.addSubview(schoolContainerView)
        schoolContainerView.addSubview(schoolPickerView)
        schoolContainerView.addSubview(schoolFilterSwitch)
        schoolContainerView.addSubview(studentsFromLabel)
        
        
        NSLayoutConstraint.activate([
            schoolContainerView.centerXAnchor.constraint(equalTo: cardContrainerView.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            schoolContainerView.topAnchor.constraint(equalTo: cardContrainerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            schoolContainerView.heightAnchor.constraint(equalToConstant: (view.frame.height * 0.4) - 20),
            schoolContainerView.widthAnchor.constraint(equalToConstant: (view.frame.width * 0.8) - 20)
            ])
        
        NSLayoutConstraint.activate([
            schoolPickerView.centerYAnchor.constraint(equalTo: schoolContainerView.centerYAnchor),
            schoolPickerView.centerXAnchor.constraint(equalTo: schoolContainerView.centerXAnchor),
            schoolPickerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25),
            schoolPickerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
            ])
        
        NSLayoutConstraint.activate([
            studentsFromLabel.topAnchor.constraint(equalTo: schoolContainerView.topAnchor, constant: 50),
            studentsFromLabel.centerXAnchor.constraint(equalTo: schoolContainerView.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            schoolFilterSwitch.topAnchor.constraint(equalTo: schoolPickerView.bottomAnchor, constant: 0),
            schoolFilterSwitch.centerXAnchor.constraint(equalTo: schoolContainerView.centerXAnchor)
            ])
        
        
        view.addSubview(lastNameContainerView)
        lastNameContainerView.addSubview(byLastNameLabel)
        lastNameContainerView.addSubview(lastNamePickerView)
        lastNameContainerView.addSubview(lastNameFilterSwitch)
        NSLayoutConstraint.activate([
            lastNameContainerView.centerXAnchor.constraint(equalTo: cardContrainerView.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            lastNameContainerView.topAnchor.constraint(equalTo: schoolContainerView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            lastNameContainerView.heightAnchor.constraint(equalToConstant: (view.frame.height * 0.4) - 20),
            lastNameContainerView.widthAnchor.constraint(equalToConstant: (view.frame.width * 0.8) - 20)            ])
        NSLayoutConstraint.activate([
            byLastNameLabel.topAnchor.constraint(equalTo: lastNameContainerView.topAnchor, constant: 50),
            byLastNameLabel.centerXAnchor.constraint(equalTo: lastNameContainerView.centerXAnchor),
            byLastNameLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
            ])
        NSLayoutConstraint.activate([
            lastNamePickerView.centerYAnchor.constraint(equalTo: lastNameContainerView.centerYAnchor),
            lastNamePickerView.centerXAnchor.constraint(equalTo: lastNameContainerView.centerXAnchor),
            lastNamePickerView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25),
            lastNamePickerView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
            ])
        
        NSLayoutConstraint.activate([
            lastNameFilterSwitch.topAnchor.constraint(equalTo: lastNamePickerView.bottomAnchor, constant: 0),
            lastNameFilterSwitch.centerXAnchor.constraint(equalTo: lastNameContainerView.centerXAnchor)
            ])
        
    }
    
    func returnIndexOfAlphabet(_ letter: String) -> Int {
        return self.alphabet.firstIndex(of: letter) ?? 0
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == schoolPickerView {
            // schoolPickerView.selectedRow(inComponent: 0). .text = schoolData[row]
            FilterStudentsViewController.currentSelectedSchool = schoolData[row]
        } else {
            FilterStudentsViewController.currentSelectedLastNameFilter.removeAll()
            FilterStudentsViewController.currentSelectedLastNameFilter.append(alphabet[lastNamePickerView.selectedRow(inComponent: 0)])
            FilterStudentsViewController.currentSelectedLastNameFilter.append(alphabet[lastNamePickerView.selectedRow(inComponent: 1)])
            
            
            let firstLetter = UnicodeScalar(FilterStudentsViewController.currentSelectedLastNameFilter.first!)
            let lastLetter = UnicodeScalar(FilterStudentsViewController.currentSelectedLastNameFilter.last!)
            if firstLetter!.value > lastLetter!.value{
                self.navigationItem.setHidesBackButton(true, animated: true)
                
            } else {
                self.navigationItem.setHidesBackButton(false, animated: true)
            }
        }
    }
    
}

extension FilterStudentsViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == schoolPickerView {
            return 1
        }
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == schoolPickerView {
            return 200
        }
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == schoolPickerView {
            return CoreDataHelper.countOfEntity("School")
        } else {
            return alphabet.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == schoolPickerView {
            return schoolData[row]
        } else {
            return String(alphabet[row])
        }
    }
}
