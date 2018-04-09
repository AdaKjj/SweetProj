//
//  std.h
//  SweetProj
//
//  Created by 殷婕 on 2017/12/11.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#ifndef std_h
#define std_h

#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#define     FONT_ARIAL          @"ArialMT"
#define     FONT_ARIAL_BOLD     @"Arial-BoldMT"
#define     C_FONT_ARIAL        "ArialMT"

#define RGBA(r,g,b,a)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define SYSTEMCOLOR           RGB(167, 208, 88)

#define BoldSystemFont(fontSize)  [UIFont fontWithName:FONT_ARIAL_BOLD size:fontSize]
#define systemFont(fontSize)      [UIFont fontWithName:FONT_ARIAL size:fontSize]

#define STATUSBAR_HEIGHT      [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVBAR_HEIGHT         44.f
#define TOP_START             (NAVBAR_HEIGHT + STATUSBAR_HEIGHT)

#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width

#define FULL_WIDTH            SCREEN_WIDTH
#define FULL_HEIGHT           (SCREEN_HEIGHT - ((SYSTEM_VERSION >= 7) ? 0 : STATUSBAR_HEIGHT))

#define WEAKSELF __weak __typeof(self)weakSelf = self;

#define TABLE_SECTION_HEADER_HEIGHT 20.0
#define TABLE_ROW_HEIGHT            50.0f

#define __RGB_ORANGE         RGB(233, 99, 0)      // 橙色

#define __RGB_32             RGB(32, 32, 32)      // 深灰色背景下的分隔线
#define __RGB_49             RGB(49, 49, 49)
#define __RGB_65             RGB(65, 65, 65)      // 浅灰色
#define __RGB_75             RGB(75, 75, 75)
#define __RGB_100            RGB(100, 100, 100)
#define __RGB_114            RGB(114, 114, 114)
#define __RGB_130            RGB(130, 130, 130)
#define __RGB_160            RGB(160, 160, 160)
#define __RGB_178            RGB(178, 178, 178)
#define __RGB_190            RGB(190, 190, 190)   // 浅灰色背景下的文字
#define __RGB_200            RGB(200, 200, 200)
#define __RGB_220            RGB(220, 220, 220)
#define __RGB_230            RGB(230, 230, 230)
#define __RGB_240            RGB(240, 240, 240)
#define __RGB_245            RGB(245, 245, 245)

#define TEXTFIELD_TEXT_COLOR        __RGB_49
#define TEXTFIELD_BORDER_COLOR      __RGB_220
#define TEXTFIELD_BACKGROUND_COLOR  [UIColor colorWithWhite:1.0 alpha:0.05];

#define TABLE_BACKGROUND_COLOR           __RGB_245
#define CELL_SEPARATOR_COLOR             __RGB_200 //RGB(169, 169, 169)
#define CELL_TEXT_COLOR                  __RGB_49       // 黑
#define CELL_DETAIL_TEXT_COLOR           __RGB_130    // 浅灰
#define TABLE_SECTION_HEADER_COLOR2      __RGB_240
#define TABLE_SECTION_HEADER_COLOR       __RGB_245
#define TABLE_SECTION_HEADER_TEXT_COLOR  __RGB_178
#define TABLE_SECTION_FOOTER_TEXT_COLOR  __RGB_160
#define COLOR_LIGHTXX_GRAY RGB(197,197,197)

#define CELL_CHAT_TEXT_COLOR            __RGB_160      // 灰
#define RED_COLOR                       RGB(221, 31, 42)
#define CELL_BACKGROUND_COLOR           [UIColor whiteColor]
#define CELL_SEPARATOR_INSET            15



#endif /* std_h */
