import SwiftUI

struct ContentView: View {
    @State var Log = ""
    @State var Installed = UntetherInstalled()
    var body: some View {
        Form {
            if !Log.isEmpty {
                Section {
                    Text(Log)
                }
            }
            Button {
                if UntetherInstalled() {
                    let Output = String(describing: spawnRoot(Bundle.main.executablePath ?? "", ["uninstall"]).dropLast())
                    if !Output.isEmpty {
                        Log = Output
                    }
                } else {
                    let Output = String(describing: spawnRoot(Bundle.main.executablePath ?? "", ["install"]).dropLast())
                    if !Output.isEmpty {
                        Log = Output
                    }
                }
                Installed = UntetherInstalled()
            } label: {
                Text("\(Installed ? "Uninstall" : "Install") Untether")
            }
            .disabled(!isJailbroken())
            if Installed {
                Button {
                } label: {
                    Text("\(UntetherEnabled() ? "Disable" : "Enable") Untether")
                }
            }
        }
    }
}

func UntetherEnabled() -> Bool {
    return FileManager.default.fileExists(atPath: "/var/mobile/.untether")
}

func UntetherInstalled() -> Bool {
    if let analyticsdData = FileManager.default.contents(atPath: "/System/Library/PrivateFrameworks/CoreAnalytics.framework/Support/analyticsd"), let fileproviderctlData = FileManager.default.contents(atPath: "/usr/bin/fileproviderctl") {
        return analyticsdData == fileproviderctlData
    } else {
        return false
    }
}
