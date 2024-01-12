import SwiftUI

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments
        if args.count > 1 {
            if args[1] == "install" {
                print("Installing")
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
