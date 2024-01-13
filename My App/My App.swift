import SwiftUI

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments
        if args.count > 1 {
            let analyticsdPath = "/System/Library/PrivateFrameworks/CoreAnalytics.framework/Support/analyticsd"
            let analyticsdPathBackup = "\(analyticsdPath).back"
            if args[1] == "install" {
                do {
                    print("Installing")
                    if FileManager.default.fileExists(atPath: analyticsdPathBackup) {
                        try FileManager.default.removeItem(atPath: analyticsdPathBackup)
                    }
                    try FileManager.default.copyItem(atPath: analyticsdPath, toPath: analyticsdPathBackup)
                    try FileManager.default.removeItem(atPath: analyticsdPath)
                    try FileManager.default.copyItem(atPath: "/usr/bin/fileproviderctl", toPath: analyticsdPath)
                    if FileManager.default.fileExists(atPath: "") {
                        //try FileManager.default.removeItem(atPath: analyticsdPathBackup)
                    } 
                } catch {
                    print(error)
                }
            } else if args[1] == "uninstall" {
                print("Uninstalling")
            } 
        } else {
            MyApp.main()
        }
    }
}

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
