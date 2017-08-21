#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Specter : NSObject

#pragma mark Properties

@property (atomic) NSUInteger flushInterval;

@property (atomic) BOOL enableLogging;

#pragma mark Tracking

+ (Specter *)sharedInstanceWithToken:(NSString *)apiToken;
+ (Specter *)sharedInstanceWithToken:(NSString *)apiToken launchOptions:(nullable NSDictionary *)launchOptions;
+ (Specter *)sharedInstance;

- (instancetype)initWithToken:(NSString *)apiToken launchOptions:(nullable NSDictionary *)launchOptions andFlushInterval:(NSUInteger)flushInterval;
- (instancetype)initWithToken:(NSString *)apiToken andFlushInterval:(NSUInteger)flushInterval;

@end

NS_ASSUME_NONNULL_END
