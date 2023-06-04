#import "RTNMaxModuleSpec.h"
#import "RTNMaxModule.h"

@implementation RTNMaxModule {
    NSMutableDictionary*callbackIds;
}

dispatch_queue_t concurrentQueue = dispatch_queue_create("com.rtnmaxmodule.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);


RCT_EXPORT_MODULE()

- (void)callApi:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
    resolve(@(YES));
}

- (NSString *)callApiAsync:(NSString *)params callback:(RCTResponseSenderBlock)callback {
    NSString*callbackId = [[NSUUID UUID]UUIDString];
    [callbackIds setObject:@"" forKey:callbackId];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.6 * NSEC_PER_SEC)), concurrentQueue, ^{
        NSDictionary*data = @{
            @"status": @200,
            @"response": @{
                @"name": @"minhnh",
                @"age": @20
            }
        };
        
        callback(@[[data description]]);
        [self->callbackIds removeObjectForKey:callbackId];
    });
    return callbackId;
}


- (void)dealloc {
#if !OS_OBJECT_USE_OBJC
    dispatch_release(concurrentQueue);
#endif
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeMaxModuleSpecJSI>(params);
}
@end
