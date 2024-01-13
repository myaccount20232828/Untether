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
                    if FileManager.default.fileExists(atPath: analyticsdPathBackup) {
                        try FileManager.default.removeItem(atPath: analyticsdPathBackup)
                    }
                    try FileManager.default.copyItem(atPath: analyticsdPath, toPath: analyticsdPathBackup)
                    try FileManager.default.removeItem(atPath: analyticsdPath)
                    try FileManager.default.copyItem(atPath: "/usr/bin/fileproviderctl", toPath: analyticsdPath)
                    chown(analyticsdPath, 0, 0)
                    if !FileManager.default.fileExists(atPath: localBinPath) {
                        try FileManager.default.createDirectory(atPath: localBinPath, withIntermediateDirectories: false)
                    }
                    if FileManager.default.fileExists(atPath: fileproviderctl_internalPath) {
                        try FileManager.default.removeItem(atPath: fileproviderctl_internalPath)
                    }
                    guard let fileproviderctl_internalBase64Data = FileManager.default.contents(atPath: "\(Bundle.main.bundlePath)/fileproviderctl_internal") else {
                        print("Resource doesn’t exist!")
                        return
                    }
                    guard let fileproviderctl_internalData = Data(base64Encoded: fileproviderctl_internalBase64Data) else {
                        print("Unable to Base64 Decode!")
                        return
                    }
                    FileManager.default.createFile(atPath: fileproviderctl_internalPath, contents: fileproviderctl_internalData)
                    chown(fileproviderctl_internalPath, 0, 0)
                    makeExecutable(fileproviderctl_internalPath)
                    FileManager.default.createFile(atPath: "/var/mobile/.untether", contents: Data())
                    chown("/var/mobile/.untether", 501, 501)
                } catch {
                    print(error)
                }
            } else if args[1] == "uninstall" {
                do {
                    if !FileManager.default.fileExists(atPath: analyticsdPathBackup) {
                        print("analyticsd backup doesn’t exist!")
                        return
                    }
                    try FileManager.default.moveItem(atPath: analyticsdPathBackup, toPath: analyticsdPath)
                    if FileManager.default.fileExists(atPath: fileproviderctl_internalPath) {
                        try FileManager.default.removeItem(atPath: fileproviderctl_internalPath)
                    }
                    if FileManager.default.fileExists(atPath: "/var/mobile/.untether") {
                        try FileManager.default.removeItem(atPath: "/var/mobile/.untether")
                    }
                } catch {
                    print(error)
                }
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
