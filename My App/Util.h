#import <Foundation/Foundation.h>

NSString* getNSStringFromFile(int fd);
NSString* spawnRoot(NSString* path, NSArray* args);
BOOL isJailbroken(void);
void makeExecutable(NSString* executablePath);
