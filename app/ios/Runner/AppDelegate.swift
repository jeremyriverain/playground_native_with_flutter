import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            
            // Method Channel Demo
            let batteryChannel = FlutterMethodChannel(name: "flutter.demo/contacts",
                                                      binaryMessenger: controller.binaryMessenger)
            batteryChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                guard call.method == "getContacts" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                let contactsService = ContactsService()
                contactsService.fetchContacts(result: result)
            })
            
            // Event Channel Demo (timer)
            let eventChannel = FlutterEventChannel(name: "flutter.demo/timer", binaryMessenger: controller.binaryMessenger)
            eventChannel.setStreamHandler(TimeHandler())
            
            // Pigeon
            let contactsApi = ContactsApiImpl()
            ContactsApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: contactsApi)
            
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    
}
