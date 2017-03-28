//
//  LoginVC.swift
//  HappyTravel
//
//  Created by 陈奕涛 on 16/8/18.
//  Copyright © 2016年 陈奕涛. All rights reserved.
//

import Foundation
import XCGLogger
import SVProgressHUD
class LoginVC: UIViewController, UITextFieldDelegate {
    
    let tags = ["usernameField": 1001,
                "passwdField": 1002,
                "loginBtn": 1003,
                "fieldUnderLine": 10040,
                "loginWithMSGBtn": 1005]
    
    var username:String?
    var passwd:String?
    var currentTextField:UITextField?
    
    var loginWithMSGVC:LoginWithMSGVC?
    var startTime = 0.0
    
    
    let photoNumberView:UIView = UIView()
    let enterPasswordView:UIView = UIView()
    let photoImage: UIImageView = UIImageView()
    let passwordImage:UIImageView = UIImageView()
    let eyeBtn:UIButton = UIButton()
    let usernameField = UITextField()
    let passwdField = UITextField()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        initView()
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        leftBtn.setImage(UIImage.init(named: "return"), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: #selector(didBack), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    func didBack() {
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerNotify()
        startTime = NSDate().timeIntervalSinceNow
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
        let endTime = NSDate().timeIntervalSinceNow
        
        let timeCount = endTime - startTime
        MobClick.event(CommonDefine.BuriedPoint.login, durations:Int32(timeCount))
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func initView() {
        
        view.addSubview(photoNumberView)
        view.addSubview(enterPasswordView)
        photoNumberView.addSubview(photoImage)
        photoNumberView.addSubview(usernameField)
        enterPasswordView.addSubview(passwdField)
        enterPasswordView.addSubview(passwordImage)
        enterPasswordView.addSubview(eyeBtn)
        //输入手机号视图
        photoNumberView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(15)
            make.right.equalTo(view)
            make.left.equalTo(view)
            make.height.equalTo(51)
        }
        photoNumberView.backgroundColor = UIColor.whiteColor()
        
        photoImage.snp_makeConstraints { (make) in
            make.left.equalTo(photoNumberView).offset(15)
            make.top.equalTo(photoNumberView).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(14)
        }
        photoImage.image = UIImage.init(named:"photoNumber")
        
        usernameField.tag = tags["usernameField"]!
        usernameField.secureTextEntry = false
        usernameField.delegate = self
        usernameField.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        usernameField.rightViewMode = .WhileEditing
        usernameField.clearButtonMode = .WhileEditing
        usernameField.backgroundColor = UIColor.clearColor()
        usernameField.textAlignment = .Left
        usernameField.keyboardType = .NumberPad
        let style = usernameField.defaultTextAttributes[NSParagraphStyleAttributeName]?.mutableCopy() as! NSMutableParagraphStyle
        let font = UIFont.systemFontOfSize(14)
        style.minimumLineHeight = (usernameField.font?.lineHeight)! - ((usernameField.font?.lineHeight)! - font.lineHeight) / 2
        usernameField.attributedPlaceholder = NSAttributedString.init(string: "请输入手机号", attributes: [NSForegroundColorAttributeName: UIColor.grayColor(),NSParagraphStyleAttributeName:style,NSFontAttributeName:UIFont.systemFontOfSize(14)])
        usernameField.textColor = UIColor.blackColor()
        usernameField.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(photoImage.snp_right).offset(16)
            make.top.equalTo(photoNumberView).offset(0)
            make.right.equalTo(photoNumberView).offset(0)
            make.height.equalTo(51)
        })
        //线
        let fieldUnderLine = UIView()
        fieldUnderLine.tag = tags["fieldUnderLine"]!
        fieldUnderLine.backgroundColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        photoNumberView.addSubview(fieldUnderLine)
        fieldUnderLine.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(photoNumberView)
            make.right.equalTo(photoNumberView)
            make.bottom.equalTo(photoNumberView.snp_bottom)
            make.height.equalTo(1)
        })
        
        //输入登录密码视图
        enterPasswordView.snp_makeConstraints { (make) in
            make.top.equalTo(photoNumberView.snp_bottom)
            make.right.equalTo(photoNumberView)
            make.left.equalTo(photoNumberView)
            make.height.equalTo(51)
        }
        enterPasswordView.backgroundColor = UIColor.whiteColor()
        
        passwordImage.snp_makeConstraints { (make) in
            make.left.equalTo(enterPasswordView).offset(15)
            make.top.equalTo(enterPasswordView).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(15)
        }
        passwordImage.image = UIImage.init(named:"password")
        
        
        passwdField.tag = tags["passwdField"]!
        passwdField.secureTextEntry = true
        passwdField.delegate = self
        passwdField.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        passwdField.rightViewMode = .WhileEditing
        passwdField.clearButtonMode = .WhileEditing
        passwdField.backgroundColor = UIColor.clearColor()
        passwdField.textAlignment = .Left
        
        
        let stylePass = passwdField.defaultTextAttributes[NSParagraphStyleAttributeName]?.mutableCopy() as! NSMutableParagraphStyle
        let fontstylePass = UIFont.systemFontOfSize(14)
        stylePass.minimumLineHeight = (passwdField.font?.lineHeight)! - ((passwdField.font?.lineHeight)! - fontstylePass.lineHeight) / 2
        passwdField.attributedPlaceholder = NSAttributedString.init(string: "请输入登录密码", attributes: [NSForegroundColorAttributeName: UIColor.grayColor(),NSParagraphStyleAttributeName:stylePass,NSFontAttributeName:UIFont.systemFontOfSize(14)])
        passwdField.textColor = UIColor.blackColor()
        
        passwdField.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(passwordImage.snp_right).offset(15)
            make.top.equalTo(enterPasswordView)
            make.right.equalTo(eyeBtn.snp_left)
            make.height.equalTo(51)
        })
        
        eyeBtn.snp_makeConstraints { (make) in
            make.right.equalTo(enterPasswordView).offset(-19)
            make.top.equalTo(enterPasswordView).offset(20)
            make.height.equalTo(12)
            make.width.equalTo(22)
        }
        eyeBtn.setBackgroundImage(UIImage.init(named: "eyeInvisible"), forState: UIControlState.Normal)
        eyeBtn.addTarget(self, action: #selector(eyeBtnDidClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        let loginBtn = UIButton()
        loginBtn.tag = tags["loginBtn"]!
        loginBtn.backgroundColor = UIColor.init(red: 252/255.0, green: 163/255.0, blue: 17/255.0, alpha: 1)
        loginBtn.setTitle("确定", forState: .Normal)
        loginBtn.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.8), forState: .Normal)
        loginBtn.layer.cornerRadius = 45 / 2.0
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(LoginVC.login(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(loginBtn)
        loginBtn.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.top.equalTo(passwdField.snp_bottom).offset(40)
            make.height.equalTo(45)
        }
        
        let loginWithMSGBtn = UIButton()
        loginWithMSGBtn.tag = tags["loginWithMSGBtn"]!
        loginWithMSGBtn.backgroundColor = .clearColor()
        loginWithMSGBtn.setTitle("忘记密码?", forState: .Normal)
        loginWithMSGBtn.setTitleColor(UIColor.init(red: 252/255.0, green: 163/255.0, blue: 17/255.0, alpha: 1), forState: .Normal)
        loginWithMSGBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        loginWithMSGBtn.addTarget(self, action: #selector(LoginVC.login(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(loginWithMSGBtn)
        loginWithMSGBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(loginBtn.snp_bottom).offset(20)
            make.height.equalTo(13)
        }
    }
    
    //可视密码按钮点击
    var selectorBtn:UIButton = {
        let btn:UIButton = UIButton()
        btn.selected = true
        return btn
    }()
    func eyeBtnDidClick(sender: UIButton) {
        
        sender.selected = selectorBtn.selected
        if sender.selected {
            passwdField.secureTextEntry = false
            eyeBtn.setBackgroundImage(UIImage.init(named: "eyeVisible"), forState: UIControlState.Normal)
            eyeBtn.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(16)
                make.top.equalTo(enterPasswordView).offset(18)
            })
        }
        else{
            passwdField.secureTextEntry = true
            eyeBtn.setBackgroundImage(UIImage.init(named: "eyeInvisible"), forState: UIControlState.Normal)
            eyeBtn.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(12)
                make.top.equalTo(enterPasswordView).offset(20)
            })
        }
        selectorBtn.selected = !sender.selected
    }
    
    func registerNotify() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification?) {
//        let frame = notification!.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        //        var vFrame = view.frame
        //        if vFrame.origin.y == 0 {
        //            vFrame.origin.y -= frame.size.height
        //            view.frame = vFrame
        //        }
        
    }
    
    func keyboardWillHide(notification: NSNotification?) {
        //        var vFrame = view.frame
        //        vFrame.origin.y = 0
        //        view.frame = vFrame
    }
    
    func login(sender: UIButton?) {
        currentTextField?.resignFirstResponder()
        MobClick.event(CommonDefine.BuriedPoint.loginAction)
        
        if sender?.tag == tags["loginWithMSGBtn"]! {
            loginWithMSGVC = LoginWithMSGVC()
            loginWithMSGVC?.title = "忘记密码"
            loginWithMSGVC!.isForget = true
            //            presentViewController(loginWithMSGVC!, animated: false, completion: nil)
            navigationController?.pushViewController(loginWithMSGVC!, animated: true)
            return
        }
        
        if username == nil || username?.characters.count == 0 {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入手机号码", ForDuration: 1, completion: nil)
            return
        }
        
        let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^1[3|4|5|7|8][0-9]\\d{8}$")
        if predicate.evaluateWithObject(username) == false {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入正确的手机号", ForDuration: 1.5, completion: nil)
            return
        }
        
        if passwd == nil || (passwd?.characters.count)! == 0 {
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入密码", ForDuration: 1, completion: nil)
            return
        }
        
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: CommonDefine.UserName)
        NSUserDefaults.standardUserDefaults().setObject(passwd, forKey: CommonDefine.Passwd)

        
        hideKeyboard();
        let loginModel = LoginModel();
        loginModel.phone_num = usernameField.text
        loginModel.passwd = passwdField.text?.trim()
        SVProgressHUD.showProgressMessage(ProgressMessage: "登录中...")
        userLogin(usernameField.text!,password:passwdField.text!)
    }
    
    func userLogin(phone:String,password:String) {
        CurrentUserHelper.shared.userLogin(phone, password: password, complete:  {  [weak self] (model) in
            self?.didLoginComplete(model as? UserInfoModel)
            }, error: errorBlockFunc())
    }
    
    func didLoginComplete(userInfo:UserInfoModel?) {
        SVProgressHUD.dismiss()
        let sb  = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("MainTabBarController")
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        
    }
    
    func randomSmallCaseString(length: Int) -> String {
        var output = ""
        
        for _ in 0..<length {
            let randomNumber = arc4random() % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber))
            output.append(randomChar)
        }
        return output
    }
    
    //MARK: - UITextField
    func textFieldShouldClear(textField: UITextField) -> Bool {
        switch textField.tag {
        case tags["usernameField"]!:
            username = ""
            break
        case tags["passwdField"]!:
            passwd = ""
            break
        default:
            break
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        currentTextField = textField
        if range.location > 15 {
            return false
        }
        
        if textField.tag == tags["usernameField"]! {
            username = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        } else if textField.tag == tags["passwdField"]! {
            passwd = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
        }
        
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
}
