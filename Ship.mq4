//+------------------------------------------------------------------+
//|                                                         Ship.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <WinUser32.mqh>
#import "user32.dll"
  int GetForegroundWindow();
  
 void keybd_event(int bVk, int bScan,int dwFlags,int dwExtrainfo);

#define VK_CONTROL         17    //CTRL key
#define VK_F6              117   //F6 key
#define KEYEVENTF_KEYUP                0x0002   
  
#import


/////////////////////////////////////////////////////////////////////
#import "user32.dll"
   int OpenClipboard(int hOwnerWindow);
   int EmptyClipboard();
   int CloseClipboard();
   int SetClipboardData(int Format, int hMem);
   int GetClipboardData(int Format);
   //bool IsClipboardFormatAvailable(int Format);
   bool IsClipboardFormatAvailable(uint format);
#import

#define GMEM_MOVEABLE   2
#define CF_UNICODETEXT  13
//#define CF_TEXT         1
//#define CF_TEXT     1
#define CF_OEMTEXT  7

#import "kernel32.dll"
   int GlobalLock(int hMem);
   int GlobalUnlock(int hMem);
   int lstrcpy(string Text, int ptrhMem);
   int lstrcpyA(int ptrhMem, string Text);
   int lstrcpyW(char& Text[], int ptrMem); 
#import



#define CF_TEXT         1


#define VK_RETURN 13 //ENTER key
#define VK_MENU            18    //ALT key
#define KEYEVENTF_EXTENDEDKEY          0x0001
#define KEYEVENTF_KEYUP                0x0002

#define VK_0   48
#define VK_1   49
#define VK_2   50
#define VK_3   51
#define VK_4   52
#define VK_5   53
#define VK_6   54
#define VK_7   55
#define VK_8   56
#define VK_9   57


#define INDICATOR_NAME "5"

 #import "kernel32.dll"
   int GlobalAlloc(int Flags, int Size);
   int GlobalLock(int hMem);
   int GlobalUnlock(int hMem);
   int GlobalFree(int hMem);
   //int lstrcpyA(int ptrhMem, string Text);
   int lstrcpyW(int ptrhMem, string Text);
#import


#import "user32.dll"
   int OpenClipboard(int hOwnerWindow);
   int EmptyClipboard();
   int CloseClipboard();
   int SetClipboardData(int Format, int hMem);
#import
    
#include <WinUser32.mqh>
#import "user32.dll"
  int GetForegroundWindow();
#import

#import "shell32.dll"
int ShellExecuteA(int hwnd,string Operation,string File,string Parameters,string Directory,int ShowCmd); 
//int ShellExecuteA(int hWnd,int lpVerb,string lpFile,int lpParameters,int lpDirectory,int nCmdShow);
int ShellExecuteW(int hWnd,int lpVerb,string lpFile,string lpParameters,string lpDirectory,int nCmdShow);
#import

 bool Shell(string file, string parameters=""){
    #define DEFDIRECTORY NULL
    #define OPERATION "open"    // or print
    #define SW_SHOWNORMAL       1
    int r=ShellExecuteA(0, OPERATION, file, parameters, DEFDIRECTORY, SW_SHOWNORMAL);
    if (r <= 32){   Alert("Shell failed: ", r); return(false);  }
    return(true);
};

#define SW_HIDE             0
#define SW_SHOWNORMAL       1
#define SW_NORMAL           1
#define SW_SHOWMINIMIZED    2
#define SW_SHOWMAXIMIZED    3
#define SW_MAXIMIZE         3
#define SW_SHOWNOACTIVATE   4
#define SW_SHOW             5
#define SW_MINIMIZE         6
#define SW_SHOWMINNOACTIVE  7
#define SW_SHOWNA           8
#define SW_RESTORE          9
#define SW_SHOWDEFAULT      10
#define SW_FORCEMINIMIZE    11
#define SW_MAX              11

//////////////////////////////////////////////////////////////////////

/*
Senelerce bilginin özeti, 900 satıra düştü.
Artık işleme giriş yeri ve çıkış yerini net olarak biliyorum.
Uzun işlemlere girebilirim.
Bitti.
*/

string last_select_object;
string last_object;
int carpan=5;

int last_shift=1000000;
bool next_find=false;

//bool flag_mode = false; 
bool flag_mode = true; 
bool sys_mode=true;

int ObjTotal = ObjectsTotal();

/*
   double Height;
   int Width;
   double Scale;*/

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTime = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTimes = PERIOD_CURRENT;


int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern int MA_W=21;
//extern int MB_W=55;


bool color_change=false;
bool color_ghost=false;

   color color_bg;
   color color_up;  
   color color_down;
   color color_bull;
   color color_bear;
   color color_line;
   
   
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
   color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   color_line = ChartGetInteger(ChartID(),CHART_COLOR_CHART_LINE);
  
  
  ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
  
  
        string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
        //if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=TFtoStr(Period());
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 33);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30); 
     
         
     } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     //}  
  
  
  /*
  
string name="LastHourHigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,1),iHigh(Symbol(),PERIOD_H1,1),iTime(Symbol(),PERIOD_H1,1)+5*PeriodSeconds(PERIOD_H1),iHigh(Symbol(),PERIOD_H1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name="LastHourLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,1),iLow(Symbol(),PERIOD_H1,1),iTime(Symbol(),PERIOD_H1,1)+5*PeriodSeconds(PERIOD_H1),iLow(Symbol(),PERIOD_H1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

  
name="LastHourHighLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,1),iLow(Symbol(),PERIOD_H1,1),iTime(Symbol(),PERIOD_H1,1),iHigh(Symbol(),PERIOD_H1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastHourHighLow");
  
  
name="LastHourHighs";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,2),iHigh(Symbol(),PERIOD_H1,2),iTime(Symbol(),PERIOD_H1,2)+5*PeriodSeconds(PERIOD_H1),iHigh(Symbol(),PERIOD_H1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

name="LastHourLows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,2),iLow(Symbol(),PERIOD_H1,2),iTime(Symbol(),PERIOD_H1,2)+5*PeriodSeconds(PERIOD_H1),iLow(Symbol(),PERIOD_H1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

name="LastHourHighLows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,2),iLow(Symbol(),PERIOD_H1,2),iTime(Symbol(),PERIOD_H1,2),iHigh(Symbol(),PERIOD_H1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastHourHighLows");



name="LastHourHigh4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,1),iHigh(Symbol(),PERIOD_H4,1),iTime(Symbol(),PERIOD_H4,1)+5*PeriodSeconds(PERIOD_H4),iHigh(Symbol(),PERIOD_H4,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);

name="LastHourLow4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,1),iLow(Symbol(),PERIOD_H4,1),iTime(Symbol(),PERIOD_H4,1)+5*PeriodSeconds(PERIOD_H4),iLow(Symbol(),PERIOD_H4,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);

name="LastHourHighLow4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,1),iLow(Symbol(),PERIOD_H4,1),iTime(Symbol(),PERIOD_H4,1),iHigh(Symbol(),PERIOD_H4,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastHourHighLow4");

  
name="LastHourHighs4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,2),iHigh(Symbol(),PERIOD_H4,2),iTime(Symbol(),PERIOD_H4,2)+5*PeriodSeconds(PERIOD_H4),iHigh(Symbol(),PERIOD_H4,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);

name="LastHourLows4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,2),iLow(Symbol(),PERIOD_H4,2),iTime(Symbol(),PERIOD_H4,2)+5*PeriodSeconds(PERIOD_H4),iLow(Symbol(),PERIOD_H4,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);


name="LastHourHighLows4";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H4,2),iLow(Symbol(),PERIOD_H4,2),iTime(Symbol(),PERIOD_H4,2),iHigh(Symbol(),PERIOD_H4,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastHourHighLows4");




name="ToDayHigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),iHigh(Symbol(),PERIOD_D1,0),iTime(Symbol(),PERIOD_D1,0)+5*PeriodSeconds(PERIOD_D1),iHigh(Symbol(),PERIOD_D1,0));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrTurquoise);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"ToDayHigh");

name="ToDayLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),iLow(Symbol(),PERIOD_D1,0),iTime(Symbol(),PERIOD_D1,0)+5*PeriodSeconds(PERIOD_D1),iLow(Symbol(),PERIOD_D1,0));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightPink);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"ToDayLow");

name="ToDayHighLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,0),iLow(Symbol(),PERIOD_D1,0),iTime(Symbol(),PERIOD_D1,0),iHigh(Symbol(),PERIOD_D1,0));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"ToDayHighLow");






name="LastDayHigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),iHigh(Symbol(),PERIOD_D1,1),iTime(Symbol(),PERIOD_D1,1)+5*PeriodSeconds(PERIOD_D1),iHigh(Symbol(),PERIOD_D1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrTurquoise);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);

name="LastDayLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),iLow(Symbol(),PERIOD_D1,1),iTime(Symbol(),PERIOD_D1,1)+5*PeriodSeconds(PERIOD_D1),iLow(Symbol(),PERIOD_D1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightPink);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
  
name="LastDayHighLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,1),iLow(Symbol(),PERIOD_D1,1),iTime(Symbol(),PERIOD_D1,1),iHigh(Symbol(),PERIOD_D1,1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastDayHighLow");

  
  
name="LastDayHighs";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,2),iHigh(Symbol(),PERIOD_D1,2),iTime(Symbol(),PERIOD_D1,2)+5*PeriodSeconds(PERIOD_D1),iHigh(Symbol(),PERIOD_D1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrTurquoise);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,6);

name="LastDayLows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,2),iLow(Symbol(),PERIOD_D1,2),iTime(Symbol(),PERIOD_D1,2)+5*PeriodSeconds(PERIOD_D1),iLow(Symbol(),PERIOD_D1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightPink);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,6);


name="LastDayHighLows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,2),iLow(Symbol(),PERIOD_D1,2),iTime(Symbol(),PERIOD_D1,2),iHigh(Symbol(),PERIOD_D1,2));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,5);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"LastDayHighLows");





  
MaTime=PERIOD_M15;

//MaTime=PERIOD_D1;
  
  
double MA9=iMA(NULL, MaTime, 9, ma_shift, MaMethod, MaPrice, shift); 
double MA22=iMA(NULL, MaTime, 22, ma_shift, MaMethod, MaPrice, shift); 
double MA50=iMA(NULL, MaTime, 50, ma_shift, MaMethod, MaPrice, shift); 
double MA100=iMA(NULL, MaTime, 100, ma_shift, MaMethod, MaPrice, shift); 
double MA200=iMA(NULL, MaTime, 200, ma_shift, MaMethod, MaPrice, shift); 

         name="MA9";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[50],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA9");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   

         name="MA22";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[50],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA22");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   

         name="MA50";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[50],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA50");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         

         name="MA100";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[50],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA100");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
                  

         name="MA200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[50],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA200");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);                             

   //double MA=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 
   //double MB=iMA(NULL, MaTimeB, MB_W, ma_shift, MaMethods, MaPrices, shift); 
   
   ObjectMove(ChartID(),"MA9",0,Time[1]+(PeriodSeconds()*30),MA9);
   ObjectMove(ChartID(),"MA9",1,Time[50]+(PeriodSeconds()*30),MA9);
   
   ObjectMove(ChartID(),"MA22",0,Time[1]+(PeriodSeconds()*30),MA22);
   ObjectMove(ChartID(),"MA22",1,Time[50]+(PeriodSeconds()*30),MA22);
   
   ObjectMove(ChartID(),"MA50",0,Time[1]+(PeriodSeconds()*30),MA50);
   ObjectMove(ChartID(),"MA50",1,Time[50]+(PeriodSeconds()*30),MA50);
   
   ObjectMove(ChartID(),"MA100",0,Time[1]+(PeriodSeconds()*30),MA100);
   ObjectMove(ChartID(),"MA100",1,Time[50]+(PeriodSeconds()*30),MA100);
                     
   ObjectMove(ChartID(),"MA200",0,Time[1]+(PeriodSeconds()*30),MA200);
   ObjectMove(ChartID(),"MA200",1,Time[50]+(PeriodSeconds()*30),MA200);
     


   double BB_Lower = iBands(Symbol(),MaTime,9,2,0,PRICE_CLOSE, MODE_LOWER,0);
   double BB_Upper = iBands(Symbol(),MaTime,9,2,0,PRICE_CLOSE, MODE_UPPER,0);
    double BB_Main = iBands(Symbol(),MaTime,9,2,0,PRICE_CLOSE, MODE_MAIN,0);
    

         name="BB_LOWER";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,"Lower");
         ObjectSetInteger(0,name,OBJPROP_RAY,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   
         name="BB_UPPER";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrCrimson); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,"Upper");
         ObjectSetInteger(0,name,OBJPROP_RAY,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         name="BB_MAIN";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,"Main");
         ObjectSetInteger(0,name,OBJPROP_RAY,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         
         
         name="BB_LINE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],BB_Upper,Time[1],BB_Lower);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,"BB-Line");
         ObjectSetInteger(0,name,OBJPROP_RAY,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);           
         
   ObjectMove(ChartID(),"BB_UPPER",0,Time[1]+(PeriodSeconds()*30),BB_Upper);
   ObjectMove(ChartID(),"BB_UPPER",1,Time[40]+(PeriodSeconds()*30),BB_Upper);
     
   ObjectMove(ChartID(),"BB_LOWER",0,Time[1]+(PeriodSeconds()*30),BB_Lower);
   ObjectMove(ChartID(),"BB_LOWER",1,Time[40]+(PeriodSeconds()*30),BB_Lower);
        
   ObjectMove(ChartID(),"BB_MAIN",0,Time[1]+(PeriodSeconds()*30),BB_Main);
   ObjectMove(ChartID(),"BB_MAIN",1,Time[40]+(PeriodSeconds()*30),BB_Main);
   
            
*/
      
  
//--- create timer
   //EventSetTimer(60);
   
   //ObjectsDeleteAll();
/*
   switch(Period())
     {
      //---- codes returned from trade server
      case PERIOD_M1: Height=30;Width=Period()*3; Scale = 0.12; break;
      case PERIOD_M5: Height=75; Width=Period()*3; Scale = 0.08; break;
      case PERIOD_M15:Height=100; Width=Period()*3; Scale = 0.08; break;
      case PERIOD_M30:Height=200; Width=Period()*3; Scale = 0.04; break;
      case PERIOD_H1: Height=250; Width=Period()*3; Scale = 0.04; break; 
      case PERIOD_H4: Height=350; Width=Period()*3; Scale = 0.02; break;
      case PERIOD_D1: Height=500; Width=Period()*3; Scale = 0.01; break;
      case PERIOD_W1: Height=1000; Width=Period()*7; Scale = 0.002; break;
      case PERIOD_MN1:Height=3000; Width=Period()*10; Scale = 0.002; break;
      default:   Height=250;
     }
   DrawEllipse("Ellipse_"+WindowTimeOnDropped(),WindowTimeOnDropped()-Width,WindowPriceOnDropped()-Height*Point,WindowTimeOnDropped()+Width,WindowPriceOnDropped()+Height*Point,clrSilver, Scale);
*/
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  datetime bar_start_time=Time[0];
  datetime bar_end_time=bar_start_time+PeriodSeconds();
  int seconds_remaining=bar_end_time-TimeCurrent();  
       
       string LabelChart="ZamanBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,seconds_remaining);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 55);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);     
     } else {     
     LabelChart="ZamanBilgisi";
     string ZamanBilgisi=TimeToStr(seconds_remaining,TIME_MINUTES|TIME_SECONDS);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,ZamanBilgisi);
     }
     
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


 MumAnaliz();
 
 
  if ( sparam == 46 ) {
  
  if ( color_change == true ) {
  color_change=false;

   //ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,color_bg);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,color_up);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,color_down);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,color_bull); 
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,color_bear); 
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,color_line); 

  
  } else {
  color_change=true;
  
   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   //ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrWhite);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrBlack);    
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrBlack);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrBlack);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
   
  
  }
  
  ChartRedraw();
  
  
  }
  
   
 
 
 if ( sparam == 50 ) {
 
 if ( shipmsb == true ) {shipmsb=false;} else {shipmsb=true;}
 
 Comment("ShipMsb:",shipmsb);
 
 
 }

//Print(sparam);

  //int indexoffe = StringFind(sparam," FE", 0);                   
  //indexoffe != -1 && 
  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND ) {
  
  double feprice0 = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE,0);
  double feprice1 = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE,1);
  string festr = ObjectGetString(ChartID(),sparam+" Text",OBJPROP_TEXT);
  
  if ( feprice0 == feprice1 ) {
  
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(currChart,sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(feprice0,MarketInfo(Symbol(),MODE_DIGITS));
          CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment(festr," Fiyat Hafızası:",HLinePrice);
          //}
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              
  }
  
  //Alert(sparam);
  
  }

          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE),MarketInfo(Symbol(),MODE_DIGITS));
          CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment("Fiyat Hafızası:",HLinePrice);
          }
          


    if ( ObjTotal!=ObjectsTotal(ChartID()) ) AlertObject();
 ObjTotal = ObjectsTotal(ChartID());
 
 
 
 if ( StringFind(sparam,"Entry",0) != -1 ) {


if ( sys_mode == true ) {sys_mode=false;

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLightYellow);

} else {sys_mode=true;

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrYellow);

}

Comment("Sys Mode:",sys_mode);


}
 

 
 if ( sparam == 31 ) {


if ( sys_mode == true ) {sys_mode=false;} else {sys_mode=true;}

Comment("Sys Mode:",sys_mode);


}
 

if ( sparam == 33 ) {


if ( flag_mode == true ) {flag_mode=false;



} else {flag_mode=true;


}

Comment("Flag Mode:",flag_mode);


}

if ( StringFind(sparam,"Water",0) != -1 ) {


if ( flag_mode == true ) {flag_mode=false;
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrDodgerBlue);

} else {flag_mode=true;


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrNavy);
}

Comment("Flag Mode:",flag_mode);


}



if ( sparam == 19 ) {
last_shift=1000000;
}

if ( sparam == 49 ) {

if ( next_find == true ) {next_find=false;

} else {next_find=true;
last_shift=1000000;
}

Comment("NExt Find:",next_find);



}

if ( int(sparam) > 1 && int(sparam) <= 10 ) {

carpan=int(sparam);

Comment("Çarpan:",carpan);


}

if ( sparam == 45 ) {

ObjectsDeleteAll();

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Ship MSB
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && shipmsb == true //&& StringFind(sparam,last_select_object,0) == -1
//&& StringFind(sparam,"Ship",0) == -1 && StringFind(sparam,"Flag",0) == -1 && StringFind(sparam,"Bolge",0) == -1 && sys_mode == true 
) {



last_select_object=sparam;
last_object=sparam;


//last_object=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          int obj_style = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_STYLE);

          
int shift1=iBarShift(Symbol(),Period(),obj_time1);
int shift2=iBarShift(Symbol(),Period(),obj_time2);


/////////////////////////////////////////////////////////
if ( obj_prc1 > obj_prc2 ) {

ObjectMove(ChartID(),sparam,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),sparam,1,Time[shift2],Low[shift2]);

ShortShip(shift1,shift2,sparam);


}
//////////////////////////////////////////////////////////


if ( obj_prc1 < obj_prc2 ) {

//Alert("Selam");


ObjectMove(ChartID(),sparam,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),sparam,1,Time[shift2],High[shift2]);

LongShip(shift1,shift2,sparam);

}





}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// OTE Çizim Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND  && StringFind(sparam,"VeryHLPrice",0) != -1 ) {

last_select_object=sparam;





          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          int obj_style = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_STYLE);

          
int shift1=iBarShift(Symbol(),Period(),obj_time1);
int shift2=iBarShift(Symbol(),Period(),obj_time2);

string w=sparam;
int rep=StringReplace(w," VeryHLPrice","");


int l=shift1;

if ( obj_prc1 > obj_prc2 ) {


ObjectMove(ChartID(),sparam,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),sparam,1,Time[shift2],Low[shift2]);


//Alert("w:",w);


double very_high_price=High[shift1];
double very_low_price=Low[shift2];

int very_high_shift=shift1;
int very_low_shift=shift2;


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;
/*
double hl_50=very_high_price-(hl_yuzde*50);
double hl_79=very_high_price-(hl_yuzde*79);
double hl_70=very_high_price-(hl_yuzde*70);*/


double hl_50=very_low_price+(hl_yuzde*50);
double hl_79=very_low_price+(hl_yuzde*79);
double hl_70=very_low_price+(hl_yuzde*70);

ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFiboPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 

ObjectDelete(ChartID(),w+" VeryFiboPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);

ChartRedraw();


}


if ( obj_prc2 > obj_prc1 ) {


ObjectMove(ChartID(),sparam,1,Time[shift2],High[shift2]);
ObjectMove(ChartID(),sparam,0,Time[shift1],Low[shift1]);


double very_high_price=High[shift2];
double very_low_price=Low[shift1];

int very_high_shift=shift2;
int very_low_shift=shift1;


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;

double hl_50=very_high_price-(hl_yuzde*50);
double hl_79=very_high_price-(hl_yuzde*79);
double hl_70=very_high_price-(hl_yuzde*70);

//Alert("w:",w,"/",very_high_price,"/",very_low_price);

ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFiboPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 

ObjectDelete(ChartID(),w+" VeryFiboPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);



ChartRedraw();


}

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Ship System
///////////////////////////////////////////////////////////////////////////////////////////


if ( StringFind(sparam,"VeryHLPrice",0) == -1 && ( sparam == last_select_object || StringFind(sparam,last_select_object,0) == -1 ) && shipmsb==false &&  ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Ship",0) == -1 && StringFind(sparam,"Flag",0) == -1 && StringFind(sparam,"Bolge",0) == -1 && sys_mode == true ) {




//Comment("Sparam:",sparam);StringFind(sparam,last_select_object,0) == 0

Comment("LSOPosition:",StringFind(sparam,last_select_object,0));


last_select_object=sparam;
last_object=sparam;


//last_object=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          int obj_style = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_STYLE);

          
int shift1=iBarShift(Symbol(),Period(),obj_time1);
int shift2=iBarShift(Symbol(),Period(),obj_time2);


double lows=1000000;
int lows_shift;
double higs=-1;
int higs_shift;
bool lows_find=false;
bool high_find=false;
int lows_total=0;
int higs_total=0;


                    
if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam2");


ObjectMove(ChartID(),sparam,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),sparam,1,Time[shift2],Low[shift2]);

double govde_alti;

if ( Open[shift1] > Close[shift1] ) govde_alti=Close[shift1];
if ( Open[shift1] < Close[shift1] ) govde_alti=Open[shift1];

ObjectDelete("UCGEN");
ObjectCreate(ChartID(),"UCGEN",OBJ_TRIANGLE,0,Time[shift2],Low[shift2],Time[shift1],High[shift1],Time[shift1],govde_alti);

SwingMeter("UCGEN");


int high_shift_time=shift1;

  if ( flag_mode == true ) double flag5=FlagUpDown(High[shift1],Low[shift2],sparam,high_shift_time,"","Left");  


//Comment("UpDown");


lows=1000000;
lows_shift;
higs=-1;
higs_shift;
lows_find=false;
high_find=false;
lows_total=0;



for (int i=shift1-1;i>shift1-100;i--) {

if ( i < 0 ) continue;


if ( Low[i] > Low[shift2]  ) continue;



high_find=false;

if ( lows_find == false ) {

if ( Low[i] < lows || (Low[i] == lows && Low[i] < Low[i-1] ) ) {

lows=Low[i];
lows_shift=i;
lows_total=0;

//Print(i);


if ( Low[i] < Low[i-1] ) {

//Print("evet");


for (int x=i-1;x>i-20;x--) {

if ( x < 0 ) continue;

//Print(lows_total);
if ( high_find == false ) {
if ( lows < Low[x] ) {
lows_total=lows_total+1;
} else {
high_find=true;
}
}
}


}
/*
if ( next_find == true && last_shift != i ) {
last_shift
} else {
}*/


if ( lows_total > carpan ) {

if ( next_find == true && last_shift == i ) {
lows_find=false;
continue;
} else {

if ( next_find == true ) {
if ( i < last_shift )  {
lows_find=true;
last_shift=i;
//Comment("Last_shift:",last_shift);
}
} else {
lows_find=true;
last_shift=i;
//Comment("Last_shift:",last_shift);
}

}



}






//Print(i);

}


}

}





if ( lows_find == true ) {
//Print("Çiz");

string name=sparam+"ShipLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],High[shift1],Time[lows_shift],Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);



double yuzde=(High[shift1]-Low[lows_shift])/100;
double price414=Low[lows_shift]-(yuzde*41.4);
double price272=Low[lows_shift]-(yuzde*27.2);
double price500=Low[lows_shift]+(yuzde*50);
double price886=Low[lows_shift]-(yuzde*88.6);
double price786=Low[lows_shift]-(yuzde*78.6);
double price1618=Low[lows_shift]-(yuzde*161.8);
double price556=Low[lows_shift]-(yuzde*55.6);


name=sparam+"ShipDown500";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price500,Time[lows_shift]+100*PeriodSeconds(),price500);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price414,Time[lows_shift]+100*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price272,Time[lows_shift]+100*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price886,Time[lows_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp786";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price786,Time[lows_shift]+100*PeriodSeconds(),price786);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp1618";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price1618,Time[lows_shift]+100*PeriodSeconds(),price1618);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp786-886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[lows_shift],price786,Time[lows_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
//ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);






price414=High[shift1]+(yuzde*41.4);
price272=High[shift1]+(yuzde*27.2);
price886=High[shift1]+(yuzde*88.6);
price786=High[shift1]+(yuzde*78.6);
price1618=High[shift1]+(yuzde*161.8);
price556=High[shift1]+(yuzde*55.6);

name=sparam+"ShipDown414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price414,Time[lows_shift]+100*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDown272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price272,Time[lows_shift]+100*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price886,Time[lows_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDown786";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price786,Time[lows_shift]+100*PeriodSeconds(),price786);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown1618";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price1618,Time[lows_shift]+100*PeriodSeconds(),price1618);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown786-886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[lows_shift],price786,Time[lows_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
//ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sparam+"ShipDown556";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],price556,Time[lows_shift]+100*PeriodSeconds(),price556);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);




int down_shift=lows_shift-(shift2-lows_shift);

if ( down_shift < 0 ) down_shift=0;

//Comment("DownShift:",down_shift,"/",shift1,"-",lows_shift,"/",(shift1-lows_shift));

name=sparam+"ShipDown";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],Low[lows_shift],Time[down_shift],Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);




name=sparam+"ShipUp";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],High[shift1],Time[down_shift],High[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);


int right_shift=down_shift-(shift2-shift1);

if ( right_shift < 0 ) right_shift=0;

name=sparam+"ShipRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[down_shift],High[shift1],Time[right_shift],Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);



name=sparam+"ShipBoard";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],Low[shift2],Time[right_shift],Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

name=sparam+"ShipBoardEx";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[right_shift],Low[shift2],Time[right_shift]+10*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipBoardEntry";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[right_shift]+40*PeriodSeconds(),Low[shift2]+((High[shift1]-Low[shift2])/5),Time[right_shift]+50*PeriodSeconds(),Low[shift2]-((High[shift1]-Low[shift2])/5));
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);


name=sparam+"ShipWater";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shift1+50],High[shift1],Time[right_shift]+100*PeriodSeconds(),High[shift1]+((High[shift1]-Low[shift2])/3));
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDodgerBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);



name=sparam+"ShipBoardRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[lows_shift],Low[lows_shift],Time[down_shift],High[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

name=sparam+"ShipFlagLine";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[down_shift],Low[lows_shift]-((High[shift1]-Low[lows_shift])/5),Time[down_shift],High[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDownRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[down_shift],Low[lows_shift],Time[down_shift]+10*PeriodSeconds(),Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDownRights";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[down_shift]+10*PeriodSeconds(),Low[lows_shift],Time[down_shift]+500*PeriodSeconds(),Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipFlag";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[down_shift],Low[lows_shift]-((High[shift1]-Low[lows_shift])/5),Time[down_shift]+10*PeriodSeconds(),Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipFlagAngle";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TRIANGLE,0,Time[down_shift],Low[lows_shift],Time[down_shift],Low[lows_shift]-((High[shift1]-Low[lows_shift])/5),Time[down_shift]+10*PeriodSeconds(),Low[lows_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
/*
name=sparam+"ShipAnchor";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_ELLIPSE,0,Time[down_shift],Low[shift2]+((High[shift1]-Low[shift2])/3),Time[down_shift],High[shift1]-((High[shift1]-Low[shift2])/3));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkSlateGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,0.050);*/


name=sparam+"ShipAnchor";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_ELLIPSE,0,Time[down_shift]-1*PeriodSeconds(),High[shift1]-(((High[shift1]-Low[shift2])/5)*3),Time[down_shift]-2*PeriodSeconds(),Low[shift2]+(((High[shift1]-Low[shift2])/5)*1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkSlateGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
//ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,Scale);
ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,0.050);



//ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,Scale);




name=sparam+"ShipLowv";
ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[lows_shift],Low[lows_shift]);
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
}


}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
/////////////   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   
   
   
if ( obj_prc1 < obj_prc2 ) {

//Alert("Selam");


ObjectMove(ChartID(),sparam,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),sparam,1,Time[shift2],High[shift2]);

Comment("DownUp");


double govde_alti;

if ( Open[shift1] > Close[shift1] ) govde_alti=Open[shift1];
if ( Open[shift1] < Close[shift1] ) govde_alti=Close[shift1];

ObjectDelete("UCGEN");
ObjectCreate(ChartID(),"UCGEN",OBJ_TRIANGLE,0,Time[shift2],High[shift2],Time[shift1],Low[shift1],Time[shift1],govde_alti);

SwingMeter("UCGEN");




int low_shift_time=shift1;

if ( flag_mode == true ) double flag5=FlagDownUp(High[shift2],Low[shift1],sparam,low_shift_time,"","Left");




lows=1000000;
lows_shift;
higs=-1;
higs_shift;
lows_find=false;
high_find=false;
lows_total=0;
higs_total=0;


for (int i=shift1-1;i>shift1-100;i--) {

//Print("i:",i);

if ( i < 0 ) continue;

if ( High[i] < High[shift2]  ) continue;



lows_find=false;

if ( high_find == false ) {

if ( High[i] > higs  || (High[i] == higs && High[i] > High[i-1] )  ) {

higs=High[i];
higs_shift=i;
higs_total=0;

//Print(i);


if ( High[i] > High[i-1] ) {

//Print("evet");


for (int x=i-1;x>i-20;x--) {

//Print("x:",x);

if ( x < 0 ) continue;

//Print(lows_total);
if ( lows_find == false ) {
if ( higs > High[x] ) {
higs_total=higs_total+1;
} else {
lows_find=true;
}
}
}


}
/*
if ( next_find == true && last_shift != i ) {
last_shift
} else {
}*/


if ( higs_total > carpan ) {

if ( next_find == true && last_shift == i ) {
lows_find=false;
continue;
} else {

if ( next_find == true ) {
if ( i < last_shift )  {
high_find=true;
last_shift=i;
Comment("Last_shift:",last_shift);
}
} else {
high_find=true;
last_shift=i;
Comment("Last_shift:",last_shift);
}

}



}






//Print(i);

}


}




}          


if ( high_find == true ) {
//Print("Çiz");

string name=sparam+"ShipLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],Low[shift1],Time[higs_shift],High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

//Alert("sElam");


double yuzde=(High[higs_shift]-Low[shift1])/100;
double price414=High[higs_shift]+(yuzde*41.4);
double price272=High[higs_shift]+(yuzde*27.2);
double price500=High[higs_shift]-(yuzde*50);
double price886=High[higs_shift]+(yuzde*88.6);
double price1618=High[higs_shift]+(yuzde*161.8);
double price786=High[higs_shift]+(yuzde*78.6);
double price556=High[higs_shift]+(yuzde*55.6);

name=sparam+"ShipDown500";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price500,Time[higs_shift]+100*PeriodSeconds(),price500);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price414,Time[higs_shift]+100*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price272,Time[higs_shift]+100*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price886,Time[higs_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipUp786";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price786,Time[higs_shift]+100*PeriodSeconds(),price786);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp1618";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price1618,Time[higs_shift]+100*PeriodSeconds(),price1618);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipUp786-886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[higs_shift],price786,Time[higs_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);



price414=Low[shift1]-(yuzde*41.4);
price272=Low[shift1]-(yuzde*27.2);
price886=Low[shift1]-(yuzde*88.6);
price1618=Low[shift1]-(yuzde*161.8);
price786=Low[shift1]-(yuzde*78.6);
price556=Low[shift1]-(yuzde*55.6);

name=sparam+"ShipDown414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price414,Time[higs_shift]+100*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDown272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price272,Time[higs_shift]+100*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDown886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price886,Time[higs_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipDown786";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price786,Time[higs_shift]+100*PeriodSeconds(),price786);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown786-886";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[higs_shift],price786,Time[higs_shift]+100*PeriodSeconds(),price886);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown1618";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price1618,Time[higs_shift]+100*PeriodSeconds(),price1618);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipDown556";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],price556,Time[higs_shift]+100*PeriodSeconds(),price556);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);





int up_shift=higs_shift-(shift2-higs_shift);
int down_shift=0;

if ( up_shift < 0 ) up_shift=0;


//Comment("DownShift:",down_shift,"/",shift1,"-",lows_shift,"/",(shift1-lows_shift));

name=sparam+"ShipUp";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],High[higs_shift],Time[up_shift],High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);





name=sparam+"ShipDown";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift1],Low[shift1],Time[up_shift],Low[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);





int right_shift=up_shift-(shift2-shift1);

if ( right_shift < 0 ) right_shift=0;


name=sparam+"ShipRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[up_shift],Low[shift1],Time[right_shift],High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);




name=sparam+"ShipBoard";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],High[shift2],Time[right_shift],High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);

name=sparam+"ShipBoardEx";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[right_shift],High[shift2],Time[right_shift]+10*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"ShipBoardEntry";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[right_shift]+40*PeriodSeconds(),High[shift2]+((High[shift2]-Low[shift1])/5),Time[right_shift]+50*PeriodSeconds(),High[shift2]-((High[shift2]-Low[shift1])/5));
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sparam+"ShipWater";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[shift1+50],Low[shift1],Time[right_shift]+100*PeriodSeconds(),Low[shift1]-((High[shift2]-Low[shift1])/3));
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDodgerBlue);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);


name=sparam+"ShipBoardRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[higs_shift],High[higs_shift],Time[up_shift],Low[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);




name=sparam+"ShipFlagLine";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[up_shift],High[higs_shift]+((High[up_shift]-Low[shift1])/5),Time[up_shift],Low[shift1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);





name=sparam+"ShipDownRight";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[up_shift],High[higs_shift],Time[up_shift]+10*PeriodSeconds(),High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);




name=sparam+"ShipDownRights";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[up_shift]+10*PeriodSeconds(),High[higs_shift],Time[up_shift]+500*PeriodSeconds(),High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"ShipFlag";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[up_shift],High[higs_shift]+((High[up_shift]-Low[shift1])/5),Time[up_shift]+10*PeriodSeconds(),High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);




name=sparam+"ShipFlagAngle";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TRIANGLE,0,Time[up_shift],High[higs_shift],Time[up_shift],High[higs_shift]+((High[up_shift]-Low[shift1])/5),Time[up_shift]+10*PeriodSeconds(),High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

/*
name=sparam+"ShipAnchor";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_ELLIPSE,0,Time[up_shift],High[higs_shift],Time[up_shift],High[higs_shift]+((High[up_shift]-Low[shift1])/5),Time[up_shift]+10*PeriodSeconds(),High[higs_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,0.050);*/




name=sparam+"ShipAnchor";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_ELLIPSE,0,Time[up_shift]-1*PeriodSeconds(),Low[shift1]+(((High[shift2]-Low[shift1])/5)*3),Time[up_shift]-2*PeriodSeconds(),High[shift2]-(((High[shift2]-Low[shift1])/5)*1));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkSlateGray);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
//ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,Scale);
ObjectSetDouble(ChartID(),name,OBJPROP_SCALE,0.050);





return;



name=sparam+"ShipLowv";
ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[lows_shift],Low[lows_shift]);
//ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
}


}

   
   
 }
   






   
   
   
   
   
   
   
   
   
   
  }
//+------------------------------------------------------------------+




double FlagDownUp(double high_price,double low_price,string w,int l,string HShift,string fside) {


//Alert("Selam");


//if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {


/*double distance=low_price+18;
double distance32=low_price+32;*/

int mesafe=100;
int kademe=32;

if ( StringFind(Symbol(),"XAU",0) == -1 || StringFind(Symbol(),"GOLD",0) == -1 ) {kademe=17;}
if ( StringFind(Symbol(),"UK100",0) != -1 || StringFind(Symbol(),"UK100",0) != -1 ) {kademe=32;mesafe=1000;}

double distance32=low_price+(mesafe*kademe)*Point;




ObjectDelete(ChartID(),w+" Distance32");
ObjectCreate(ChartID(),w+" Distance32",OBJ_TREND,0,Time[l]-100*PeriodSeconds(),distance32,Time[l]-5000*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_WIDTH,2); 


ObjectDelete(ChartID(),w+" Distancew");
ObjectCreate(ChartID(),w+" Distancew",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),low_price,Time[l]-5000*PeriodSeconds(),low_price); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_WIDTH,2); 





ObjectDelete(ChartID(),w+" Distance5");
ObjectCreate(ChartID(),w+" Distance5",OBJ_TREND,0,Time[l],low_price+((distance32-low_price)/2),Time[l]-5000*PeriodSeconds(),low_price+((distance32-low_price)/2)); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_WIDTH,1); 



ObjectDelete(ChartID(),w+" Distance");
ObjectCreate(ChartID(),w+" Distance",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),low_price,Time[l]-100*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_WIDTH,2);
/*
ObjectDelete(ChartID(),w+" Distancel");
ObjectCreate(ChartID(),w+" Distancel",OBJ_TREND,0,Time[l],distance,Time[l]-5000*PeriodSeconds(),distance); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_COLOR,clrLightGray); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_WIDTH,2); 
*/


//}






double very_low_price=low_price;
double very_high_price=high_price;
int very_high_shift=0;
int very_low_shift=l;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_low_price > Low[x] ) {very_low_price=Low[x];very_low_shift=x;}

}


for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) {very_high_price=High[x];very_high_shift=x;}

}


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;

double hl_50=very_high_price-(hl_yuzde*50);
double hl_79=very_high_price-(hl_yuzde*79);
double hl_70=very_high_price-(hl_yuzde*70);
double hl_11=very_high_price-(hl_yuzde*89);


ObjectDelete(ChartID(),w+" SupportLevel");
ObjectCreate(ChartID(),w+" SupportLevel",OBJ_RECTANGLE,0,Time[very_low_shift],very_low_price,Time[very_high_shift]+200*PeriodSeconds(),hl_11); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_COLOR,clrDarkBlue); 




ObjectDelete(ChartID(),w+" VeryHLPrice");
ObjectCreate(ChartID(),w+" VeryHLPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[very_high_shift],very_high_price); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_COLOR,clrLightGray); 



ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFibpPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 

ObjectDelete(ChartID(),w+" VeryFibpPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);





//return 0.0;

//double high_price=High[w];
//double low_price=Low[l];         
         
int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=dip_fiyats+Fark*Point;


   string name = w+"Flag5High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   
   name = w+"Flag5Highs"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],low_price,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   
       

       Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*8.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7236=dip_fiyats+Fark*Point;


   name = w+"Flag7High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat7,Time[l]+100*PeriodSeconds(),fiyat7);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,7+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
   
        
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=dip_fiyats+Fark*Point;


   name = w+"Flag8High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12236=dip_fiyats+Fark*Point;


   name = w+"Flag11High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   


       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=dip_fiyats+Fark*Point;


   name = w+"Flag3High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

////////////////////////////////////////////////////////////////////////



   name = w+"Flag3Distance"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+600*PeriodSeconds(),fiyat3-(low_price-very_low_price));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrSteelBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 




////////////////////////////////////////////////////////////////////////   




   
       Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4236=dip_fiyats+Fark*Point;


   name = w+"Flag4High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat4,Time[l]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   
   //Alert("Selam",l);
   

//for (int y=l;y<l+100;y+=2){


for (int y=WindowFirstVisibleBar();y>1;y--){
name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);
}

for (int y=l;y>l-500;y-=4){

if ( y-5 > 0 ) {
name=w+"Bolge"+y;
//ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[y],fiyat4,Time[y-5],fiyat3);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
//Print(y);
}


}
   
      
   
   
flag5_downup_low=low_price;
   
if ( fside == "Left" ) flag5_downup_left=fiyat5;
if ( fside == "right" ) flag5_downup_right=fiyat5;   
flag5_downup=fiyat5;

//sell_mesafe=((flag5_downup_low-flag5_downup)/Point)/kademe;

//sell_profit=int(sell_mesafe);

return fiyat5;

}



double FlagUpDown(double high_price,double low_price,string w,int l,string HShift,string fside) {


//if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {

int mesafe=100;
int kademe=32;

if ( StringFind(Symbol(),"XAU",0) == -1 || StringFind(Symbol(),"GOLD",0) == -1 ) {kademe=17;}
if ( StringFind(Symbol(),"UK100",0) != -1 || StringFind(Symbol(),"UK100",0) != -1 ) {kademe=32;mesafe=1000;}

double distance32=high_price-(mesafe*kademe)*Point;



//double distance=high_price-18;
//double distance32=high_price-32;


ObjectDelete(ChartID(),w+" Distance32");
ObjectCreate(ChartID(),w+" Distance32",OBJ_TREND,0,Time[l]-100*PeriodSeconds(),distance32,Time[l]-5000*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_WIDTH,2); 


ObjectDelete(ChartID(),w+" Distancew");
ObjectCreate(ChartID(),w+" Distancew",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),high_price,Time[l]-5000*PeriodSeconds(),high_price); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_WIDTH,2); 

ObjectDelete(ChartID(),w+" Distance");
ObjectCreate(ChartID(),w+" Distance",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),high_price,Time[l]-100*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_WIDTH,2);



ObjectDelete(ChartID(),w+" Distance5");
ObjectCreate(ChartID(),w+" Distance5",OBJ_TREND,0,Time[l],low_price+((distance32-low_price)/2),Time[l]-5000*PeriodSeconds(),low_price+((distance32-low_price)/2)); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_WIDTH,1); 




/*
ObjectDelete(ChartID(),w+" Distancel");
ObjectCreate(ChartID(),w+" Distancel",OBJ_TREND,0,Time[l],distance,Time[l]-5000*PeriodSeconds(),distance); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_COLOR,clrLightGray); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_WIDTH,2); 
*/


//}




//Alert(high_price);


//Alert(high_price,"/",l);
/*
double very_high_price=high_price;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) very_high_price=High[x];

}

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[l],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 

*/



double very_low_price=low_price;
double very_high_price=high_price;
int very_high_shift=l;
int very_low_shift=0;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_low_price > Low[x] ) {very_low_price=Low[x];very_low_shift=x;}

}


for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) {very_high_price=High[x];very_high_shift=x;}

}


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;

double hl_50=very_low_price+(hl_yuzde*50);
double hl_79=very_low_price+(hl_yuzde*79);
double hl_70=very_low_price+(hl_yuzde*70);
double hl_11=very_low_price+(hl_yuzde*89);


ObjectDelete(ChartID(),w+" SupportLevel");
ObjectCreate(ChartID(),w+" SupportLevel",OBJ_RECTANGLE,0,Time[very_high_shift],very_high_price,Time[very_low_shift]+200*PeriodSeconds(),hl_11); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" SupportLevel",OBJPROP_COLOR,clrDarkBlue); 



ObjectDelete(ChartID(),w+" VeryHLPrice");
ObjectCreate(ChartID(),w+" VeryHLPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[very_low_shift],very_low_price); ///
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_COLOR,clrLightGray); 



ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFiboPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_BACK,true); 

ObjectDelete(ChartID(),w+" VeryFiboPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);




//return 0.0;

//double high_price=High[w];
//double low_price=Low[l];         
         
int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=tepe_fiyats-Fark*Point;


   string name = w+"Flag5Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
   name = w+"Flag5Lows"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],high_price,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   
        


       Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*8.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7236=tepe_fiyats-Fark*Point;


   name = w+"Flag7Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat7,Time[l]+100*PeriodSeconds(),fiyat7);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,7+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
           
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=tepe_fiyats-Fark*Point;


   name = w+"Flag8Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12236=tepe_fiyats-Fark*Point;


   name = w+"Flag11Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   


       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=tepe_fiyats-Fark*Point;


   name = w+"Flag3Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

////////////////////////////////////////////////////////////////////////



   name = w+"Flag3Distance"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+600*PeriodSeconds(),fiyat3+(very_high_price-high_price));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrSteelBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 




////////////////////////////////////////////////////////////////////////   
   
   
   
   
   

       Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat436=tepe_fiyats-Fark*Point;


   name = w+"Flag4Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat4,Time[l]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,4+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


for (int y=WindowFirstVisibleBar();y>1;y--){
name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);
}


   
   
for (int y=l;y>l-300;y-=4){

name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);

if ( y-5 > 0 ) {
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[y],fiyat3,Time[y-5],fiyat4);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
//Print(y);
}


}
      
   

flag5_updown_high=high_price;
   
if ( fside == "Left" ) flag5_updown_left=fiyat5;
if ( fside == "right" ) flag5_updown_right=fiyat5;   
flag5_updown=fiyat5;


//buy_mesafe=((flag5_updown_high-flag5_updown)/Point)/kademe;
//buy_profit=int(buy_mesafe);

return fiyat5;   

}

double flag5_downup_left;
double flag5_downup_right;
double flag5_downup=1;
double flag5_downup_low=1000000;

double flag5_updown_left;
double flag5_updown_right;
double flag5_updown=-1;
double flag5_updown_high=-1;

double buy_mesafe=100;
double sell_mesafe=100;

int buy_profit=8;
int sell_profit=8;     


void AlertObject(){

//Alert("Last_Object",last_object);

if ( ObjectFind(ChartID(),last_object) == -1 ) { 
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_HLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRIANGLE);
}

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}
       
       
       

/////////////////////////////////////////////////////////////////////////////////////////////
// Copy Text Clipboard
////////////////////////////////////////////////////////////////////////////////////////////


bool CopyTextToClipboard(string Text)
{
//return false;

   bool bReturnvalue = false;
   
   // Try grabbing ownership of the clipboard 
   if (OpenClipboard(0) != 0) {
   

      // Try emptying the clipboard
      if (EmptyClipboard() != 0) {
         // Try allocating a block of global memory to hold the text 
         int lnString = StringLen(Text);
         int hMem = GlobalAlloc(GMEM_MOVEABLE, (lnString * 2) + 2);
         
         
         
         //int hMem = GlobalAlloc(GMEM_MOVEABLE, lnString + 1);
         
         if (hMem != 0) {
            // Try locking the memory, so that we can copy into it
            int ptrMem = GlobalLock(hMem);
            if (ptrMem != 0) {
               // Copy the string into the global memory
               lstrcpyW(ptrMem, Text); 
               //lstrcpyA(ptrMem, Text);            
               // Release ownership of the global memory (but don't discard it)
               GlobalUnlock(hMem);            
               //Alert(lnString,"/",Text,"/",hMem);

               // Try setting the clipboard contents using the global memory
               if (SetClipboardData(CF_UNICODETEXT, hMem) != 0) {
               //if (SetClipboardData(CF_TEXT, hMem) != 0) {
                  // Okay
                  bReturnvalue = true;   
               } else {
                  // Failed to set the clipboard using the global memory
                  GlobalFree(hMem);
               }
            } else {
               // Meemory allocated but not locked
               GlobalFree(hMem);
            }      
         } else {
            // Failed to allocate memory to hold string 
         }
      } else {
         // Failed to empty clipboard
      }
      // Always release the clipboard, even if the copy failed
      CloseClipboard();
   } else {
      // Failed to open clipboard
   }

   return (bReturnvalue);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get Text From Clipboard
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

string GetTextFromClipboard()
{
   bool bReturnvalue = false;
   char cData[256];
   ArrayInitialize(cData,0);
   
   // Test to see if we can open the clipboard first.
   if (OpenClipboard(0) != 0) 
   {
      if (IsClipboardFormatAvailable(CF_TEXT) != 0
      || IsClipboardFormatAvailable(CF_OEMTEXT) != 0)
      {
         // Retrieve the Clipboard data (specifying that 
         // we want ANSI text (via the CF_TEXT value).
         int hMem = GetClipboardData(CF_TEXT);
         if(hMem != 0)
         {
            // Call GlobalLock so that to retrieve a pointer
            // to the data associated with the handle returned
            // from GetClipboardData.
            int ptrMem = GlobalLock(hMem);
            if(ptrMem != 0)
            {
               // Set a local string variable to the data
               lstrcpyW(cData, ptrMem);
            }
            else
            {
               //Locking did not succeed
            }
            // Unlock the global memory.
            GlobalUnlock(hMem);
          }
          else
          {
            //Clipboard data is Text, but could not retrieve.
          }
      }
      else
      { 
         Print("There is no text (ANSI) data on the Clipboard.");
      }
      // Finally, when finished I simply close the Clipboard
      // which has the effect of unlocking it so that other
      // applications can examine or modify its contents.
      CloseClipboard();
   }
   return(CharArrayToString(cData));
}     
       
    /*   
void DrawEllipse(string objName,datetime dtTime1,double dblPrice1,datetime dtTime2,double dblPrice2,color Color, double Scale)
  {

   if(ObjectFind(objName)<0) ObjectCreate(NULL,objName,OBJ_ELLIPSE,0,dtTime1,dblPrice1,dtTime2,dblPrice2);
   ObjectSet(objName,OBJPROP_SCALE,Scale);
   ObjectSet(objName,OBJPROP_COLOR,Color);
   ObjectSet(objName,OBJPROP_FILL,1);
   ObjectSet(objName,OBJPROP_BACK,False);
  }  
//+------------------------------------------------------------------+
*/

//////////////////////////////////////////////////////////////////////
string TFtoStr(int period) {

string demo="";

if (IsDemo()) demo="DEMO ";


 switch(period) {
  case 1     : return(demo+"M1");  break;
  case 5     : return(demo+"M5");  break;
  case 15    : return(demo+"M15"); break;
  case 30    : return(demo+"M30"); break;
  case 60    : return(demo+"H1");  break;
  case 240   : return(demo+"H4");  break;
  case 1440  : return(demo+"D1");  break;
  case 10080 : return(demo+"W1");  break;
  case 43200 : return(demo+"MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 
 
 return("UNKNOWN");
}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double TopZero(double n, double d)
{
if (d==0 || d<0) return(0);  else return(n-d);
} 
//////////////////////////////////////////////////////////////////////} 

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 



int WFVB = WindowFirstVisibleBar();
   int mumanaliz_shift=0;
   int mumanaliz_shiftb=WindowFirstVisibleBar();
   

void MumAnaliz() {


return;

int MumAnaliz_Oran=10;


if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {
MumAnaliz_Oran=5;
//Alert("Mum:",MumAnaliz_Oran);
}


if ( WFVB == WindowFirstVisibleBar() ) return;
  
  WFVB = WindowFirstVisibleBar();

  
   //ChartAngle(Symbol(),ChartID(),Period());
   
   //ObjectsDeleteAll();
   
   
   
   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   //Print(Bars,"/",mumanaliz_shift,"/",mumanaliz_shiftb);
   
   
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {

   bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);
   
   }
   
   
   
   bar_ortalama = DivZero(bar_pip,bar_toplam);
   

   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   
   
   ObjectDelete(ChartID(),"VLINE"+t);
   if ( MathAbs(Close[t]-Open[t]) < bar_ortalama/MumAnaliz_Oran ) {

   
   //ObjectCreate(ChartID(),"VLINE"+t,OBJ_VLINE,0,Time[t],Ask);   
   
   
   
   if ( (High[t] - Low[t]) < bar_ortalama/MumAnaliz_Oran ) {
   
   
   /*if ( Open[t] > Close[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }
   
   if ( Close[t] > Open[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }

   if ( Close[t] == Open[t] ) {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],,Time[t],);   
   }   */
   
      
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],High[t]+bar_ortalama,Time[t],Low[t]-bar_ortalama);   
   
   
   } else {
   ObjectCreate(ChartID(),"VLINE"+t,OBJ_TRENDBYANGLE,0,Time[t],High[t],Time[t],Low[t]);   
   }
   
   
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_SELECTED,false);
   
   if ( Open[t] > Close[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"DOWN");
   }

   if ( Close[t] > Open[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"UP");
   }

   if ( Close[t] == Open[t] ) {
   ObjectSetInteger(ChartID(),"VLINE"+t,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),"VLINE"+t,OBJPROP_TOOLTIP,"MIDDLE");
   }      
      
      
   
   
   }
   
   }
   
      
   
   /*
Comment("Bars:",Bars,"WindowBarsPerChart",WindowBarsPerChart(),"WindowFirstVisibleBar()",WindowFirstVisibleBar(),"WindowPriceMax()",WindowPriceMax(),"WindowPriceMin()",WindowPriceMin(),"WindowFirstVisibleBar()-WindowBarsPerChart()",WindowFirstVisibleBar()-WindowBarsPerChart(),"shift:",mumanaliz_shift,"/",mumanaliz_shiftb,"=",mumanaliz_shiftb-mumanaliz_shift,"\n bar_pip",bar_pip,"\n bar_ortalama",bar_ortalama);

   
   ObjectDelete(ChartID(),"VLINE");
   ObjectCreate(ChartID(),"VLINE",OBJ_VLINE,0,Time[WindowFirstVisibleBar()],Ask);

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   ObjectDelete(ChartID(),"VLINEE");
   ObjectCreate(ChartID(),"VLINEE",OBJ_VLINE,0,Time[WindowFirstVisibleBar()-WindowBarsPerChart()],Ask);
   } else {
   ObjectDelete(ChartID(),"VLINEE");
   ObjectCreate(ChartID(),"VLINEE",OBJ_VLINE,0,Time[0],Ask);   
   }

   ObjectDelete(ChartID(),"HLINE");
   ObjectCreate(ChartID(),"HLINE",OBJ_HLINE,0,Time[WindowFirstVisibleBar()],WindowPriceMax());

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   ObjectDelete(ChartID(),"HLINEE");
   ObjectCreate(ChartID(),"HLINEE",OBJ_HLINE,0,Time[WindowFirstVisibleBar()-WindowBarsPerChart()],WindowPriceMin());      
   } else {
   ObjectDelete(ChartID(),"HLINEE");
   ObjectCreate(ChartID(),"HLINEE",OBJ_HLINE,0,Time[0],WindowPriceMin());         
   }   */

}  
  

////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////





void LongShip(int start_shift,int finish_shift,string sp) {

//Alert(start_shift,"/",finish_shift);


//if ( buy_order_system == true ) {

/////////////////////////////////////////////////////////////////////////////////////


buy_trend_level=0;

buy_trend_high=High[finish_shift];
buy_trend_low=Low[start_shift];
buy_trend_level=finish_shift-start_shift;
buy_high_shift=finish_shift;
buy_low_shift=start_shift;
buy_flag_414down=false;
buy_flag_272up=false;
buy_flag_272down=false;



if ( buy_trend_level != 0 ) {

if ( (High[buy_high_shift]-Low[buy_low_shift])/Point < 60 ) return;

last_low=-1;
last_low_time;
last_high=-1;
last_high_time=-1;
last_touch_time=-1;
last_touch=-1;
last_touch_finish=false;
fibo_level=false;
order_send=false;
buy_mode=true;
buy_flag_414down=false;
buy_flag_272up=false;
buy_flag_272down=false;




int shift=iBarShift(Symbol(),Period(),Time[buy_high_shift]);

bool find=false;

for (int t=shift+20;t<shift+50;t++){

if ( Low[t] < Low[buy_low_shift] && find==false) {
find=true;
}

}

find=false;


double high_price=High[buy_high_shift];
double low_price=Low[buy_low_shift];


int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
   
   




      


       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=dip_fiyats+Fark*Point;


   string name = sp+"Flag3High";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat3,Time[start_shift]+50*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   
   



      
   

       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=dip_fiyats+Fark*Point;


   name = sp+"Flag5High";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat5,Time[start_shift]+50*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   
   
      
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=dip_fiyats+Fark*Point;


   name = sp+"Flag8High";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat8,Time[start_shift]+50*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11236=dip_fiyats+Fark*Point;


   name = sp+"Flag11High";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat11,Time[start_shift]+50*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   
   
         

   
      
buy_tp3=fiyat3;
buy_tp3=fiyat3;
buy_tp5=fiyat5;
buy_tp8=fiyat8;
buy_tp11=fiyat11;


if ( find == false ) {


/*
string name=Time[buy_high_shift]+"T";
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[buy_low_shift],Low[buy_low_shift],Time[buy_high_shift],High[buy_high_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);*/



name=sp+"THigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[buy_high_shift],High[buy_high_shift],Time[buy_high_shift]+50*PeriodSeconds(),High[buy_high_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
//ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(High[2]-Low[4])/Point());


last_high=High[buy_high_shift];
last_high_time=Time[buy_high_shift];


}






}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

//for(int l=start_shift;l>1;l--) {

for(int l=start_shift;l>start_shift-100;l--) {

if ( l < 0 ) continue;



if ( Time[l] > last_high_time && last_high != -1 ) {

if ( Close[l] > last_high ) {


string name=sp+"TLowCloseHigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],Close[l],Time[l]+100*PeriodSeconds(),High[l]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);




name=sp+"THighTouch";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],last_high-100*Point,Time[l],last_high+100*Point);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
last_high=-1;

last_touch_time=Time[l];
last_touch=High[l];


int high_shift=iBarShift(Symbol(),Period(),last_high_time);

//double last_high=-1;
int last_low_shift=0;
last_low=1000000;
//for(int h=high_shift;h>=1;h--) {
for(int h=high_shift;h>=high_shift-100;h--) {
if ( h < 0 ) continue;
if(Low[h] < last_low ) {last_low=Low[h];
last_low_shift=h;
last_low_time=Time[h];
}
}

name=sp+"TLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[last_low_shift],last_low,Time[last_low_shift]+30*PeriodSeconds(),last_low);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);






}

}



if ( last_touch != -1 ) {

if ( High[l] > last_touch ) {
string name=sp+"THighReal";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],High[l],Time[l]+50*PeriodSeconds(),High[l]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");
last_touch=High[l];

}


}

if ( last_touch != -1 && last_touch > High[l] && last_touch_finish==false) {

Comment("last_touch:",last_touch,",",last_low);


ObjectCreate(ChartID(),sp+"V",OBJ_VLINE,0,Time[l],Ask);



double yuzde=(last_touch-last_low)/100;

price414=last_touch+(41.4*yuzde);
buy_sl=last_low-(41.4*yuzde);
//sell_sl=last_high+(68.6*yuzde);

buy_sl=last_touch;

double buy_fark=buy_trend_low-last_low;
double buy_real_tp=buy_tp3-buy_fark;


string name=sp+"TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,buy_tp3,last_touch_time+230*PeriodSeconds(),buy_tp3-(buy_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

buy_tp3=buy_real_tp;


name=sp+"TP5";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,buy_tp5,last_touch_time+230*PeriodSeconds(),buy_tp5-(buy_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sp+"TP8";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,buy_tp8,last_touch_time+230*PeriodSeconds(),buy_tp8-(buy_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sp+"TP11";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,buy_tp11,last_touch_time+230*PeriodSeconds(),buy_tp11-(buy_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);







name=sp+"T414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,last_touch_time,price414,last_touch_time+30*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

price272=last_touch+(27.2*yuzde);

name=sp+"T272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,last_touch_time,price272,last_touch_time+30*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


last_touch=-1;
last_touch_finish=true;

fibo_level=true;


   /*string Sinyal=Symbol()+"-"+TFtoStr(Period())+"-MSB-BUY-"+Time[1];
   string usym = Symbol();
   usym = StringToUpper(usym);
   string SinyalS = "";//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);*/
   

}



/*
if ( sell_flag_414down == false ) {
if ( Close[1] < price414 ) {
sell_flag_414down=true;
}
}

if ( sell_flag_414down == true && sell_flag_272up == false ) {
if ( Close[1] > price272 ) {
sell_flag_272up=true;
}
}*/

if ( buy_flag_272up == false && buy_flag_272down == false ) {
if ( Close[1] > price272 ) {
buy_flag_272up=true;
/*ObjectDelete(ChartID(),"272up"+Time[1]);
ObjectCreate(ChartID(),"272up"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"272up"+Time[1],OBJPROP_WIDTH,3);*/

}
}


if ( buy_flag_272up == true && buy_flag_272down == false ) {
if ( Close[1] < price272 ) {
buy_flag_272down=true;
/*ObjectDelete(ChartID(),"272down"+Time[1]);
ObjectCreate(ChartID(),"272down"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"272down"+Time[1],OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"272down"+Time[1],OBJPROP_COLOR,clrYellow);*/

}
}



}





//if ( fibo_level == true && order_send == false && OrdersTotal()==0 && sell_flag_414down == true && sell_flag_272up == true ) {
if ( fibo_level == true && order_send == false && OrdersTotal()==0 && buy_flag_272up == true && buy_flag_272down == true ) {

if ( Close[1] > price414 ) {


//sell_sl=Bid+(Bid-sell_tp3);

//buy_sl=0;


//OrderSend(Symbol(),OP_BUY,1,Ask,0,buy_sl,buy_tp3,"BUY",0,0,clrNONE);

buy_tp3=NormalizeDouble(buy_tp3,Digits);


//double sell_price=NormalizeDouble(Bid-((buy_tp3-Ask)/3),Digits);
//double sell_tp=NormalizeDouble(Bid-((buy_tp3-Ask)*3),Digits);
/*

double sell_price=NormalizeDouble(Bid-((Ask-last_low)/3),Digits);
double sell_tp=NormalizeDouble(sell_price-((Ask-last_low)*3),Digits);

//(Ask-last_low)
buy_tp3=Ask+((Ask-last_low)*3);

recovery_sell_ticket=OrderSend(Symbol(),OP_SELLSTOP,1.4,sell_price,0,buy_tp3,sell_tp);





OrderSend(Symbol(),OP_BUY,1,Ask,0,sell_tp,buy_tp3,"BUY",0,0,clrNONE);*/

//OrderSend(Symbol(),OP_BUY,1,Ask,0,buy_sl,buy_tp3,"BUY",0,0,clrNONE);


buy_mode=false;
order_send=true;












}




}





//}


}


void ShortShip(int start_shift,int finish_shift,string sp) {

//Alert(start_shift,"/",finish_shift);



//if ( sell_order_system == true ) {


sell_trend_level=0;

sell_trend_high=High[start_shift];
sell_trend_low=Low[finish_shift];
sell_trend_level=finish_shift-start_shift;
sell_high_shift=start_shift;
sell_low_shift=finish_shift;
sell_flag_414down=false;
sell_flag_272up=false;
sell_flag_272down=false;


if ( sell_trend_level != 0 ) {

if ( (High[sell_high_shift]-Low[sell_low_shift])/Point < 60 ) return;

last_low=-1;
last_low_time;
last_high=-1;
last_high_time=-1;
last_touch_time=-1;
last_touch=-1;
last_touch_finish=false;
fibo_level=false;
order_send=false;
sell_mode=true;
sell_flag_414down=false;
sell_flag_272up=false;
sell_flag_272down=false;




int shift=iBarShift(Symbol(),Period(),Time[sell_low_shift]);

bool find=false;

for (int t=shift+20;t<shift+50;t++){

if ( High[t] > High[sell_high_shift] && find==false) {
find=true;
}

}

find=false;


double high_price=High[sell_high_shift];
double low_price=Low[sell_low_shift];



int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
 
 
       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=tepe_fiyats-Fark*Point;


   string name = sp+"Flag3Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat3,Time[start_shift]+100*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
   
   

       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=tepe_fiyats-Fark*Point;


   name = sp+"Flag5Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat5,Time[start_shift]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
   
   

       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=tepe_fiyats-Fark*Point;


   name = sp+"Flag8Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat8,Time[start_shift]+100*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
   
         
   
       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat11236=tepe_fiyats-Fark*Point;


   name = sp+"Flag11Low";

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[start_shift],fiyat11,Time[start_shift]+100*PeriodSeconds(),fiyat11);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false); 
   
   
      
   
   
      
sell_tp3=fiyat3;
sell_tp5=fiyat5;
sell_tp8=fiyat8;
sell_tp11=fiyat11;


if ( find == false ) {


/*
string name=Time[sell_low_shift]+"T";
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[sell_low_shift],Low[sell_low_shift],Time[sell_high_shift],High[sell_high_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,false);*/


name=sp+"TLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[sell_low_shift],Low[sell_low_shift],Time[sell_low_shift]+50*PeriodSeconds(),Low[sell_low_shift]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
//ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(High[2]-Low[4])/Point());


last_low=Low[sell_low_shift];
last_low_time=Time[sell_low_shift];


}






}


///////////////////////////////////////////////////////////////////////////////


//for(int l=start_shift;l>1;l--) {
for(int l=start_shift;l>start_shift-100;l--) {

if ( l < 0 ) continue;

//Print(l);


if ( Time[l] > last_low_time && last_low != -1 ) {

// Bölgenin Low'unun altında kapatan close Low'u = last_touch oluyor , sonra gelen tek yükseliş mumu ile onaylanıyor.
// Yeni low Close-Low altında kapatan
if ( Close[l] < last_low ) {


string name=sp+"TLowCloseLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],Close[l],Time[l]+100*PeriodSeconds(),Low[l]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);



name=sp+"TLowTouch";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],last_low-100*Point,Time[l],last_low+100*Point);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
last_low=-1;

last_touch_time=Time[l];
last_touch=Low[l];


int low_shift=iBarShift(Symbol(),Period(),last_low_time);

//double last_high=-1;
int last_high_shift=0;
//for(int h=low_shift;h>=;h--) {
for(int h=low_shift;h>=low_shift-100;h--) {
if ( h < 0 ) continue;
if(High[h] > last_high ) {last_high=High[h];
last_high_shift=h;
last_high_time=Time[h];
}
}

name=sp+"THigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[last_high_shift],last_high,Time[last_high_shift]+30*PeriodSeconds(),last_high);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);






}

}




if ( last_touch != -1 ) {

if ( Low[l] < last_touch ) {
string name=sp+"TLowReal";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[1],Low[1],Time[1]+50*PeriodSeconds(),Low[1]);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"");
last_touch=Low[l];

}


}






if ( last_touch != -1 && last_touch < Low[l] && last_touch_finish==false) {

Comment("last_touch:",last_touch);


ObjectCreate(ChartID(),sp+"V",OBJ_VLINE,0,Time[l],Ask);

//Alert(last_high,"/",last_touch);


double yuzde=(last_high-last_touch)/100;

price414=last_touch-(41.4*yuzde);
sell_sl=last_high+(41.4*yuzde);
//sell_sl=last_high+(68.6*yuzde);

sell_sl=last_touch;


double sell_fark=last_high-sell_trend_high;
double sell_real_tp=sell_tp3+sell_fark;


string name=sp+"TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,sell_tp3,last_touch_time+230*PeriodSeconds(),sell_tp3+(sell_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

sell_tp3=sell_real_tp;



name=sp+"TP5";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,sell_tp5,last_touch_time+230*PeriodSeconds(),sell_tp5+(sell_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sp+"TP8";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,sell_tp8,last_touch_time+230*PeriodSeconds(),sell_tp8+(sell_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sp+"TP11";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,last_touch_time,sell_tp11,last_touch_time+230*PeriodSeconds(),sell_tp11+(sell_fark));
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);



name=sp+"T414";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,last_touch_time,price414,last_touch_time+30*PeriodSeconds(),price414);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

price272=last_touch-(27.2*yuzde);

name=sp+"T272";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,last_touch_time,price272,last_touch_time+30*PeriodSeconds(),price272);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


last_touch=-1;
last_touch_finish=true;

fibo_level=true;


   /*string Sinyal=Symbol()+"-"+TFtoStr(Period())+"-MSB-SELL-"+Time[1];
   string usym = Symbol();
   usym = StringToUpper(usym);
   string SinyalS = "";//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);*/

}



/*
if ( sell_flag_414down == false ) {
if ( Close[1] < price414 ) {
sell_flag_414down=true;
}
}

if ( sell_flag_414down == true && sell_flag_272up == false ) {
if ( Close[1] > price272 ) {
sell_flag_272up=true;
}
}*/

if ( sell_flag_272down == false && sell_flag_272up == false ) {
if ( Close[l] < price272 ) {
sell_flag_272down=true;
}
}


if ( sell_flag_272down == true && sell_flag_272up == false ) {
if ( Close[l] > price272 ) {
sell_flag_272up=true;
}
}


}




//if ( fibo_level == true && order_send == false && OrdersTotal()==0 && sell_flag_414down == true && sell_flag_272up == true ) {
if ( fibo_level == true && order_send == false && OrdersTotal()==0 && sell_flag_272down == true && sell_flag_272up == true ) {

if ( Close[1] < price414 ) {


//sell_sl=Bid+(Bid-sell_tp3);

//sell_sl=0;


//double buy_price=Ask+((Bid-sell_tp3)/3);
//double buy_tp=buy_price+((Bid-sell_tp3)*3);
/*
double buy_price=Ask+((last_high-Bid)/3);
double buy_tp=buy_price+((last_high-Bid)*3);

sell_tp3=Bid-((last_high-Bid)*3);

recovery_buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,1.4,buy_price,0,sell_tp3,buy_tp);

OrderSend(Symbol(),OP_SELL,1,Bid,0,buy_tp,sell_tp3,"SELL",0,0,clrNONE);
*/


//OrderSend(Symbol(),OP_SELL,1,Bid,0,sell_sl,sell_tp3,"SELL",0,0,clrNONE);
sell_mode=false;
order_send=true;

}




}



//}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////




}
  
  

int UP=0;
int DOWN=1;
int EQ=2;

double sell_tp3;
double buy_tp3;

double sell_tp5;
double buy_tp5;

double sell_tp8;
double buy_tp8;

double sell_tp11;
double buy_tp11;


double last_low=-1;
int last_low_time=-1;
double last_high=-1;
int last_high_time=-1;
int last_touch_time=-1;
double last_touch=-1;
bool last_touch_finish=false;
double price414;
double price272;
bool fibo_level=false;
bool order_send=false;

bool sell_mode=false;
bool buy_mode=false;


bool sell_trend=false;
bool buy_trend=false;

double sell_trend_high;
double sell_trend_low;
int sell_trend_level;
int sell_high_shift;
int sell_low_shift;

double sell_sl;
double buy_sl;

double buy_trend_high;
double buy_trend_low;
int buy_trend_level;
int buy_high_shift;
int buy_low_shift;

bool buy_flag_414down=false;
bool buy_flag_272up=false;
bool buy_flag_272down=false;

bool sell_flag_414down=false;
bool sell_flag_272up=false;
bool sell_flag_272down=false;

string order_mode_str="";

//string last_select_object;
//string last_object;

bool shipmsb=false;
  
  
  
  
void SwingMeter(string sparam) {

int order_type=-1;
bool box_lock=false;
bool low_control=false;
bool high_control=false;

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRIANGLE && StringFind(sparam,"Second",0) == -1 && StringFind(sparam,"Third",0) == -1 && box_lock == false) {

//Alert("Üçgen");

last_select_object=sparam;
last_object=sparam;


          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR,clrLightSlateGray);
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,clrLightSlateGray);
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_FILL,clrNONE);
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_BACK,false);

//Print(obj_prc1,"/",obj_prc2,"/",obj_prc3);


int shift1 = iBarShift(Symbol(),Period(),obj_time1);
int shift2 = iBarShift(Symbol(),Period(),obj_time2);
int shift3 = iBarShift(Symbol(),Period(),obj_time3);

int obj_shift1 = iBarShift(Symbol(),Period(),obj_time1);
int obj_shift2 = iBarShift(Symbol(),Period(),obj_time2);
int obj_shift3 = iBarShift(Symbol(),Period(),obj_time3);



if ( obj_prc2 > obj_prc1 ) {


ObjectMove(ChartID(),last_select_object,0,obj_time1,Low[obj_shift1]);
ObjectMove(ChartID(),last_select_object,1,obj_time2,High[obj_shift2]);
if ( Open[obj_shift3] > Close[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Close[obj_shift3]);
if ( Close[obj_shift3] > Open[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Open[obj_shift3]);

obj_prc1=Low[obj_shift1];
obj_prc2=High[obj_shift2];

if ( high_control == true ) {
obj_prc1=High[obj_shift1];
ObjectMove(ChartID(),last_select_object,0,obj_time1,High[obj_shift1]);
}

if ( Open[obj_shift3] > Close[obj_shift3] ) obj_prc3=Close[obj_shift3];
if ( Close[obj_shift3] > Open[obj_shift3] ) obj_prc3=Open[obj_shift3];



}


if ( obj_prc1 > obj_prc2 ) {


ObjectMove(ChartID(),last_select_object,0,obj_time1,High[obj_shift1]);
ObjectMove(ChartID(),last_select_object,1,obj_time2,Low[obj_shift2]);
if ( Open[obj_shift3] > Close[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Open[obj_shift3]);
if ( Close[obj_shift3] > Open[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Close[obj_shift3]);

obj_prc1=High[obj_shift1];
obj_prc2=Low[obj_shift2];

if ( high_control == true ) {
obj_prc1=Low[obj_shift1];
ObjectMove(ChartID(),last_select_object,0,obj_time1,Low[obj_shift1]);
}


if ( Open[obj_shift3] > Close[obj_shift3] ) obj_prc3=Open[obj_shift3];
if ( Close[obj_shift3] > Open[obj_shift3] ) obj_prc3=Close[obj_shift3];



}





string name=sparam+"T1";

ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TEXT,0,Time[shift1],obj_prc1);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"1");
ObjectSetInteger(ChartID(),name,OBJPROP_FONTSIZE,11);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetString(ChartID(),name,OBJPROP_FONT,"Arial");
ObjectSetInteger(ChartID(),name,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);

name=sparam+"T2";

ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TEXT,0,Time[shift2],obj_prc2);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"2");
ObjectSetInteger(ChartID(),name,OBJPROP_FONTSIZE,11);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetString(ChartID(),name,OBJPROP_FONT,"Arial");
ObjectSetInteger(ChartID(),name,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);

name=sparam+"T3";

ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TEXT,0,Time[shift3],obj_prc3);
ObjectSetString(ChartID(),name,OBJPROP_TEXT,"3");
ObjectSetInteger(ChartID(),name,OBJPROP_FONTSIZE,11);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetString(ChartID(),name,OBJPROP_FONT,"Arial");
ObjectSetInteger(ChartID(),name,OBJPROP_ANCHOR,ANCHOR_LEFT_LOWER);
ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,False);


/*
double prices[3,2];
prices[0,0]=obj_prc1;
prices[0,1]=shift1;
prices[1,0]=obj_prc2;
prices[1,1]=shift2;
prices[2,0]=obj_prc3;
prices[2,1]=shift3;

ArraySort(prices,WHOLE_ARRAY,0,MODE_DESCEND);

for ( int i=0;i<3;i++) {
Print(i,"/",prices[i,0],"/",int(prices[i,1]));
}*/

     
     //Print("Deneme");
     

//Print("ArraySize:",ArraySize(prices));


if ( obj_prc1 < obj_prc2 ) {

/*
ObjectMove(ChartID(),last_select_object,0,obj_time1,Low[obj_shift1]);
ObjectMove(ChartID(),last_select_object,1,obj_time2,High[obj_shift2]);
if ( Open[obj_shift3] > Close[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Close[obj_shift3]);
if ( Close[obj_shift3] > Open[obj_shift3] ) ObjectMove(ChartID(),last_select_object,2,obj_time3,Open[obj_shift3]);
*/


order_type=OP_BUY;

if ( shift1 < shift2 ) {
int shift1s=shift1;
int shift2s=shift2;
shift1=shift2s;
shift2=shift1s;
}




Comment("Order Type:",order_type," BUY");

int rec_shift=shift2-(shift1-shift2);


double yuzde=(obj_prc2-obj_prc1)/100;
double price50=obj_prc1-(yuzde*50);
double price30=obj_prc1-(yuzde*30);
double price60=obj_prc1-(yuzde*60);

double yuzde3=(obj_prc3-obj_prc1)/100;
double price503=obj_prc1-(yuzde3*50);
double price303=obj_prc1-(yuzde3*30);
double price603=obj_prc1-(yuzde3*60);




if ( rec_shift < 0 ) rec_shift = 0;


ObjectDelete(ChartID(),last_select_object+"Line3");
ObjectCreate(ChartID(),last_select_object+"Line3",OBJ_TREND,0,Time[shift3],obj_prc3,Time[0],obj_prc3);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_COLOR,clrBlack);


ObjectDelete(ChartID(),last_select_object+"Line50");
ObjectCreate(ChartID(),last_select_object+"Line50",OBJ_TREND,0,Time[shift2],price50,Time[rec_shift],price50);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_COLOR,clrBlack);

ObjectDelete(ChartID(),last_select_object+"Line30");
ObjectCreate(ChartID(),last_select_object+"Line30",OBJ_TREND,0,Time[shift2],price30,Time[rec_shift],price30);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_COLOR,clrNavy);

ObjectDelete(ChartID(),last_select_object+"Line60");
ObjectCreate(ChartID(),last_select_object+"Line60",OBJ_TREND,0,Time[shift2],price60,Time[rec_shift],price60);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_COLOR,clrNavy);


int shiftt=shift2-(shift1-shift2)/2;
/*
ObjectDelete(ChartID(),last_select_object+"LineSmalls");
//ObjectCreate(ChartID(),last_select_object+"LineSmalls",OBJ_TREND,0,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1),Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectCreate(ChartID(),last_select_object+"LineSmalls",OBJ_TREND,0,obj_time1-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_WIDTH,1);
*/



ObjectDelete(ChartID(),last_select_object+"LineSmall");
ObjectCreate(ChartID(),last_select_object+"LineSmall",OBJ_TREND,0,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1),Time[0],obj_prc1-(obj_prc3-obj_prc1));
//ObjectCreate(ChartID(),last_select_object+"LineSmall",OBJ_TREND,0,obj_time1-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"Line503");
ObjectCreate(ChartID(),last_select_object+"Line503",OBJ_TREND,0,Time[shiftt],price503,Time[rec_shift],price503);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_WIDTH,2);

ObjectDelete(ChartID(),last_select_object+"Line303");
ObjectCreate(ChartID(),last_select_object+"Line303",OBJ_TREND,0,Time[shiftt],price303,Time[rec_shift],price303);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_WIDTH,2);

ObjectDelete(ChartID(),last_select_object+"Line603");
ObjectCreate(ChartID(),last_select_object+"Line603",OBJ_TREND,0,Time[shiftt],price603,Time[rec_shift],price603);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"Line6303");
ObjectCreate(ChartID(),last_select_object+"Line6303",OBJ_TREND,0,Time[shiftt],price303,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"UP");
ObjectDelete(ChartID(),last_select_object+"UP");
ObjectCreate(ChartID(),last_select_object+"UP",OBJ_RECTANGLE,0,Time[shift1],obj_prc1,Time[shift2],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_BACK,false);

ObjectDelete(ChartID(),last_select_object+"DOWN");
ObjectCreate(ChartID(),last_select_object+"DOWN",OBJ_RECTANGLE,0,Time[shift2],obj_prc1,Time[rec_shift],obj_prc1-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_BACK,false);


ObjectDelete(ChartID(),last_select_object+"Line");
ObjectCreate(ChartID(),last_select_object+"Line",OBJ_TREND,0,Time[shift1]-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"Lines");
ObjectCreate(ChartID(),last_select_object+"Lines",OBJ_TREND,0,Time[shift2],obj_prc2-(obj_prc2-obj_prc1),Time[0],obj_prc2-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"Lineleft");
ObjectCreate(ChartID(),last_select_object+"Lineleft",OBJ_TREND,0,Time[shift1],obj_prc1,Time[shift1],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineright");
ObjectCreate(ChartID(),last_select_object+"Lineright",OBJ_TREND,0,Time[shift2],obj_prc1,Time[shift2],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_SELECTABLE,false);


ObjectDelete(ChartID(),last_select_object+"Lineleft2");
ObjectCreate(ChartID(),last_select_object+"Lineleft2",OBJ_TREND,0,Time[shift2],obj_prc2,Time[shift2],obj_prc1-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineright2");
ObjectCreate(ChartID(),last_select_object+"Lineright2",OBJ_TREND,0,Time[rec_shift],obj_prc2,Time[rec_shift],obj_prc1-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineleftb");
ObjectCreate(ChartID(),last_select_object+"Lineleftb",OBJ_TREND,0,Time[shift2],obj_prc1-(obj_prc2-obj_prc1),Time[rec_shift],obj_prc1-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineleftbs");
ObjectCreate(ChartID(),last_select_object+"Lineleftbs",OBJ_TREND,0,Time[rec_shift],obj_prc1-(obj_prc2-obj_prc1),Time[0],obj_prc1-(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Lineleftbs",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftbs",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftbs",OBJPROP_RAY,false);
//ObjectSetInteger(ChartID(),last_select_object+"Lineleftb",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleftbs",OBJPROP_SELECTABLE,false);



}

if ( obj_prc1 > obj_prc2 ) {

order_type=OP_SELL;


if ( shift1 < shift2 ) {
int shift1s=shift1;
int shift2s=shift2;
shift1=shift2s;
shift2=shift1s;
}



Comment("Order Type:",order_type," SELL");


int rec_shift=shift2-(shift1-shift2);


double yuzde=(obj_prc1-obj_prc2)/100;
double price50=obj_prc1+(yuzde*50);
double price30=obj_prc1+(yuzde*30);
double price60=obj_prc1+(yuzde*60);

double yuzde3=(obj_prc1-obj_prc3)/100;
double price503=obj_prc1+(yuzde3*50);
double price303=obj_prc1+(yuzde3*30);
double price603=obj_prc1+(yuzde3*60);




if ( rec_shift < 0 ) rec_shift = 0;

ObjectDelete(ChartID(),last_select_object+"Line3");
ObjectCreate(ChartID(),last_select_object+"Line3",OBJ_TREND,0,Time[shift3],obj_prc3,Time[0],obj_prc3);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line3",OBJPROP_COLOR,clrBlack);

ObjectDelete(ChartID(),last_select_object+"Line50");
ObjectCreate(ChartID(),last_select_object+"Line50",OBJ_TREND,0,Time[shift2],price50,Time[rec_shift],price50);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line50",OBJPROP_COLOR,clrBlack);

ObjectDelete(ChartID(),last_select_object+"Line30");
ObjectCreate(ChartID(),last_select_object+"Line30",OBJ_TREND,0,Time[shift2],price30,Time[rec_shift],price30);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line30",OBJPROP_COLOR,clrNavy);

ObjectDelete(ChartID(),last_select_object+"Line60");
ObjectCreate(ChartID(),last_select_object+"Line60",OBJ_TREND,0,Time[shift2],price60,Time[rec_shift],price60);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line60",OBJPROP_COLOR,clrNavy);

int shiftt=shift2-(shift1-shift2)/2;
/*
ObjectDelete(ChartID(),last_select_object+"LineSmalls");
//ObjectCreate(ChartID(),last_select_object+"LineSmalls",OBJ_TREND,0,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1),Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectCreate(ChartID(),last_select_object+"LineSmalls",OBJ_TREND,0,obj_time1-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"LineSmalls",OBJPROP_WIDTH,1);
*/



ObjectDelete(ChartID(),last_select_object+"LineSmall");
ObjectCreate(ChartID(),last_select_object+"LineSmall",OBJ_TREND,0,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1),Time[0],obj_prc1-(obj_prc3-obj_prc1));
//ObjectCreate(ChartID(),last_select_object+"LineSmall",OBJ_TREND,0,obj_time1-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"LineSmall",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"Line503");
ObjectCreate(ChartID(),last_select_object+"Line503",OBJ_TREND,0,Time[shiftt],price503,Time[rec_shift],price503);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Line503",OBJPROP_WIDTH,2);

ObjectDelete(ChartID(),last_select_object+"Line303");
ObjectCreate(ChartID(),last_select_object+"Line303",OBJ_TREND,0,Time[shiftt],price303,Time[rec_shift],price303);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line303",OBJPROP_WIDTH,2);

ObjectDelete(ChartID(),last_select_object+"Line603");
ObjectCreate(ChartID(),last_select_object+"Line603",OBJ_TREND,0,Time[shiftt],price603,Time[rec_shift],price603);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line603",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"Line6303");
ObjectCreate(ChartID(),last_select_object+"Line6303",OBJ_TREND,0,Time[shiftt],price303,Time[shiftt],obj_prc1-(obj_prc3-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line6303",OBJPROP_WIDTH,2);


ObjectDelete(ChartID(),last_select_object+"DOWN");
ObjectDelete(ChartID(),last_select_object+"DOWN");
ObjectCreate(ChartID(),last_select_object+"DOWN",OBJ_RECTANGLE,0,Time[shift1],obj_prc1,Time[shift2],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),last_select_object+"DOWN",OBJPROP_BACK,false);

ObjectDelete(ChartID(),last_select_object+"UP");
ObjectCreate(ChartID(),last_select_object+"UP",OBJ_RECTANGLE,0,Time[shift2],obj_prc1,Time[rec_shift],obj_prc1+(obj_prc1-obj_prc2));
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),last_select_object+"UP",OBJPROP_BACK,false);

ObjectDelete(ChartID(),last_select_object+"Line");
ObjectCreate(ChartID(),last_select_object+"Line",OBJ_TREND,0,Time[shift1]-300*PeriodSeconds(),obj_prc1,Time[0],obj_prc1);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"Lines");
ObjectCreate(ChartID(),last_select_object+"Lines",OBJ_TREND,0,Time[shift2],obj_prc1+(obj_prc1-obj_prc2),Time[0],obj_prc1+(obj_prc1-obj_prc2));
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_STYLE,STYLE_DOT);
//ObjectSetInteger(ChartID(),last_select_object+"Line",OBJPROP_RAY,ray_lock);
ObjectSetInteger(ChartID(),last_select_object+"Lines",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"Lineleft");
ObjectCreate(ChartID(),last_select_object+"Lineleft",OBJ_TREND,0,Time[shift1],obj_prc1,Time[shift1],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineright");
ObjectCreate(ChartID(),last_select_object+"Lineright",OBJ_TREND,0,Time[shift2],obj_prc1,Time[shift2],obj_prc2);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Lineright",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineleft2");
ObjectCreate(ChartID(),last_select_object+"Lineleft2",OBJ_TREND,0,Time[shift2],obj_prc1,Time[shift2],obj_prc1+(obj_prc1-obj_prc2));
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Lineleft2",OBJPROP_SELECTABLE,false);

ObjectDelete(ChartID(),last_select_object+"Lineright2");
ObjectCreate(ChartID(),last_select_object+"Lineright2",OBJ_TREND,0,Time[rec_shift],obj_prc1,Time[rec_shift],obj_prc1+(obj_prc1-obj_prc2));
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Lineright2",OBJPROP_SELECTABLE,false);


}





}
  
}
