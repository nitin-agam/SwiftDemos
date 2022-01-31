//
//  TextViewLinkController.swift
//  SwiftDemos
//
//  Created by Nitin Aggarwal on 31/01/22.
//  Copyright © 2022 Nitin A. All rights reserved.
//

import UIKit
import SafariServices

class TextViewLinkController: UIViewController {
    
    // MARK: - Variables
    private lazy var linkTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.showsVerticalScrollIndicator = false
        textView.alwaysBounceVertical = true
        return textView
    }()
    
    private let plainText = "Swift is a new programming language for iOS, macOS, watchOS, and tvOS app development. Nonetheless, many parts of Swift will be familiar from your experience of developing in C and Objective-C.\n\nSwift provides its own versions of all fundamental C and Objective-C types, including Int for integers, Double and Float for floating-point values, Bool for Boolean values, and String for textual data. Swift also provides powerful versions of the three primary collection types, Array, Set, and Dictionary, as described in Collection Types.\n\nIt’s rare that you need to write type annotations in practice. If you provide an initial value for a constant or variable at the point that it’s defined, Swift can almost always infer the type to be used for that constant or variable, as described in Type Safety and Type Inference. In the welcomeMessage example above, no initial value is provided, and so the type of the welcomeMessage variable is specified with a type annotation rather than being inferred from an initial value."
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        textViewSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(linkTextView)
        
        // add constraints according to you
        linkTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        linkTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        linkTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        linkTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    private func textViewSetup() {
        
        // set plain content
        linkTextView.text = plainText
        
        // define properties
        let textColor = UIColor.label
        let linkColor = UIColor.link
        let font = UIFont.systemFont(ofSize: 17, weight: .medium)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 7
        
        let attributedString = NSMutableAttributedString(string: plainText)
        var foundRange = attributedString.mutableString.range(of: linkTextView.text)
        attributedString.addAttributes([.font: font,
                                        .paragraphStyle: paragraphStyle,
                                        .foregroundColor: textColor],
                                       range: foundRange)
        
        foundRange = attributedString.mutableString.range(of: "iOS")
        attributedString.addAttributes([.link: "https://www.apple.com/in/ios/ios-15/"],
                                       range: foundRange)
        
        foundRange = attributedString.mutableString.range(of: "Collection Types")
        attributedString.addAttributes([.link: "https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html"],
                                       range: foundRange)
        
        foundRange = attributedString.mutableString.range(of: "Type Safety and Type Inference")
        attributedString.addAttributes([.link: "https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID322"],
                                       range: foundRange)
        
        
        // assigning attributes for all links.
        linkTextView.linkTextAttributes = [.foregroundColor: linkColor,
                                           .font: font,
                                           .underlineStyle: NSUnderlineStyle.single.rawValue]
        linkTextView.attributedText = attributedString
    }
    
    func openSafari(_ urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let safariVC = SFSafariViewController(url: url, configuration: config)
            self.navigationController?.showDetailViewController(safariVC, sender: nil)
        }
    }
}

extension TextViewLinkController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        // perform action with URL as per your needs.
        self.openSafari(URL.absoluteString)
        return false
    }
}
