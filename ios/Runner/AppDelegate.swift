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


 class TimeHandler: NSObject, FlutterStreamHandler {
        var timer = Timer()
        private var eventSink: FlutterEventSink?
        
        func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
            self.eventSink = eventSink
    
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm:ss"
                    let time = dateFormat.string(from: Date())
                    eventSink(time)
            })
            
        
            return nil
        }
        
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            eventSink = nil
            return nil
        }
    }
}
