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

#import "SpeechToTextPlugin.h"

FOUNDATION_EXPORT double speech_to_textVersionNumber;
FOUNDATION_EXPORT const unsigned char speech_to_textVersionString[];

