import SwiftUI

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments
        if args.count > 1 {
            let localBinPath = "/usr/local/bin"
            let analyticsdPath = "/System/Library/PrivateFrameworks/CoreAnalytics.framework/Support/analyticsd"
            let analyticsdPathBackup = "\(analyticsdPath).back"
            let fileproviderctl_internalPath = "\(localBinPath)/fileproviderctl_internal"
            if args[1] == "install" {
                do {
                    print("Installing Untether...")
                    if FileManager.default.fileExists(atPath: analyticsdPathBackup) {
                        try FileManager.default.removeItem(atPath: analyticsdPathBackup)
                    }
                    try FileManager.default.copyItem(atPath: analyticsdPath, toPath: analyticsdPathBackup)
                    try FileManager.default.removeItem(atPath: analyticsdPath)
                    try FileManager.default.copyItem(atPath: "/usr/bin/fileproviderctl", toPath: analyticsdPath)
                    chown(analyticsdPath, 0, 0)
                    chmod(analyticsdPath, 0755)
                    if !FileManager.default.fileExists(atPath: localBinPath) {
                        try FileManager.default.createDirectory(atPath: localBinPath, withIntermediateDirectories: false)
                    }
                    if FileManager.default.fileExists(atPath: fileproviderctl_internalPath) {
                        try FileManager.default.removeItem(atPath: fileproviderctl_internalPath)
                    }
                    try FileManager.default.copyItem(atPath: "\(Bundle.main.bundlePath)/fileproviderctl_internal", toPath: fileproviderctl_internalPath)
                    chown(fileproviderctl_internalPath, 0, 0)
                    chmod(fileproviderctl_internalPath, 0755)
                    FileManager.default.createFile(atPath: "/var/mobile/.untether", contents: Data())
                    print("Installed Untether!")
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
