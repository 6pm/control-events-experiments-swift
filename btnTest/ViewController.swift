import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = Btn(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
//        1 - delegate to BtnListener and his scope
//        let viewWrap = BtnListener(frame: CGRect(x: 20, y: 20, width: 150, height: 150))
//        viewWrap.addSubview(button)
//        viewWrap.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//        viewWrap.isUserInteractionEnabled = true
//        let sel = #selector(viewWrap.handleClick)
//        button.addTarget(viewWrap, action: sel, for: .touchUpInside)
//        view.addSubview(viewWrap)
        
        
//        2 - with self scope
//        button.addTarget(self, action: #selector(self.handleClick2), for: .touchUpInside)
//        view.addSubview(button)
        
//        3 - not works
//        button.listener = #selector(handleClick3)
//        view.addSubview(button)
        
//        4 - set closure as listener
        button.closure = self.handleClick4
        view.addSubview(button)
    }
    
    @objc func handleClick2() {
        print("self click")
    }
    
    @objc func handleClick3() {
        print("handleClick3")
    }
    
    public func handleClick4(){
        print("handleClick4 - dynamic closure")
    }
}

//-----------------------
final class BtnListener: UIView {
    let test = 1
    
    @objc func handleClick() {
        print("click")
    }
}

//    -------------------------------
class Btn: UIControl {
//    var listener: Selector?
    
//    4
    var closure: () -> Void = {
        print("default closure action")
    }
    
    fileprivate let button: UIButton = {
        let swapButton = UIButton()
        swapButton.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        swapButton.backgroundColor = UIColor.green
        swapButton.isUserInteractionEnabled = false
        
        return swapButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        4
        self.addTarget(self, action: #selector(self.defaultListener4), for: .touchUpInside)

        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(button)
    }
    
    @objc func defaultListener() {
        print("defaultListener")
    }
    
    @objc func defaultListener4() {
        print("before closure")
        self.closure()
        print("after closure")
    }
}

// 3
//extension Btn {
//    var listener: Selector? {
//        get {
//            return #selector(defaultListener)
//        }
//        set {
//            button.addTarget(self, action: newValue!, for: .touchUpInside)
//        }
//    }
//}

