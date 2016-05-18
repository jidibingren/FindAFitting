//
//  Config.h
//  Template
//
//  Created by SC on 15/12/31.
//  Copyright (c) 2015年 SC. All rights reserved.
//

#ifndef Template_Config_h
#define Template_Config_h


#define SC_TP_MBPROGRESSHUD
#define SC_TP_TPKEYBOARD_AVOIDING
#define SC_TP_SDWEBIMAGE
#define SC_TP_CSLINEAR
#define SC_TP_KEYVALUE_MAPPING
#define SC_TP_BLOCKSKIT
#define SC_TP_UIVIEWADDTIONS
#define SC_TP_AFNETWORKING
#define SC_TP_TOAST
#define SC_TP_MJREFRESH
#define SC_TP_BAIDUMAP
#define SC_TP_KVO_CONTROLLER

// 定义一些每个应用不同的参数
#if TARGET_IPHONE_SIMULATOR
#define DEBUG_FILL_FORM
#endif

#define UMENG_APP_KEY_ONLINE @"568b0a9fe0f55a2dac0012c5"
#define UMENG_APP_KEY_OFFLINE @"568b0b01e0f55a7108000022"
#define UMENG_CHANNEL @""
// UMENG分享相关的
#define UMENG_SHARE_WX_APPID @"wxb481aa0da25ae430"
#define UMENG_SHARE_WX_SECRET @"a9684752e7d4c2d8a2341715afb03905"
#define UMENG_SHARE_QQ_APPID @"1105252594"
#define UMENG_SHARE_QQ_APPKEY @"mO9nH6qe1lCKojet"
#define UMENG_SHARE_YIXIN_APPKEY @"yx90ccfdda7d13431aa9fa91daa6e4abc4"
#define UMENG_SHARE_URL  BASEURL@"/webapp/index/carAppBusinessDownload"

#define BAIDU_MAP_KEY @"VYKOXaUQ0tdeHZxQUSRYsdE03XKyj2G4"

#define BUGLY_APP_ID @"900016880"

// 正式服务器
#define ONLINE_SERVER @"jinyouapp.com/zhaogejian"
#define ONLINE_SERVER2 @"api.mall.yiliangche.cn"

#define BASEURL_NO_HTTPS   @"http://" ONLINE_SERVER
#define BASEURL2_NO_HTTPS   @"http://" ONLINE_SERVER2
#define BASEURL_TEST    @"http://test.o2obest.cn"
#define BASEURL2_TEST   @"http://test.o2obest.cn"

#define BASEURL   @"http://" ONLINE_SERVER
#define BASEURL2   @"http://" ONLINE_SERVER2

#define BASEURL_HTTPS   @"http://" ONLINE_SERVER
#define BASEURL2_HTTPS   @"https://" ONLINE_SERVER2

#define APPID       @"1071961967"

#define DEFAULT_COMPANY_KEY @"bdba25425f0b8810db98b45981086ea7"

#define kLimitedWords @"请输入6-20位新密码"
// Colors
#define SC_COLOR_NAV_BG         @"2a2739"
#define SC_COLOR_NAV_TEXT       @"333333" // white
#define SC_COLOR_VIEW_BG        @"ffffff"
#define SC_COLOR_TEXTFIELD_BG   @"f1f1f1"
#define SC_COLOR_TEXT SC_COLOR_NAV_BG
#define SC_COLOR_NORMAL_BG      @"0fab99"
#define SC_COLOR_NORMAL_TEXT    @"666666"
#define SC_COLOR_TABBAR_TINT    @"e60012"
#define SC_COLOR_SPEARATOR_LINE @"e5e5e5"
#define SC_COLOR_BUTTON_TITLE   @"ffffff"
#define SC_FONT_NAV_TEXT        17.0
#define SC_FONT_1        20.0
#define SC_FONT_2        18.0
#define SC_FONT_3        15.0
#define SC_FONT_4        12.0
#define SC_COLOR_1       @"000000"
#define SC_COLOR_2       @"7f7f7f"
#define SC_COLOR_3       @"dadada"
#define SC_COLOR_4       @"ffffff"

#define SC_OFFSET            10
#define SC_MARGIN_TOP        10
#define SC_MARGIN_BOTTOM     -10
#define SC_MARGIN_LEFT       10
#define SC_MARGIN_RIGHT      -10


// 默认使用福州市中心
#define DEFAULT_LOCATION CLLocationCoordinate2DMake(26.106131, 119.302548)

#define SC_APP_UPDATE_INFO_URL BASEURL_HTTPS@"/api/appManage/appUpdate?app=2&type=1"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


#endif
