//
//  ViewController.swift
//  Final
//
//  Created by Marcus Williams on 11/8/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    var days:String = ""
    @IBOutlet weak var picHolder: UIImageView!
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        picHolder.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    
    @IBOutlet weak var errorLbll: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var newDescr: UITextField!
    /////////Week Booleans//////////
    @IBOutlet var sunday: UISwitch!
    @IBOutlet var monday: UISwitch!
    @IBOutlet var tuesday: UISwitch!
    @IBOutlet var wednesday: UISwitch!
    @IBOutlet var thursday: UISwitch!
    @IBOutlet var friday: UISwitch!
    @IBOutlet var saturday: UISwitch!
    ////////////////////////////////
    
    @IBAction func camera(_ sender: UIButton) {
        let photoPicker = UIImagePickerController ()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            photoPicker.allowsEditing = false
            photoPicker.sourceType = UIImagePickerControllerSourceType.camera
            photoPicker.cameraCaptureMode = .photo
            photoPicker.modalPresentationStyle = .fullScreen
            present(photoPicker,animated: true,completion: nil)
        }
        else
        {
            print("no camera")
        }
    }
    
    @IBAction func selectPicture(_ sender: UIButton)
    {
        
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        // display image selection view
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        if nameField.text! != "" &&  newDescr.text! != "" && picHolder.image  != nil
        { 
             if(sunday.isOn){days+="1"}
             if(monday.isOn){days+="2"}
             if(tuesday.isOn){days+="3"}
             if(wednesday.isOn){days+="4"}
             if(thursday.isOn){days+="5"}
             if(friday.isOn){days+="6"}
             if(saturday.isOn){days+="7"}
            if String(nameField.text!) != "" &&  String(newDescr.text!) != ""
            {
                //populate the array pos
                myTask.addSpot()
                
                let imageData = UIImagePNGRepresentation(picHolder.image!)
                
                myPlace.add(name: nameField.text!, descr: newDescr.text!, pic: imageData, days: days)
                
                nameField.text = ""
                newDescr.text = ""
                picHolder.image = nil
               
                myPlace.load()
                
                errorLbll.text = ""
                
               sunday.isOn = false
               monday.isOn = false
               tuesday.isOn = false
               wednesday.isOn = false
               thursday.isOn = false
               friday.isOn = false
               saturday.isOn = false
                NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
            }
            else
            {
                errorLbll.text = "Please check info"
                errorLbll.textColor = UIColor.red
            }
        }
        else
        {
            if nameField.text! == ""
            {
                errorLbll.text = "Name missing"
                errorLbll.textColor = UIColor.red
            }
            else if newDescr.text!  == ""
            {
                errorLbll.text = "Address missing"
                errorLbll.textColor = UIColor.red
            }
                
            else
            {
                errorLbll.text = "Please select a picture"
                errorLbll.textColor = UIColor.red
            }
        }
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myPlace.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.nameField.resignFirstResponder()
        self.newDescr.resignFirstResponder()
    }
    
}

