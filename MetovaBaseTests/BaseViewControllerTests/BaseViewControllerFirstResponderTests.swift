//
//  BaseViewControllerFirstResponderTests.swift
//  MetovaBase
//
//  Created by Nick Griffith on 4/23/16.
//
//

import XCTest

@testable import MetovaBase

class BaseViewControllerFirstResponderTests: XCTestCase {

    func testControllerNoResponders() {
       
        class NoRespondersController: BaseViewController {}
        
        let testObject = NoRespondersController()
        testObject.loadView()
        testObject.viewDidLoad()
        
        BCTAssertNoException {
            testObject.dismissKeyboard()
        }
    }

    func testResignsResponder() {
        
        class HasTextFieldController: BaseViewController {
            
            var textField: UITextField?
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                let textField = UITextField()
                view.addSubview(textField)
                UIWindow().addSubview(view)
                self.textField = textField
            }
        }
        
        let testObject = HasTextFieldController()
        testObject.loadView()
        testObject.viewDidLoad()
        
        guard let textField = testObject.textField else {
            XCTFail("Failed to obtain text field reference on test controller.")
            return
        }
        
        textField.becomeFirstResponder()
        
        XCTAssertTrue(textField.isFirstResponder())
        
        testObject.dismissKeyboard()
        
        XCTAssertFalse(textField.isFirstResponder())
    }
}
