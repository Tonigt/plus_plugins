// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTPackageInfoPlusPlugin.h"

@implementation FLTPackageInfoPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"dev.fluttercommunity.plus/package_info"
                                  binaryMessenger:[registrar messenger]];
  FLTPackageInfoPlusPlugin* instance = [[FLTPackageInfoPlusPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"getAll"]) {
    result(@{
      @"appName" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
          ?: [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"] ?: [NSNull null],
      @"packageName" : [[NSBundle mainBundle] bundleIdentifier] ?: [NSNull null],
      @"version" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
          ?: [NSNull null],
      @"buildNumber" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
          ?: [NSNull null],
    });
  } else if ([call.method isEqualToString:@"getPlistInfo"]){
    result([[NSBundle mainBundle] infoDictionary]);
  }else{
    result(FlutterMethodNotImplemented);
  }
}

@end
