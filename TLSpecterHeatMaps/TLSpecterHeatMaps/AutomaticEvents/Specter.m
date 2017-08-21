#include <arpa/inet.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/socket.h>
#include <sys/sysctl.h>

#import "Specter.h"
#import "SpecterPrivate.h"

@implementation Specter

static NSMutableDictionary *instances;
static NSString *defaultProjectToken;

+ (Specter *)sharedInstanceWithToken:(NSString *)apiToken launchOptions:(NSDictionary *)launchOptions
{
    if (instances[apiToken]) {
        return instances[apiToken];
    }

#if defined(DEBUG)
    const NSUInteger flushInterval = 1;
#else
    const NSUInteger flushInterval = 60;
#endif

    return [[self alloc] initWithToken:apiToken launchOptions:launchOptions andFlushInterval:flushInterval];
}

+ (Specter *)sharedInstanceWithToken:(NSString *)apiToken
{
    return [Specter sharedInstanceWithToken:apiToken launchOptions:nil];
}

+ (Specter *)sharedInstance
{
    if (instances.count == 0) {
        NSLog(@"sharedInstance called before creating a Specter instance");
        return nil;
    }

    if (instances.count > 1) {
        NSLog(@"sharedInstance called with multiple specter instances. Using (the first) token %@",defaultProjectToken);
    }

    return instances[defaultProjectToken];
}

- (instancetype)init:(NSString *)apiToken
{
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instances = [NSMutableDictionary dictionary];
            defaultProjectToken = apiToken;
        });
        
    }
    return self;
}

- (instancetype)initWithToken:(NSString *)apiToken launchOptions:(NSDictionary *)launchOptions andFlushInterval:(NSUInteger)flushInterval
{
    if (apiToken.length == 0) {
        if (apiToken == nil) {
            apiToken = @"";
        }
        NSLog(@"%@ empty api token", self);
    }
    if (self = [self init:apiToken]) {
        self.apiToken = apiToken;
        _flushInterval = flushInterval;
        
        [Specter setSharedAutomatedInstance:self];
        
        instances[apiToken] = self;  
    }
    return self;
}

- (instancetype)initWithToken:(NSString *)apiToken andFlushInterval:(NSUInteger)flushInterval
{
    return [self initWithToken:apiToken launchOptions:nil andFlushInterval:flushInterval];
}

@end
