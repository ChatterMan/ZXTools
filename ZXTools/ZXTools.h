//
//  ZXTools.h
//  ZXTools
//
//  Created by Max on 2020/7/20.
//

#import <Foundation/Foundation.h>

#ifndef _ZXTOOLS_
    #define _ZXTOOLS_

#if __has_include(<ZXTools/ZXTools.h>)

    FOUNDATION_EXPORT double ZXToolsVersionNumber;

    FOUNDATION_EXPORT const unsigned char ZXToolsVersionString[];

    #import <ZXTools/ZXToolFileManger.h>
    #import <ZXTools/ZXToolDevice.h>
    #import <ZXTools/ZXToolUUID.h>

#else

    #import "ZXToolFileManger.h"
    #import "ZXToolDevice.h"
    #import "ZXToolUUID.h"

#endif /* __has_include */

#endif /* _ZXTOOLS_ */
