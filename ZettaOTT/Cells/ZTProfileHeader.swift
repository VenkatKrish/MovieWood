//
//  ZTProfileHeader.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 09/10/21.
//

import UIKit

class ZTProfileHeader: UICollectionReusableView {
    @IBOutlet weak var vwGender: UIView!
    @IBOutlet weak var vwUserName: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPhone: UIView!
    @IBOutlet weak var vwDOB: UIView!
    @IBOutlet weak var imgVwProfile: ZTCircularImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserGender: UILabel!
    @IBOutlet weak var lblUserPhone: UILabel!
    @IBOutlet weak var lblUserDOB: UILabel!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var vwHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackOtherDetails: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwImage.layer.cornerRadius = self.vwImage.frame.size.width / 2
        self.vwImage.layer.borderWidth = 2.0
        self.vwImage.layer.borderColor = UIColor.init(named: ZTAppProfileBorder)!.cgColor
        // Initialization code
    }
    func loadProfileDetails(data:AppUserModel? = nil){
        self.hideAllViews()
        if let dataVal = data{
            if let name = dataVal.firstName, name.count > 0{
                self.lblUserName.isHidden = false
                self.lblUserName.text = String(format: "%@ %@", name, dataVal.lastName ?? "")
            }
            if let age = dataVal.age{
                self.lblUserDOB.isHidden = false
                self.lblUserDOB.text = String(format: "%d",age)
            }
            if let gender = dataVal.gender, gender.count > 0{
                self.lblUserGender.isHidden = false
                self.lblUserGender.text = String(format: "%@",gender)
            }
            if let mobile = dataVal.mobile{
                self.lblUserPhone.isHidden = false
                self.lblUserPhone.text = String(format: "%@ %d",dataVal.countryCode ?? "", mobile)
            }
            if let userImagePath = dataVal.userImagePath, userImagePath.count > 0{
                Helper.shared.loadImage(url: userImagePath, imageView: self.imgVwProfile)
            }
        }
    }
    func hideAllViews(){
        self.lblUserName.isHidden = true
        self.lblUserEmail.isHidden = true
        self.vwGender.isHidden = true
        self.vwDOB.isHidden = true
        self.vwPhone.isHidden = true
        self.imgVwProfile.image = UIImage(named: "dummy_profile")
    }
    
}
