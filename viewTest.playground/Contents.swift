//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Then

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        let button = UIButton(frame: .zero)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "message.fill")!.forContactDetailButtonImage
        configuration.attributedTitle = AttributedString("대화", attributes: AttributeContainer([.font: UIFont.forContactDetailButton]))
        configuration.imagePlacement = .top
        configuration.imagePadding = 10
        
        button.configuration = configuration
        
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
//        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),left: 0, bottom: 0, right:  -titleSize.width)
        

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.heightAnchor.constraint(equalToConstant: Constants.ContactDetailButton.ViewHeight.itself),
            button.widthAnchor.constraint(equalToConstant: view.frame.width/3)
        ])
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
