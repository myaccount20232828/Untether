import SwiftUI

struct ContentView: View {
    @State var Log = ""
    @State var Installed = UntetherInstalled()
    @State var Enabled = FileManager.default.fileExists(atPath: UntetherEnabledPath)
    var body: some View {
        Form {
            if !Log.isEmpty {
                Section {
                    Text(Log)
                }
            }
            Section(footer: Text("Created by @AppInstalleriOS")) {
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
                        SetUntether(!FileManager.default.fileExists(atPath: UntetherEnabledPath))
                        Enabled = FileManager.default.fileExists(atPath: UntetherEnabledPath)
                    } label: {
                        Text("\(Enabled ? "Disable" : "Enable") Untether")
                    }
                }
            }
        }
    }
}

let UntetherEnabledPath = "/var/mobile/.untether"

func SetUntether(_ Enabled: Bool) {
    do {
        if Enabled {
            FileManager.default.createFile(atPath: UntetherEnabledPath, contents: Data())
        } else {
            try FileManager.default.removeItem(atPath: UntetherEnabledPath)
        }
    } catch {
        print(error)
    }
}

func UntetherInstalled() -> Bool {
    if let analyticsdData = FileManager.default.contents(atPath: "/System/Library/PrivateFrameworks/CoreAnalytics.framework/Support/analyticsd"), let fileproviderctlData = FileManager.default.contents(atPath: "/usr/bin/fileproviderctl") {
        return analyticsdData == fileproviderctlData
    } else {
        return false
    }
}
