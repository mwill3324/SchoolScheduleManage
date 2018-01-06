//
//  ViewDetailsController.swift
//  Final
//
//  Created by Marcus Williams on 11/14/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import UIKit
/////////////
/////////
///////////
/////////// add edit days to fix setting days to all false
//////////
//////////
class ViewDetailsController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    //////////////////////////
    var days: String? = ""
    var detailName :String!
    var detailDesc: String!
    var pict : String!
    var pic : NSData!
    var detailPlace : place = place()
    var index = 0
    /////////////////////////
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descTextbox: UITextView!
    @IBOutlet weak var nameEditTextField: UILabel!
    @IBOutlet weak var newEditField: UITextField!
    @IBOutlet var sunday: UISwitch!
    @IBOutlet var monday: UISwitch!
    @IBOutlet var tuesday: UISwitch!
    @IBOutlet var wednesday: UISwitch!
    @IBOutlet var thursday: UISwitch!
    @IBOutlet var friday: UISwitch!
    @IBOutlet var saturday: UISwitch!
    @IBOutlet weak var descEditLbl: UILabel!
    @IBOutlet weak var descEditTextBox: UITextField!
    @IBOutlet var SaveB: UIBarButtonItem!
    //////////////////////////////////
    @IBAction func pictureChangeButton(_ sender: UIButton) {
        let photoPicker = UIImagePickerController ()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        editImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    @IBAction func saveButton(_ sender: Any)
    {
        SaveB.isEnabled = false;
        var newName : String?
        var newDesc : String?
        var newPic : Data?
        
        let nameEdited = true
        let descEdited = true
        let picEdited = true
       
        newName = newEditField.text!
        newDesc = descEditTextBox.text!
        
        if newEditField.text != ""
        {
                newName = newEditField.text!
        }
        if descEditTextBox.text != ""
        {
                newDesc = descEditTextBox.text!
        }
        if editImage.image != nil
        {
            let imageData = UIImagePNGRepresentation(editImage.image!)
            newPic = imageData
        }
        else{
            let imageData = UIImagePNGRepresentation(selectedImage.image!)
            newPic = imageData
            editImage.image = selectedImage.image
        }
        if nameEdited && descEdited && picEdited // change all
        {
            newName2 = newEditField.text!
            newPic2 = newPic as NSData?
            newaddress2 = descTextbox.text!
            detailPlace.editAll(name: newName!, descr: newDesc! , pic: newPic, ind: index, Days: days!)
            selectedImage.image = editImage.image
            nameLbl.text = newName!
            descTextbox.text = newDesc!
            editImage.image = nil
            days = ""
            
            if(sunday.isOn)
            {days = days! + "1"}
            if(monday.isOn)
            {days = days! + "2"}
            if(tuesday.isOn)
            {days = days! + "3"}
            if(wednesday.isOn)
            {days = days! + "4"}
            if(thursday.isOn)
            {days = days! + "5"}
            if(friday.isOn)
            {days = days! + "6"}
            if(saturday.isOn)
            {days = days! + "7"}
            
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = detailName
        descTextbox.text = detailDesc
        selectedImage.image = UIImage(data: pic as Data)
        descEditTextBox.text = detailDesc
        newEditField.text = detailName
        if(days?.contains("1"))!
        {sunday.isOn = true}
        if(days?.contains("2"))!
        {monday.isOn = true}
        if(days?.contains("3"))!
        {tuesday.isOn = true}
        if(days?.contains("4"))!
        {wednesday.isOn = true}
        if(days?.contains("5"))!
        {thursday.isOn = true}
        if(days?.contains("6"))!
        {friday.isOn = true}
        if(days?.contains("7"))!
        {saturday.isOn = true}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

