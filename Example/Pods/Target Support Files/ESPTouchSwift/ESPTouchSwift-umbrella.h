#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif


FOUNDATION_EXPORT double ESPTouchSwiftVersionNumber;
FOUNDATION_EXPORT const unsigned char ESPTouchSwiftVersionString[];

#import <ESPTouchSwift/ESPTouchDelegate.h>
#import <ESPTouchSwift/ESPTouchResult.h>
#import <ESPTouchSwift/ESPTouchTask.h>
#import <ESPTouchSwift/ESPTools.h>
