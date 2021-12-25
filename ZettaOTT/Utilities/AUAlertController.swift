import Foundation
import UIKit

public typealias alertHandlerBlock = (_ indexClicked : Int) ->()

public class AUAlertModel{
    var title:String = ""
    var message:String = ""
    var buttonModels:[AUAlertButtonModel] = []
    var style: UIAlertController.Style = .alert
    var controller: UIViewController = UIViewController.init()
    
    public init(title:String, message:String, buttonModels:[AUAlertButtonModel], style: UIAlertController.Style,  controller: UIViewController){
        self.title = title
        self.message = message
        self.buttonModels = buttonModels
        self.style = style
        self.controller = controller
    }
}

public class AUAlertButtonModel{
    public var actionTitle:String = ""
    public var actionStyle:UIAlertAction.Style = .cancel
    public var index: Int = 999
    
    public init(actionTitle:String, actionStyle:UIAlertAction.Style, index: Int)
    {
        self.actionStyle = actionStyle
        self.actionTitle = actionTitle
        self.index = index
    }
}

public class AUAlertHandler{
    
    
    /// To present alert | action sheet in the view controller
    ///
    /// - Parameters:
    ///   - alertData: details required for showing alert like title, message, etc.,
    ///   - handler:handler to pass the index to handle the action
    public class func showAlertView(alertData: AUAlertModel,  handler: @escaping alertHandlerBlock)
    {
        //****************************** How to use? Start **********************************//
//        func tryOutAlertHandler()    {
//            let alertButtonData1: AUAlertButtonModel = AUAlertButtonModel.init(actionTitle: "ok", actionStyle: .default, index: 0)
//            let alertButtonData2: AUAlertButtonModel = AUAlertButtonModel.init(actionTitle: "cancel", actionStyle: .default, index: 1)
//            let alertButtonData3: AUAlertButtonModel = AUAlertButtonModel.init(actionTitle: "cancel2", actionStyle: .default, index: 2)
//            let alertButtonData4: AUAlertButtonModel = AUAlertButtonModel.init(actionTitle: "cancel3", actionStyle: .cancel, index: 3)
//
//            let alertData: AUAlertModel = AUAlertModel.init(title: "Alert", message: "abcdefghijklmnopqrstuvwxyz", buttonModels: [alertButtonData1], style: .alert, controller: self)
//            AUAlertHandler.showAlertView(alertData: alertData, handler: {[unowned self] (index) in
//                print(index)
//                switch(index){
//                case 1:
//                    break
//                case 2:
//                    break
//                default:
//                    break
//                }
//            })
//
//        }
        //****************************** How to use? End **********************************//
        let alert : UIAlertController?
        if(alertData.title == "" && alertData.message == "")
        {
            alert = UIAlertController(title: nil, message: nil, preferredStyle: alertData.style)
        }
        else if(alertData.title == "" && alertData.message != ""){
            alert = UIAlertController(title: nil, message: alertData.message, preferredStyle: alertData.style)
        }
            
        else if(alertData.title != "" && alertData.message == ""){
            alert = UIAlertController(title: alertData.title, message: nil, preferredStyle: alertData.style)
        }
            
        else{
            alert = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: alertData.style)

        }
        
        if(alertData.buttonModels.count == 0)
        {
            print("Button model is empty. Provide button models and call")
            let errorAlert = UIAlertController(title: "AUAlertHanlder", message: "Button model is empty. Provide button models and call", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                
            }
            errorAlert.addAction(okAction)
            errorAlert.popoverPresentationController?.sourceView = alertData.controller.view
            alertData.controller.present(errorAlert, animated: true, completion: nil)
            
        }
        else{
            var index = 0
            
            for alertButtonModel in alertData.buttonModels{
                let action = UIAlertAction(title: alertButtonModel.actionTitle, style: alertButtonModel.actionStyle) {
                    UIAlertAction in
                    handler(alertButtonModel.index) // call button action
                }
                alert?.addAction(action)
                index = index + 1
            }
            if let popoverController = alert?.popoverPresentationController {
                popoverController.sourceView = alertData.controller.view
                popoverController.sourceRect = CGRect(x: alertData.controller.view.bounds.midX, y: alertData.controller.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            alert?.popoverPresentationController?.sourceView = alertData.controller.view
            alertData.controller.present(alert!, animated: true, completion: nil)
        }
    }
}

