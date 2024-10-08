//+------------------------------------------------------------------+
//|                                                      fiboset.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//#property indicator_chart_window
bool Sistem=false;
bool SistemLine=false;
bool sistemtrend=false;
color button_Colorz = clrCornflowerBlue;
color button_Colorr = clrDarkSeaGreen;
color button_Colort = clrMediumOrchid;      
color button_Colors = clrIndianRed;
color button_Color = clrLightSlateGray;
int ObjTotal = ObjectsTotal();
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


//#define INDICATOR_NAME "5"

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



double TP1,TP2,TP3,TP4,TP5,TP6,TP7,ENTRY,STOP,SL1,SL2,SL3,SL4,ENTRY3,ENTRY35,ENTRY4,SL5,SL6,SL7,SL8,LOTS,LOTSELL,BALANCE;
double prcsl,prc618,prc100,prc1618,prc17070,prc17640,prc1309,prc20,prc225,prc25,prc275,prc30,prc35,prc3618,prc40,prc45,prc4236,prc4736,prc3236,prc50,prc5236,prc55,prc60,prc70,prc80;
string last_object="";
bool TradeAllow=true;
bool OBJECTHIDE = false;
int formasyon_alani_shift=0;
datetime TrendTime;
int TrendShift;
double minumum_pip = 1;

string Expansion_List[20];


        double fiboset_tepe;
        double fiboset_dip;

        double fiboset_price1;
        double fiboset_price2;
        string fiboset_name;
        


bool color_change=false;
bool color_ghost=false;

   color color_bg;
   color color_up;  
   color color_down;
   color color_bull;
   color color_bear;
   color color_line;        
        
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
/*int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }*/
  
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

   
   string USDTRYSYM="" ;
   
   

int renk_sayisi = 10;


double prices[30];
string pricen[30];

int magic=31;


int OnInit()
  {
  

   color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   color_line = ChartGetInteger(ChartID(),CHART_COLOR_CHART_LINE);

  
  
  //if ( Period() == PERIOD_M1 ) ChartSetInteger(ChartID(),CHART_SCALE,0,3);
  //if ( Period() == PERIOD_M1 ) ChartSetSymbolPeriod(ChartID(),NULL,PERIOD_M15);
  
  
  
  //Alert(OrderHistoryTotalProfits(""));
  
    //ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);
  //ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,0);
  
  string LabelChartR="Renk";
  //color Renkler[11];
  //Renkler[1]=
  
color Renkler[11]={clrWhite,clrSnow,clrOrange,clrGold,clrLawnGreen,clrYellow,clrCrimson,clrDodgerBlue,clrTurquoise,clrDarkViolet,clrBlack};

  
  
  for (int t=0;t<=renk_sayisi;t++) {

     long currChart=ChartID();
     LabelChartR="Renk"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, Renkler[t]);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 60+(t*25));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 5);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 20); 
     
     if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
  
  
   
   
      if ( USDTRYSYM == "" ) {   
      
      if ( iClose("USDTRY",PERIOD_H1,0) > 0 ) USDTRYSYM="USDTRY";
      
   if ( symbolfind("USDTRY") != "XXX" ) USDTRYSYM = symbolfind("USDTRY");
    //Alert("USDTRY="+USDTRYSYM,iClose("USDTRY",PERIOD_H1,0));
   Sleep(500);
   }
   
   
   
  
  long currChart=ChartID();
  string LabelChartP="LotSize";
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_MINLOT));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGreen);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 50);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 50); 
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);
     
     LabelChartP="LotSizeSell";
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_MINLOT));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrRed);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 70);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 50); 
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"SELL LOT");
     LOTSELL=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
     
     /*
     LOTS=MarketInfo(Symbol(),MODE_MINLOT);
     LOTSELL=MarketInfo(Symbol(),MODE_MINLOT);
     
     Alert(LOTS,"/",LOTSELL);*/
          

     LabelChartP="Balance";
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,"");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 90);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 50); 
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_MN1);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BALANCE");
     BALANCE=ObjectGetString(ChartID(),"Balance",OBJPROP_TEXT,0);
     
     
double Pips_Price_valued;     
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,MarketInfo(Symbol(),MODE_MINLOT));
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}     
     
     //Alert(LOTS);
  
  //LOTS=1;
  
  //int tickets = OrderSend(OrderSymbol(),OP_BUY,1,Ask,0,0,0,"Deneme",0,0,clrAliceBlue);
  
  
  EventSetTimer(1);
  ObjTotal = ObjectsTotal();

   //AllChart();     
  
  double onelot = MarketInfo(Symbol(),MODE_MARGINREQUIRED);
  
  Comment("Fibo:J/F Line:L Clear:Z/C OneLot:",onelot," TradeAllow:O,Pending Delete:P, GizleGöster:G, Şekil:Ş Formasyon İleri/Geri: Ü/Ğ, Stop Level: S , ArzTalepBox: e' / Min Pip:",minumum_pip);
  
//--- indicator buffers mapping
     //ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);
  //ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,0);
//---

if ( ChartID() != ChartFirst() ) {
ObjectDelete("HesapBilgisi");
ObjectDelete("HesapBilgisiKutu");
}



      string LabelChart="Bilgi";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgi");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 60); 
     
     
     LabelChart="Bilgis";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgis");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 90);  


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
/*int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }*/
//+------------------------------------------------------------------+
//| Timer function                                                   |



//+------------------------------------------------------------------+
int last_object_click=0;

void OnTimer()
  {
//---
     string LabelChart="SpreadBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 16);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 10); 
     } else {     
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     }
     
     
     


     LabelChart="HesapBilgisiKutu";
     if ( ObjectFind(ChartID(),LabelChart) == -1 && AccountProfit() != 0 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Balance:"+(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0)));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 2);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrLimeGreen);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BORDER_TYPE,BORDER_SUNKEN);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_STYLE,STYLE_SOLID);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 5);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30); 
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XSIZE, 530);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YSIZE, 25); 
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BACK, 1); 
     } else {  
     
     string hesapbilgisi="Kasa:"+DoubleToStr(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Kazanç:"+DoubleToStr(AccountProfit()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL";
        
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,hesapbilgisi);
     }
     

     LabelChart="HesapBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 && (AccountProfit() != 0 || ChartID() == ChartFirst()) ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Balance:"+(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0)));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 2);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, C'236,233,216');
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BORDER_TYPE,BORDER_SUNKEN);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_STYLE,STYLE_SOLID);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 25); 
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XSIZE, 150);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YSIZE, 20); 
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BACK, 1); 
     } else {  
     //"("+int(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL))+"%) 
     string hesapbilgisi="";
                       if (AccountMargin() > 0) { 
   if ( AccountEquity() != AccountMargin() ) {
     //hesapbilgisi="Kasa:"+DoubleToStr(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Varlık:"+DoubleToStr(AccountEquity()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Marjin:"+DoubleToStr(AccountMargin()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Kazanç:"+DoubleToStr(AccountProfit()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL Level:"+AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
     hesapbilgisi="Kasa:"+DoubleToStr(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Cüzdan:"+DoubleToStr(OrderHistoryTotalProfits("")*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Marjin:"+DoubleToStr(AccountMargin()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL"+" Kazanç:"+DoubleToStr(AccountProfit()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL Level:"+AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
      }   
      }else{

     hesapbilgisi="Kasa:"+DoubleToStr(AccountBalance()*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL / "+DoubleToStr(OrderHistoryTotalProfits("")*iClose(USDTRYSYM,PERIOD_H1,0),2)+ " TL";
      }
        
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,hesapbilgisi);
     }
          
     
          



     
     
   
   
    if ( ObjTotal!=ObjectsTotal(ChartID()) ) AlertObject();
 ObjTotal = ObjectsTotal(ChartID());


   if (!IsTesting()){
     //if (Orders>OrdersTotal()) AlertOrder();
     if (Orders!=OrdersTotal()) {
     AlertOrder();
     AlertOrders();
     Orders=OrdersTotal();
     }
   }; 
   
   
   ///////////////////////////////////////////////////////////////////////////////////////////
   // STOP LEVEL CALCULATION SYSTEM
   ///////////////////////////////////////////////////////////////////////////////////////////
   if ( stoplevelsystem ) {
   
   AlertOrder();
   
   LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);
   double as_double_buy = (double) ObjectGetString(0,"LotSize",OBJPROP_TEXT);   
   LOTSELL=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
   double as_double_sell = (double) ObjectGetString(0,"LotSizeSell",OBJPROP_TEXT);
   BALANCE=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
   double as_double_balance = (double) ObjectGetString(0,"Balance",OBJPROP_TEXT);   
   
   

   
   if(as_double_buy !=0 && MathIsValidNumber(as_double_buy) && as_double_sell !=0 && MathIsValidNumber(as_double_sell) ){
   StopLevelFinder(LOTS,LOTSELL);
   } else {
   
   
   if ( stoplevelsystem ) {
   LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);
   double as_double = (double) ObjectGetString(0,"LotSize",OBJPROP_TEXT);
   if(as_double !=0 && MathIsValidNumber(as_double)){
   StopLevelFinder(LOTS,0);
   }
   }
   
   if ( stoplevelsystem ) {
   LOTSELL=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
   double as_double = (double) ObjectGetString(0,"LotSizeSell",OBJPROP_TEXT);
   if(as_double !=0 && MathIsValidNumber(as_double)){
   StopLevelFinder(0,LOTSELL);
   }
   }
   }
   }
   //////////////////////////////////////////////////////////////////////////////////////   
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
int Orders = 0;
bool fiboset=true;
bool Chart_Forward = false;
 bool Chart_Rewind = false;
    int Chart_Pos = -1;
long currChart=ChartID();    
int scale=ChartGetInteger(0,CHART_SCALE);
int mouse_click = 0;
int mouse_line = 0;
bool HighLow = false;
bool TimeSet=false;
     
     
string Last_Expansion = "";
datetime angle_time1;
datetime angle_time2;
double angle_value;
bool sekil=true;
string obj_id ;
//secondparam="";

int Ekran_Last=1;

bool stoplevelsystem = false;
bool stoplevelsystemsell=false;
bool TRADE_LEVELS=true;

string rectangle_last_object="";
bool rectangle_forever=false;

color renk_sec=clrBlack;


////////////////////////////////////////////////////////////////////////////////////////////////////
// CASPER GHOST ORDER
////////////////////////////////////////////////////////////////////////////////////////////////////
bool casperlive_8=false;
bool casperlive_5=false;
bool caspercomplate_5=false;
bool caspercomplate_8=false;
int casper_ticket=-1;

int OrderHisTotal=OrdersHistoryTotal();
double margin=AccountMargin();
//int OrderTotal=OrdersTotal();

double casper_history_profit=0;

bool casper_auto_tp=true;


/////////////////////////////////////////////////////////////////////////////////  
double CasperHisOrder() {

//int casper_ticket=656127610;

double profits=0;

//////////////////////////////////////////////////////////////////

   for(int i=0; i<OrdersHistoryTotal(); i++) {
   if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true)
   {      

    if ( OrderSymbol() == Symbol() && ( StringFind(OrderComment(),casper_ticket,0) != -1 || OrderTicket()== casper_ticket ) //&& OrderMagicNumber() == magic 
    ) {      
    profits=profits+OrderProfit();  
    profits=profits+OrderCommission();    
    
    }
      
      
}  
}

return profits;

}
///////////////////////////////////////////////////////////////////////  
// PROFIT  
/////////////////////////////////////////////////////////////////////// 
double CasperTotalProfit(//int typ
)
{

double profits=0;



//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {

//OrderType() == typ && 
    if ( OrderSymbol() == Symbol() && ( StringFind(OrderComment(),casper_ticket,0) != -1 || OrderTicket()== casper_ticket ) //&& OrderMagicNumber() == magic 
    ) {      
    profits=profits+OrderProfit();
    profits=profits+OrderCommission();    
    //if ( OrderProfit() > 0 ) profits=profits+OrderProfit();
    //if ( OrderProfit() < 0 ) profits=profits-OrderProfit();
    
    
    }

  
              
   }
   
}

return profits;

}


/////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////
void CasperGrupCloseOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
      
    if ( OrderSymbol() == Symbol() && ( StringFind(OrderComment(),casper_ticket,0) != -1 || OrderTicket()== casper_ticket ) //&& OrderMagicNumber() == magic 
    ) { 
         
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, clrNONE);                    
            
         }
      }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////////////////////////////////////
void CasperCloseOrders(string cmt)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1 &&  OrderSymbol() == Symbol() //&& OrderMagicNumber() == magicbuy
         )
         {
         
         if ( OrderType() == OP_BUY && OrderTakeProfit() != 0 && Ask >= OrderTakeProfit() ) {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);         
         }
         
         if ( OrderType() == OP_SELL && OrderTakeProfit() != 0 && Bid <= OrderTakeProfit() ) {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);         
         }
            
            
            
         }
      }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////


void CasperLive() {


if ( OrdersTotal() > 0 ) {CasperCloseOrders("Casper");

if ( casper_ticket != -1 ) {
double casper_profit=CasperTotalProfit();

     string  LabelChart="Bilgi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Profit:"+casper_profit+"$");    
     
     double casper_total_profit=casper_profit+casper_history_profit;

     LabelChart="Bilgis";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"History Profit:"+casper_history_profit+"$ +"+casper_profit+"$ ="+casper_total_profit+"$");     
     if ( casper_total_profit >= 0 ) ObjectSetInteger(ChartID(),LabelChart,OBJPROP_COLOR,clrLimeGreen);
     if ( casper_total_profit < 0 ) ObjectSetInteger(ChartID(),LabelChart,OBJPROP_COLOR,clrCrimson);
}



}

if ( prices[0] == 0 ) return;

//Print("CasperLive5:",casperlive_5,"CasperLive8:",casperlive_8);

if ( caspercomplate_5 == true || caspercomplate_8 == true ) return;

////////////////////////////////////////////////////////////////////
int casper_total=OrderCommetssType("Casper",Symbol(),-1);
if ( casper_total > 0 )return;
//////////////////////////////////////////////////////////////////////



/*
for (int p=0;p<=25;p++) {
Print(p,"/",pricen[p],"/",prices[p]);
}*/


/// Down Up
if ( prices[0] < prices[1] ) {
//Print("CasperLive:Downup");

   double cprice_5=NormalizeDouble(prices[19],Digits);
   double cprice_5236=NormalizeDouble(prices[20],Digits);
   double cprice_8=NormalizeDouble(prices[24],Digits);
   double cprice_tp8=NormalizeDouble(prices[24],Digits);
   double cprice_tp11=NormalizeDouble(prices[25],Digits);
   

if ( casperlive_5 == true && Bid >= cprice_5 && caspercomplate_5 == false) { 
   for (int c=1;c<=3;c++) {
   if ( c==1 ) {
   int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,0,"CasperSell",magic,0,clrNONE);
   casper_ticket=ticket_sell;
   }
   string cmt="CasperSell"+casper_ticket;
   //string cmt="CasperSell"+ticket_sell;
   if ( c > 1 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   //cmt="CasperBuy"+cprice_tp8;
   if ( c==1 ) int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==2 ) int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   
   //cmt="CasperBuy"+cprice_tp11;
   if ( c==3 ) int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
      
      caspercomplate_5=true;
      
}
      
      
if ( casperlive_8 == true && Bid >= cprice_8 && caspercomplate_8 == false ) {
   for (int c=1;c<=1;c++) {
   int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,0,"CasperSell",magic,0,clrNONE);   
   casper_ticket=ticket_sell;
   string cmt="CasperSell"+ticket_sell;
   
   //cmt="CasperBuy"+cprice_tp11;
   if ( c==1 ) int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,cprice_tp11,cmt,magic,0,clrNONE);
   //if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   //if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
      
      caspercomplate_8=true;
}




  
   

}


if ( prices[0] > prices[1] ) {
//Print("CasperLive:UpDown");


   double cprice_5=NormalizeDouble(prices[19],Digits);
   double cprice_8=NormalizeDouble(prices[24],Digits);
   double cprice_tp8=NormalizeDouble(prices[24],Digits);
   double cprice_tp11=NormalizeDouble(prices[25],Digits);
   
if ( casperlive_5 == true && Bid <= cprice_5 && caspercomplate_5 == false) { 
   for (int c=1;c<=3;c++) {
   if ( c==1 ) {
   int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,cprice_5,0,0,0,"CasperBuy",magic,0,clrNONE);
   casper_ticket=ticket_buy;
   }
   //string cmt="CasperSell"+ticket_buy;
   string cmt="CasperSell"+casper_ticket;
   if ( c > 1 )int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,cprice_5,0,0,0,cmt,magic,0,clrNONE);
   /*if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp11,cmt,magic,0,clrNONE);*/
   
   //cmt="CasperSell"+cprice_tp8;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   
   //cmt="CasperSell"+cprice_tp11;
   if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp11,cmt,magic,0,clrNONE);   

   
      }
      
      caspercomplate_5=true;
}
      
      

if ( casperlive_8 == true && Bid <= cprice_8 && caspercomplate_8 == false ) { 
   for (int c=1;c<=1;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);   
   casper_ticket=ticket_buy;
   string cmt="CasperSell"+ticket_buy;
   //string cmt="CasperSell"+cprice_tp11;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,cprice_tp11,cmt,magic,0,clrNONE);
   //if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   //if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
      
      caspercomplate_8=true;
}
    

}



}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CasperLive();
   
   if ( casper_auto_tp == true ) CasperSetTP(true);
   
   //casper_history_profit=CasperHisOrder();
   //Comment("casper_history_profit:",casper_history_profit);

if ( OrdersHistoryTotal() != OrderHisTotal ) {
casper_history_profit=CasperHisOrder();
OrderHisTotal=OrdersHistoryTotal();
}

if ( margin != AccountMargin() ) {
casper_history_profit=CasperHisOrder();
OrderHisTotal=OrdersHistoryTotal();
margin=AccountMargin();
}





   
   
  }
       
       

/////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////
void CasperSetTP(bool tp11_check)
{

if ( casper_ticket == -1 ) return;
if ( caspercomplate_8 != true ) return;

   double cprice_tp8=NormalizeDouble(prices[24],Digits);
   double cprice_tp11=NormalizeDouble(prices[25],Digits);
   
/////////////////////////////////////////////////////////////////////////////   
bool tp_target=false;
   
/////////////////////////////////////////////////////////////////////////////   
if ( prices[0] > prices[1] ) {
if ( (Bid <= cprice_tp11 && tp11_check == true) || tp11_check == false ) {
tp_target=true;
}
}   
   
   
if ( prices[0] < prices[1] ) {
if ( (Ask >= cprice_tp11 && tp11_check == true) || tp11_check == false ) {
tp_target=true;
}
}
////////////////////////////////////////////////////////////////////////////   
   
if (tp_target==false) return;
////////////////////////////////////////////////////////////////////////////



   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
      
    if ( OrderSymbol() == Symbol() && ( StringFind(OrderComment(),casper_ticket,0) != -1 || OrderTicket()== casper_ticket ) //&& OrderMagicNumber() == magic 
    ) { 
    

// Up Down    
if ( prices[0] > prices[1] ) {
//Print("CasperLive:UpDown");
if ( (Bid <= cprice_tp11 && tp11_check == true) || tp11_check == false ) {
if ( OrderType() == OP_BUY && OrderTakeProfit() == 0 ) {
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),cprice_tp8,0,clrNONE);
}
}
}

/// Down Up
if ( prices[0] < prices[1] ) {
//Print("CasperLive:Downup");
if ( (Ask >= cprice_tp11 && tp11_check == true) || tp11_check == false ) {
if ( OrderType() == OP_SELL && OrderTakeProfit() == 0 ) {
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),cprice_tp8,0,clrNONE);
}
}
}


    
    //OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+1000*Point,0,clrNONE);
  
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, clrNONE);                    
            
         }
      }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////


       
     
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  //Print("Sparam",sparam);
  
  
  if ( sparam == 53 ) {
  
     int cevap=MessageBox("Casper Auto Tp Control Mode","Auto Tp Mode Change",4); 
if ( cevap == 6 ) {  
if ( casper_auto_tp == true ) { casper_auto_tp=false;} else {casper_auto_tp=true;}
Comment("casper_auto_tp:",casper_auto_tp);
}

  
     int cevapo=MessageBox("Casper Set TP","TakeProfit 8 Set",4); 
   if ( cevapo == 6 ) {
   CasperSetTP(false);
   }
   
   
   

//if ( casper_auto_tp == true ) {
//if ( casper_ticket != -1 ) {
//if ( caspercomplate_8 == true ) {
//CasperSetTP(false);
//}
//}
//}
 
  }
  

  
   if ( sparam == 34 ) {
   
///////////////////////////////////////////////////////////////////////////////   
   int cevapo=MessageBox("Casper Live Order","Casper Live Order",4); 
   if ( cevapo == 6 ) {
   //for (int c=1;c<=3;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_BUY,LOTS,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(Symbol(),OP_SELL,LOTSELL,Bid,0,0,0,cmt,magic,0,clrNONE);
      //}
      }      
//////////////////////////////////////////////////////////////////////////////
   
   if ( prices[0] != 0 ) {
   
   casperlive_5=false;
   casperlive_8=false;
   
        int cevap=MessageBox("Casper Live 8 ","Casper Live 8",4); 
     if ( cevap == 6 ) {
     casperlive_8=true;
     casper_ticket=-1;
     }
     
        int cevaps=MessageBox("Casper Live 5 ","Casper Live 5",4); 
     if ( cevaps == 6 ) {
     casperlive_5=true;
     casper_ticket=-1;
     }
          
     
     }
     
   
   

   }
   
   

//////////////////////////////////////////////////////////////////   
int indexoff=StringFind(sparam,"OrderClose",0);

if ( indexoff != -1 ) {


string obj_tool=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP,0);

if ( StringFind(obj_tool,"CasperSell",0) != -1 ) {
//Alert(obj_tool);
CasperClose(obj_tool);
return;
}


string bilgi=sparam;

int rplc=StringReplace(bilgi,"OrderClose","");

int bilgint=StringToInteger(bilgi);

if(OrderSelect(bilgint, SELECT_BY_TICKET)==true)
    {
    if ( OrderType() > 1 ) {LiveOrderClose(bilgint);
    return;
    }
    }

     int cevap=MessageBox("İşlem Kapatmak",bilgint,4); 
     if ( cevap == 6 ) {
LiveOrderClose(bilgint);
}

//"OrderClose"+OrderTicket(); 

}   
///////////////////////////////////////////////////////////////

   
   

 if ( sparam == "LotSizeSell" ) {
    LOTSELL=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
   double as_double = (double) ObjectGetString(0,"LotSizeSell",OBJPROP_TEXT);
   if(as_double !=0 && MathIsValidNumber(as_double)){
   //StopLevelFinder(0,LOTSELL);
   }
}   

if ( sparam == "LotSize" ) {
   LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);
   double as_double = (double) ObjectGetString(0,"LotSize",OBJPROP_TEXT);
   if(as_double !=0 && MathIsValidNumber(as_double)){
   //StopLevelFinder(LOTS,0);
   }
}   
   
     
  
  //Print(sparam);
  
  if ( sparam == 25 ) {
  CloseAllPenOrders(Symbol());
  }


  if ( sparam == 46 ) {
  
  CasperGrupCloseOrders();
  
 
  //if ( color_change == true ) {
  if ( ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP) == clrBlack ) {
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
  
    
  
  if ( sparam == 45 ) {
  
  
  //ObjectsDeleteAll(ChartID(),-1,-1);
  
  ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
  ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
  ObjectsDeleteAll(ChartID(),-1,OBJ_HLINE);
  ObjectsDeleteAll(ChartID(),-1,OBJ_TEXT);
  ObjectsDeleteAll(ChartID(),-1,OBJ_ARROW);
  
  
  }
  
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(currChart,sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(ObjectGetDouble(currChart,sparam,OBJPROP_PRICE),MarketInfo(Symbol(),MODE_DIGITS));
          CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment("Fiyat Hafızası:",HLinePrice);
          }
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
/*
   //////////////////////////////////////////////////////////////////////////////////////////////       
   if(id==CHARTEVENT_MOUSE_MOVE){
      //Comment("POINT: ",(int)lparam,",",(int)dparam,"\n",MouseState((uint)sparam));
      
      if ( ((uint)sparam& 1)== 1 ) {Alert("MouseLeft");
      
      //long value;
      //if ( ChartGetInteger(currChart,CHART_AUTOSCROLL,0,value) ) {ChartSetInteger(currChart,CHART_AUTOSCROLL,0,false);}
      
      }
      //if ( ((uint)sparam& 2)== 2 ) {Alert("MouseRight");}
      
      
      //return;          
      }
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    */    
        
  int indexoffe = StringFind(sparam," FE", 0);                   
  
  if ( indexoffe != -1 && ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_TREND ) {
  
  double feprice = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  string festr = ObjectGetString(ChartID(),sparam+" Text",OBJPROP_TEXT);
  
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(currChart,sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(feprice,MarketInfo(Symbol(),MODE_DIGITS));
          CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment(festr," Fiyat Hafızası:",HLinePrice);
          //}
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              
  
  //Alert(sparam);
  
  }
  
  
  //Print(sparam);
  
  int indexofrenk = StringFind(sparam,"Renk", 0); 
  if ( indexofrenk != -1 ) {  
  renk_sec=ObjectGetInteger(ChartID(),sparam,OBJPROP_BGCOLOR);  
  //Alert("Renk",renk_sec);  
  //ObjectDelete("xxx");
  //ObjectCreate(ChartID(),"xxx",OBJ_RECTANGLE,0,Time[0],Ask,Time[1],Bid);
  ///ObjectSetInteger(ChartID(),"xxx",OBJPROP_COLOR,renk_sec);
  for (int t=1;t<=renk_sayisi;t++) {
  ObjectSetInteger(ChartID(),"Renk"+t,OBJPROP_STATE,false);
  }
  ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,true);
  //renk_sec=clrWhite;
  }
  
  if ( sparam == "Renk0" ) {
  
  //Alert("Selam2");
  
  
         int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     int indexofrenk = StringFind(name,"Renk", 0); 
     
     if ( name != "Renk0" && indexofrenk != -1 ) {
     
     //Alert(name);
     string renkboxname=ObjectName(i);
     // 764 scalpte olduğu için bunu iptal ettik renkiptal
     //if ( fiboset) {}
     /*if ( ObjectGetInteger(ChartID(),name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(ChartID(),name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {     
     ObjectSetInteger(ChartID(),name, OBJPROP_TIMEFRAMES, -1);
     }*/
     
     
     }
     
     }
     
  
  }
  
  
  //////////////////////////////////////////////////////////////
  
  if ( sparam == 19 ) { // r
  if ( TRADE_LEVELS ) { TRADE_LEVELS=false; 
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
  } else { TRADE_LEVELS=true;
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,true);
  }
  
  Comment("TRADE_LEVELS:",TRADE_LEVELS);
  }    
    
  
  
  if ( sparam == 22 ) { // U
  
  //keybd_event(VK_MENU, 0xb8, 0, 0); //Alt Press 
//keybd_event(VK_1, 0x8f, 0, 0); // Tab Press 
//keybd_event(VK_1, 0x8f, KEYEVENTF_KEYUP, 0); // Tab Release 
//keybd_event(VK_MENU, 0xb8, KEYEVENTF_KEYUP, 0); // Alt Release
  
    keybd_event(VK_CONTROL, 0, 0, 0);                                      // Ctrl/alt key down
    keybd_event(VK_F6, 0, 0, 0);                                          // key down
    Sleep(2000);
    keybd_event(VK_F6, 0, KEYEVENTF_KEYUP, 0);            // key up
    keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);        // ctrl/alt key up
      
  
  }
  
  //Print(sparam);
  
  
  //EventSetMillisecondTimer()
  
  //Print(Symbol()+" "+ChartGetInteger(ChartID(),CHART_BRING_TO_TOP));
  
  ////////////////////////////////////////////////////////////////////
  if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 0 ) {
    EventKillTimer();
    Print(Symbol()+": Timer Kapandı");
    Ekran_Last=0;
  } else {
    if ( Ekran_Last != 1 ) {
    EventSetTimer(1);
    Print(Symbol()+": Timer Açıldı");    
    Ekran_Last=1;
    }
  }
  ///////////////////////////////////////////////////////////////////
  
  
  
  if ( sparam == 27 ) formasyon_alani_shift = formasyon_alani_shift+1; // ü
  if ( sparam == 26 && formasyon_alani_shift > 0 ) formasyon_alani_shift = formasyon_alani_shift-1; // ğ
  if ( sparam == 26 || sparam == 27 ) {
  Comment("Genişleme:",formasyon_alani_shift);
  //obj_id = last_object;
        obj_id = last_object;
       //int replaced=StringReplace(obj_id," Genislik","");
  OzhFormasyon(obj_id);
  }
  
  int indexofgenislik = StringFind(sparam,"Genislik", 0);
  if ( indexofgenislik != -1  ) {
  
        datetime time1 = ObjectGetInteger(currChart,sparam,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,sparam,OBJPROP_TIME2,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        formasyon_alani_shift=MathAbs(shift1-shift2);
  Comment("Genişleme:",formasyon_alani_shift);
          obj_id = sparam;
       int replaced=StringReplace(obj_id," Genislik","");
       OzhFormasyon(obj_id);
       
  }
  
  
  //Print("sparam",sparam,"formasyon_alani_shift",formasyon_alani_shift);
  
  if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRENDBYANGLE ) {
     double angle_value=ObjectGetDouble(0,sparam,OBJPROP_ANGLE);
    
     
   if(angle_value!=0)
     {
     datetime angle_time1=ObjectGetInteger(0,sparam,OBJPROP_TIME,0);
     datetime angle_time2=ObjectGetInteger(0,sparam,OBJPROP_TIME,1);
     string angle_time2s=TimeToStr(angle_time2,TIME_DATE|TIME_MINUTES);
      Comment(angle_time2s);
      //Alert(TimeToStr(angle_time2,TIME_DATE|TIME_SECONDS));
     }
     }
  

/////////////////////////////////////////  
// Circle 
////////////////////////////////////////
if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ELLIPSE ){


   double Height;
   int Width;
   double Scale;
  /* switch(Period())
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
     }*/


//ObjectSetDouble(ChartID(),sparam,OBJPROP_SCALE,0.048);



ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,false);
//ObjectSetDouble(ChartID(),sparam,OBJPROP_SCALE,true); 
ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2));


if ( ObjectFind(sparam+"Line") == -1 ) {

Scale=0.008;
if ( Period() == PERIOD_H1 ) Scale=0.008;
if ( Period() == PERIOD_M5 ) Scale=0.006;
ObjectSetDouble(ChartID(),sparam,OBJPROP_SCALE,Scale);
//ObjectSetDouble(ChartID(),sparam,OBJPROP_SCALE,0.0314);

ObjectCreate(ChartID(),sparam+"Line",OBJ_TRENDBYANGLE,0,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1),ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2));
ObjectSetInteger(ChartID(),sparam+"Line",OBJPROP_RAY_RIGHT,false);
}

if ( ObjectFind(sparam+"LinePriceHigh") == -1 ) {
ObjectCreate(ChartID(),sparam+"LinePriceHigh",OBJ_TRENDBYANGLE,0,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1),ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+100*PeriodSeconds(),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1));
ObjectSetInteger(ChartID(),sparam+"LinePriceHigh",OBJPROP_RAY_RIGHT,false);
ObjectSetInteger(ChartID(),sparam+"LinePriceHigh",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"LinePriceHigh",OBJPROP_COLOR,clrMaroon);
}

if ( ObjectFind(sparam+"LinePriceLow") == -1 ) {
ObjectCreate(ChartID(),sparam+"LinePriceLow",OBJ_TRENDBYANGLE,0,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2),ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+100*PeriodSeconds(),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2));
ObjectSetInteger(ChartID(),sparam+"LinePriceLow",OBJPROP_RAY_RIGHT,false);
ObjectSetInteger(ChartID(),sparam+"LinePriceLow",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"LinePriceLow",OBJPROP_COLOR,clrDarkBlue);
}




}








if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TRENDBYANGLE ){
string obj_id = sparam;
int replaced=StringReplace(obj_id,"LinePriceHigh","");
    replaced+=StringReplace(obj_id,"LinePriceLow","");
    replaced+=StringReplace(obj_id,"Line","");
    
    int indexofline = StringFind(sparam,"Line", 0);
    int indexoflineprice = StringFind(sparam,"LinePrice", 0);

double sparam_price1;
double sparam_price2;
int shift1;
int shift2;
  
if(ObjectGetInteger(ChartID(),obj_id,OBJPROP_TYPE) == OBJ_ELLIPSE && indexofline != -1 && indexoflineprice == -1 ){

long height = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
long width = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);

ObjectSetDouble(ChartID(),obj_id,OBJPROP_SCALE,height/width);


        datetime time1 = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
        datetime time2 = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
        
        //sparam_price1 = ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1);
        //sparam_price2 = ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2);

        sparam_price1 = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
        sparam_price2 = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);  
        
        
        shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        
        double price1;
        double price2;

if ( sparam_price1 > sparam_price2 ) {// Alttan Yukar 2 büyük 1 küçük        

        price1=High[shift1];
        price2=Low[shift2];
        
        
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,price1);
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,price2); 


ObjectSetInteger(ChartID(),obj_id,OBJPROP_SELECTED,true);
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME1,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME2,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1));

ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE1,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1));
ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE2,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1)-(2*3.14*(MathAbs(ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1)-ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2)))/2));


Sleep(500);

ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_TIME1,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_TIME2,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1)+300*PeriodSeconds());

ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_TIME1,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_TIME2,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1)+300*PeriodSeconds());

ObjectSetDouble(ChartID(),obj_id+"LinePriceHigh",OBJPROP_PRICE1,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1));
ObjectSetDouble(ChartID(),obj_id+"LinePriceHigh",OBJPROP_PRICE2,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1));

ObjectSetDouble(ChartID(),obj_id+"LinePriceLow",OBJPROP_PRICE1,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2));
ObjectSetDouble(ChartID(),obj_id+"LinePriceLow",OBJPROP_PRICE2,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2));

ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_RAY,true);

ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_SELECTED,false);

}



if ( sparam_price2 > sparam_price1 ) {// Alttan Yukar 2 büyük 1 küçük        
        

        
        if ( shift1 != shift2 ) {
       if ( Close[shift1] > Open[shift1] ) price1=High[shift1];
        if ( Open[shift1] > Close[shift1]  ) price1=Low[shift1];

        if ( Close[shift2] > Open[shift2] ) price2=High[shift2];
        if ( Open[shift2] > Close[shift2]  ) price2=Low[shift2];
        
        
        price1=Low[shift1];
        price2=High[shift2];
        
        
        
       // if ( shift1 > shift2 ) {
        /*if ( sparam_price2 > sparam_price1 ) {
        price2=High[shift2];
        price1=Low[shift1];
        }

        if ( sparam_price1 > sparam_price2 ) {
        price2=Low[shift2];
        price1=High[shift1];
        }*/

        //ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,price1);
        //ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,price2);                
                
        //}
        
       /* if ( shift1 < shift2 ) {
        if ( sparam_price2 > sparam_price1 ) {
        price2=Low[shift2];
        price1=High[shift1];
        }

        if ( sparam_price1 > sparam_price2 ) {
        price2=High[shift2];
        price1=Low[shift1];
        }
        
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,price2);
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,price1);
                
        }      */  

        //ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,price2);
        //ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,price1);
                
        
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,price1);
        ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,price2);        

        }

//if ( shift1 > shift2 ) {
ObjectSetInteger(ChartID(),obj_id,OBJPROP_SELECTED,true);
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME1,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME2,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1));

ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE1,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1));
ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE2,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1)+(2*3.14*(MathAbs(ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1)-ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2)))/2));

/*} else {
ObjectSetInteger(ChartID(),obj_id,OBJPROP_SELECTED,true);
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME1,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2));
ObjectSetInteger(ChartID(),obj_id,OBJPROP_TIME2,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2));

ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE1,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2));
ObjectSetDouble(ChartID(),obj_id,OBJPROP_PRICE2,ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2)-(2*3.14*(MathAbs(ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1)-ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2)))/2));
}*/


        /*datetime obj_time1 = ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1);
        datetime obj_time2 = ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME2);

        double obj_price1 = ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1);
        double obj_price2 = ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2);*/
Sleep(500);

ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_TIME1,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_TIME2,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1)+300*PeriodSeconds());

ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_TIME1,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1));
ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_TIME2,ObjectGetInteger(ChartID(),obj_id,OBJPROP_TIME1)+300*PeriodSeconds());

ObjectSetDouble(ChartID(),obj_id+"LinePriceHigh",OBJPROP_PRICE1,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1));
ObjectSetDouble(ChartID(),obj_id+"LinePriceHigh",OBJPROP_PRICE2,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE1));

ObjectSetDouble(ChartID(),obj_id+"LinePriceLow",OBJPROP_PRICE1,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2));
ObjectSetDouble(ChartID(),obj_id+"LinePriceLow",OBJPROP_PRICE2,ObjectGetDouble(ChartID(),obj_id,OBJPROP_PRICE2));


//ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_SELECTED,true);
//ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_SELECTED,true);
ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),obj_id+"LinePriceLow",OBJPROP_RAY,true);


/*
//if ( ObjectFind(sparam+"LinePriceHigh") == -1 ) {
ObjectDelete(ChartID(),obj_id+"LinePriceHigh");
ObjectCreate(ChartID(),obj_id+"LinePriceHigh",OBJ_TRENDBYANGLE,0,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1),ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+100*PeriodSeconds(),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1));
ObjectSetInteger(ChartID(),obj_id+"LinePriceHigh",OBJPROP_RAY_RIGHT,false);
//}

//if ( ObjectFind(sparam+"LinePriceLow") == -1 ) {
ObjectCreate(ChartID(),sparam+"LinePriceLow",OBJ_TRENDBYANGLE,0,ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2),ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+100*PeriodSeconds(),ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2));
ObjectSetInteger(ChartID(),sparam+"LinePriceLow",OBJPROP_RAY_RIGHT,false);
//}
*/

}





} else {
if(ObjectGetInteger(ChartID(),obj_id,OBJPROP_TYPE) != OBJ_ELLIPSE ) {
ObjectDelete(sparam);
ObjectDelete(sparam+"PriceHigh");
ObjectDelete(sparam+"PriceLow");
}
}


}
///////////////////////////////////////////////////////////////////////////////////

  
  
  
  if((ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_FIBO) && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
last_object=sparam;
Comment("Seçilen Obje:",sparam);
  }

  if((ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
  rectangle_last_object=sparam;
  Comment("Seçilen Obje Dikdörtgen:",rectangle_last_object);
  }  

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  if((ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) && rectangle_forever ) {
  
  //ObjectSetInteger(0,sparam,OBJPROP_SELECTED,0);
  //ObjectSetInteger(0,sparam,OBJPROP_SELECTABLE,0);
  
  
rectangle_last_object=sparam;
last_object=sparam;
datetime arztalep_baslangic = ObjectGetInteger(0,sparam,OBJPROP_TIME1);
int arztalep_shift=iBarShift(NULL,PERIOD_CURRENT,arztalep_baslangic);

double arztalep_fiyat1=ObjectGetDouble(0,sparam,OBJPROP_PRICE1);
double arztalep_fiyat2=ObjectGetDouble(0,sparam,OBJPROP_PRICE2);

double arztalep_tepe,arztalep_dip;
bool arztalep_buy=false;
bool arztalep_sell=false;

if ( arztalep_fiyat1 > arztalep_fiyat2 ) {arztalep_tepe = arztalep_fiyat1;arztalep_dip = arztalep_fiyat2;arztalep_buy=true;arztalep_sell=false;}
if ( arztalep_fiyat2 > arztalep_fiyat1 ) {arztalep_tepe = arztalep_fiyat2;arztalep_dip = arztalep_fiyat1;arztalep_sell=true;arztalep_buy=false;}

if ( arztalep_fiyat1 > arztalep_fiyat2 ) { ObjectSetInteger(0,sparam,OBJPROP_COLOR,clrLimeGreen);}
if ( arztalep_fiyat2 > arztalep_fiyat1 ) { ObjectSetInteger(0,sparam,OBJPROP_COLOR,clrDarkRed);}


string xxx="";
if ( xxx=="yyy" ) {
if ( ObjectFind(sparam+"LineTepe") == -1 ) {
ObjectDelete(sparam+"LineTepe");
ObjectCreate(0,sparam+"LineTepe",OBJ_TREND,0,arztalep_baslangic-1*PeriodSeconds(),arztalep_fiyat1,arztalep_baslangic-1*PeriodSeconds(),arztalep_fiyat2);
//ObjectCreate(0,sparam+"LineTepe",OBJ_HLINE,0,arztalep_baslangic,arztalep_tepe);
ObjectSetInteger(0,sparam+"LineTepe",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(0,sparam+"LineTepe",OBJPROP_RAY,0);


} else {
double arztalep_linefiyat1=ObjectGetDouble(0,sparam+"LineTepe",OBJPROP_PRICE1);
double arztalep_linefiyat2=ObjectGetDouble(0,sparam+"LineTepe",OBJPROP_PRICE2);
int arztalep_linetime1=ObjectGetInteger(0,sparam+"LineTepe",OBJPROP_TIME1);

ObjectSetInteger(0,sparam,OBJPROP_TIME1,arztalep_linetime1+1*PeriodSeconds());
ObjectSetDouble(0,sparam,OBJPROP_PRICE1,arztalep_linefiyat1);
ObjectSetDouble(0,sparam,OBJPROP_PRICE2,arztalep_linefiyat2);


//Alert(arztalep_linefiyat1);
/*if ( arztalep_linefiyat1 != arztalep_fiyat1 && arztalep_buy ) {
ObjectSetDouble(0,sparam,OBJPROP_PRICE1,arztalep_linefiyat1);
ObjectSetDouble(0,sparam,OBJPROP_PRICE2,arztalep_linefiyat2);
}

if ( arztalep_linefiyat1 != arztalep_fiyat1 && arztalep_sell ) {
ObjectSetDouble(0,sparam,OBJPROP_PRICE1,arztalep_linefiyat2);
ObjectSetDouble(0,sparam,OBJPROP_PRICE2,arztalep_linefiyat1);
}*/



}
}

/*
if ( ObjectFind(sparam+"LineTepe") == -1 ) {
ObjectDelete(sparam+"LineTepe");
ObjectCreate(0,sparam+"LineTepe",OBJ_HLINE,0,arztalep_baslangic,arztalep_tepe);
ObjectSetInteger(0,sparam+"LineTepe",OBJPROP_COLOR,clrBlack);
//ObjectCreate(0,sparam+"LineTepe",OBJ_TREND,0,arztalep_baslangic,arztalep_tepe,TimeCurrent()+1000*PeriodSeconds(),arztalep_tepe);
} else {
double arztalep_linefiyat=ObjectGet(sparam+"LineTepe",OBJPROP_PRICE1);
//Alert(arztalep_linefiyat);
if ( arztalep_linefiyat != arztalep_tepe && arztalep_buy ) {
ObjectSetDouble(0,sparam,OBJPROP_PRICE1,arztalep_linefiyat);
ObjectSetDouble(0,sparam,OBJPROP_PRICE2,arztalep_linefiyat-(arztalep_tepe-arztalep_dip));
}

if ( arztalep_linefiyat != arztalep_tepe && arztalep_sell ) {
ObjectSetDouble(0,sparam,OBJPROP_PRICE2,arztalep_linefiyat);
ObjectSetDouble(0,sparam,OBJPROP_PRICE1,arztalep_linefiyat-(arztalep_tepe-arztalep_dip));
}



}
*/



if ( ObjectFind(sparam+"Line") == -1 ) {
ObjectDelete(sparam+"Line");
ObjectCreate(0,sparam+"Line",OBJ_VLINE,0,arztalep_baslangic+10*PeriodSeconds(),Ask);
}

datetime arztalep_fark = ObjectGetInteger(0,sparam+"Line",OBJPROP_TIME1);
int arztalep_fark_shift=iBarShift(NULL,PERIOD_CURRENT,arztalep_fark);


if ( ObjectFind(sparam+"Text") == -1 ) {
ObjectDelete(sparam+"Text");
ObjectCreate(0,sparam+"Text",OBJ_TEXT,0,arztalep_baslangic,arztalep_tepe);
ObjectSetInteger(0,sparam+"Text",OBJPROP_SELECTED,0);
ObjectSetInteger(0,sparam+"Text",OBJPROP_SELECTABLE,0);
}

ObjectSetInteger(0,sparam+"Text",OBJPROP_COLOR,clrWhite);
///int arztalep_linetime1=ObjectGetInteger(0,sparam+"LineTepe",OBJPROP_TIME1);
///int arztalep_linetime1=ObjectGetInteger(0,sparam+"Line",OBJPROP_TIME1);
int arztalep_linetime1=ObjectGetInteger(0,sparam,OBJPROP_TIME1);
ObjectSetInteger(0,sparam+"Text",OBJPROP_TIME,arztalep_linetime1+1*PeriodSeconds());
ObjectSetDouble(0,sparam+"Text",OBJPROP_PRICE,arztalep_tepe);


Comment("Seçilen Obje Rectangle:",sparam,"/",arztalep_baslangic,"/",arztalep_shift,"/",(arztalep_shift-arztalep_fark_shift));

int arztalep_say=0;

for (int t=arztalep_shift-(arztalep_shift-arztalep_fark_shift);t>=0;t--){
//Print(t);

if ( High[t] >= arztalep_dip && arztalep_buy ) {ObjectSetInteger(0,sparam,OBJPROP_COLOR,clrDarkGreen);
arztalep_say=arztalep_say+1;
}

if ( Low[t] <= arztalep_tepe && arztalep_sell ) {ObjectSetInteger(0,sparam,OBJPROP_COLOR,clrCrimson);
arztalep_say=arztalep_say+1;
}



}

ObjectSetString(0,sparam+"Text",OBJPROP_TEXT,arztalep_say);



if ( rectangle_forever ) {
//ObjectSet(sparam, OBJPROP_TIME2, TimeCurrent()+1000*PeriodSeconds());


if ( (ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2) - ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1))/PeriodSeconds() > 100 ) {
  
  
  ObjectSet(sparam, OBJPROP_TIME2, ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+100*PeriodSeconds());
  
  
  } else {
  if ( last_object_click == 4 ) {  
  ObjectSet(sparam, OBJPROP_TIME2, ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1)+1000*PeriodSeconds());
  last_object_click=0;
  }
  
  
  
  }
  
  last_object_click=last_object_click+1;
  if ( last_object_click > 4 ) last_object_click=0;


}

  }
  
   
  if ( sparam == 41 ) { // "
     
  if ( rectangle_forever ) {
  rectangle_forever=false;
  //fiboset=true;
  Comment("Rectangle e':",rectangle_forever);
  }else {
  rectangle_forever=true;
  //fiboset=false;
  Comment("Rectangle e':",rectangle_forever);
  }

  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////      
  
  
  
  if ( sparam == 34 ) { // O
       //if(sparam=="ButtonSHOWHIDE"){
     
     if ( OBJECTHIDE == true ) {
     OBJECTHIDE=false;     
     //ObjectSetString(0,"ButtonSHOWHIDE",OBJPROP_TEXT,"SHOW");
     ///ObjectSetInteger(0,"ButtonSHOWHIDE",OBJPROP_BGCOLOR,clrGreen);
     ///ObjectSetInteger(0,"ButtonSHOWHIDE",OBJPROP_STATE,true);
     }else{
     OBJECTHIDE=true;
     //ObjectSetString(0,"ButtonSHOWHIDE",OBJPROP_TEXT,"HIDE");
     ///ObjectSetInteger(0,"ButtonSHOWHIDE",OBJPROP_BGCOLOR,clrGray);
     ///ObjectSetInteger(0,"ButtonSHOWHIDE",OBJPROP_STATE,false);
     }  
     Comment("Object Hide",OBJECTHIDE);     
     GizleGoster("Trendline");
     //Alert("ButtonScroll",scrollchart);
     //ObjectSetInteger(0,"ButtonScroll",OBJPROP_STATE,true);ObjectSetInteger(0,"ButtonScroll",OBJPROP_STATE,false);
     }   
  
  
  if ( sparam == 31 ) { // s
  if ( stoplevelsystem ) { stoplevelsystem=false; 
ObjectDelete(ChartID(),"FinishMoney");
ObjectDelete(ChartID(),"FinishMoneyH");
ObjectDelete(ChartID(),"FinishMoneyH5");
ObjectDelete(ChartID(),"FinishMoneyX");
ObjectDelete(ChartID(),"FinishMoneyHX");
ObjectDelete(ChartID(),"FinishMoneyHX5");
ObjectSetInteger(ChartID(),"LotSize", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
ObjectSetInteger(ChartID(),"LotSizeSell", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
ObjectSetInteger(ChartID(),"Balance", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
  
  } else { stoplevelsystem=true;
  ObjectSetInteger(ChartID(),"LotSize", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1 | OBJ_PERIOD_H1);
  ObjectSetInteger(ChartID(),"LotSizeSell", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1 | OBJ_PERIOD_H1);
  ObjectSetInteger(ChartID(),"Balance", OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1 | OBJ_PERIOD_H1);
  }
  Comment("StopLevelSystem:",stoplevelsystem);
  }  
    
  

  if ( sparam == 39 ) { // ş
  if ( sekil ) { sekil=false; } else { sekil=true;}
  Comment("Şekil:",sekil);
  }  
  
  
  if ( sparam == 24 ) { // O
  if ( TradeAllow ) { TradeAllow=false; } else { TradeAllow=true;}
  Comment("TradeAllow:",TradeAllow);
  }
  
  if ( sparam == 25 ) { // P
  ClosePendingTradesCommentSym("ENTRY",Symbol());
  Comment("Delete Order: Pending");
  }
  
  
  ////////////////////////////////////////////////////////////////////
  // EXPENSION GIZLE 
  ////////////////////////////////////////////////////////////////////
  if ( int(sparam) > 1 && int(sparam) < 11 ) {
  
  int exp_num = sparam;
  
  //Print("sparam",sparam,"lparam",lparam);

     if ( ObjectGetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES, -1);
     }
  
  }
  ///////////////////////////////////////////////////////////////////
  
  if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_EXPANSION ) {
  
  ///////////////////////////////////////////////////////////////////////////////////////////
           
           int exp_say=1;
           
           int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     int indexofexp = StringFind(name,"Expansion", 0); 
     
     if ( indexofexp != -1 ) {
     exp_say=exp_say+1;
     Expansion_List[exp_say]=name;     
     }
     
     


     
     }
     

//////////////////////////////////////////////////////////////////////////////////////////////     
     
     
     
  
  
  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
  
  //ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELWIDTH,2);
  if ( renk_sec != clrWhite ) {ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELCOLOR,renk_sec);
  renk_sec=clrWhite;
  ObjectSetInteger(ChartID(),"Renk1",OBJPROP_STATE,true);
  }
  
  //Last_Expansion != "" && 
  if ( Last_Expansion != sparam ) {
   //ObjectSetInteger(ChartID(),Last_Expansion,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),Last_Expansion,OBJPROP_LEVELWIDTH,1);
   if ( renk_sec != clrWhite ) {ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELCOLOR,renk_sec);
   renk_sec=clrWhite;
   ObjectSetInteger(ChartID(),"Renk0",OBJPROP_STATE,true);
   }
   Last_Expansion=sparam;
  }
  
  //Alert(sparam);
    
  
  } else {
  ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELWIDTH,1);
  }
  
  }
  
  
//////////////////////////////////////////////////////////////////////////////
  
          int indexof = StringFind(sparam,"ButtonPARITE", 0); 
        //int indexofp = StringFind(namet,"PATTERN", 0);
        
        if ( indexof != -1 ) {//Alert(ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP));
        long BPChartID=IntegerToString(ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP));
        
        //Sleep(500);
        ObjectSetInteger(ChartFirst(),sparam,OBJPROP_STATE,false);
        ChartSetInteger(BPChartID,CHART_BRING_TO_TOP,1);
        }
        
        if ( sparam == "16" ) { // Sistem Line Q
        ChartSetInteger(ChartFirst(),CHART_BRING_TO_TOP,1);
        }
        
        if ( sparam == "19" ) { // Sistem Line R
        AllChart();
        }    
        
        if ( sparam == "17" ) { // Sistem Line W
        
        
                  long ChartLast,prevChart=ChartFirst();
   int i=0,limit=100;
   //Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      ChartLast=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      if(ChartLast<0) break;          // Have reached the end of the chart list
      Print(i,ChartSymbol(ChartLast)," ID =",ChartLast);
      prevChart=ChartLast;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
      }
      
        
        ChartSetInteger(prevChart,CHART_BRING_TO_TOP,0,true);
        //ChartGetInteger(prevChart, CHART_IS_MAXIMIZED);
        
        }               
        
        if ( sparam == "32" ) { // Sistem Line D
        ObjectDeletes("PARITE");
        }     
        

/////////////////////////////////////////////////////////////////////////////////

//Print("Sparam",sparam);



  
  if ( sparam == "38" ) { // Sistem Line L
  if ( SistemLine ) {
     ObjectDelete(0,"V Line");
     ObjectDelete(0,"H Line");
     SistemLine=false;
     ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,0);
     Comment("SistemLine: ",SistemLine);
  } else {
  ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);
  SistemLine=true;
  Comment("SistemLine: ",SistemLine);
  }  
  
  }
  
  
  if ( sparam == "35" ) { // HighLow H
  if ( HighLow ) {
     HighLow=false;         
  } else {
  HighLow=true;  
  }  
  Comment("HighLow: ",HighLow);
  }
  
  if ( sparam == "20" ) { // Time H
  if ( TimeSet ) {
     TimeSet=false;         
  } else {
  TimeSet=true;  
  }  
  Comment("TimeSet: ",TimeSet);
  }
  
      
  
  
  //Print(sparam,"/",lparam);
  
  if ( sparam == 46 || sparam == 44 ) { // C veya Z siliyor
  if ( mouse_line == 0 ) {
  ObjectDeletes("MouseLine");
  }  
  if ( mouse_line > -1 ) {
  ObjectDeletes("MouseLine"+mouse_line);
  mouse_line=mouse_line-1;
  }

  
  }
  
  
  
   
  if ( ObjectFind("MouseLine"+mouse_line)!=-1 && sparam==7 && SistemLine) {
  ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_COLOR,clrYellow);
  }
  
  if ( ObjectFind("MouseLine"+mouse_line)!=-1 && sparam==3 && SistemLine) {
  ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_COLOR,clrBlue);
  }
    
  if ( ObjectFind("MouseLine"+mouse_line)!=-1 && sparam==4 && SistemLine) {
  ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_COLOR,clrRed);
  }
      
  if ( ObjectFind("MouseLine"+mouse_line)!=-1 && sparam==5 && SistemLine) {
  ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_COLOR,clrGreen);
  }
        
  if ( ObjectFind("MouseLine"+mouse_line)!=-1 && sparam==6 && SistemLine) {
  ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_COLOR,clrLimeGreen);
  }
          
  
  
  //--- Show the event parameters on the chart
   //Comment(__FUNCTION__,": id=",id," lparam=",lparam," dparam=",dparam," sparam=",sparam);
//--- If this is an event of a mouse click on the chart

      if ( lparam == 17 ) {
      //Alert("Sol");
      ObjectDelete(0,"V Line");
      ObjectDelete(0,"H Line");
      Sistem=false;
      }
      


   if(id==CHARTEVENT_MOUSE_MOVE && SistemLine ){
      //Comment("\n POINT: ",(int)lparam,",",(int)dparam,"\n",MouseState((uint)sparam));
      
      if ( ((uint)sparam& 2)== 2 || lparam == 17 ) {
      //Alert("Sol");
      ObjectDelete(0,"V Line");
      ObjectDelete(0,"H Line");
      Sistem=false;
      //mouse_line=mouse_line+1;
      }
      /*
      
      if ( ((uint)sparam& 8)== 8 ) {
      //Alert("Ctrl");
      Sistem=true;
      }


      if ( ((uint)sparam& 4)== 4 ) {
      //Alert("Sol");
      ObjectDelete(0,"V Line");
      ObjectDelete(0,"H Line");
      Sistem=false;
      }      */
            
      
      }
      
      
if(id==CHARTEVENT_CLICK && !Sistem && SistemLine)  {     

      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
                 if (GetMicrosecondCount() - click < dclick)
         {
            onDoubleClick(id, lparam, dparam, sparam);
            click = 0;
         } else {
            onClick(id, lparam, dparam, sparam);
            click = GetMicrosecondCount();
         }
        
        }
        }
        
              
  
  
  
   if(id==CHARTEVENT_CLICK && Sistem && SistemLine)
   //if(id==CHARTEVENT_MOUSE_MOVE && Sistem)
   
   
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        int shiftdt=iBarShift(Symbol(),Period(),dt);
        
        
        if ( ObjectFind("MouseLine"+mouse_line) != -1 ) {
        
        if ( fiboset ) {
        if ( fiboset_tepe > price ) {
        ObjectMove("MouseLine"+mouse_line,0,dt,price);
        ObjectMove("MouseLine"+mouse_line,1,dt,price+(fiboset_tepe-fiboset_dip));                
        } else {
        ObjectMove("MouseLine"+mouse_line,0,dt,price);
        ObjectMove("MouseLine"+mouse_line,1,dt,price-(fiboset_tepe-fiboset_dip));        
        }
        } else {
        ObjectMove("MouseLine"+mouse_line,0,dt,price);
        ObjectMove("MouseLine"+mouse_line,1,dt+PeriodSeconds()*150,price);
        }
        
        }
        
        //Comment("Price:",price,"/Shift:",shiftdt,"mouseline",mouse_line);
        
               
                
        ///Comment("\nENTRY:",ENTRY,"\nTP1:",TP1,"\nTP2:",TP2,"\nTP3:",TP3);
       

        
        
         PrintFormat("Window=%d X=%d  Y=%d  =>  Time=%s  Price=%G",window,x,y,TimeToString(dt),price);
         //--- Perform reverse conversion: (X,Y) => (Time,Price)
         if(ChartTimePriceToXY(0,window,dt,price,x,y))
            PrintFormat("Time=%s  Price=%G  =>  X=%d  Y=%d",TimeToString(dt),price,x,y);
         else
            Print("ChartTimePriceToXY return error code: ",GetLastError());
         //--- delete lines
         ObjectDelete(0,"V Line");
         ObjectDelete(0,"H Line");
         //--- create horizontal and vertical lines of the crosshair
         ObjectCreate(0,"H Line",OBJ_HLINE,window,dt,price);
         ObjectCreate(0,"V Line",OBJ_VLINE,window,dt,price);
         ObjectSetInteger(0,"V Line",OBJPROP_COLOR,button_Colorz);
         ObjectSetInteger(0,"H Line",OBJPROP_COLOR,button_Colorz);
         ObjectSetInteger(0,"H Line",OBJPROP_BACK,true); 
         ObjectSetInteger(0,"V Line",OBJPROP_BACK,true); 
         
         //mouse_click=mouse_click+1;
         //Comment(mouse_line);
         
         
         
         ChartRedraw(0);
         
         
         if (GetMicrosecondCount() - click < dclick)
         {
            onDoubleClick(id, lparam, dparam, sparam);
            click = 0;
         } else {
            onClick(id, lparam, dparam, sparam);
            click = GetMicrosecondCount();
         }
         
         
        }
      else
         Print("ChartXYToTimePrice return error code: ",GetLastError());
      Print("+--------------------------------------------------------------+");
     }
  
  
  
  
  
  
  
  
  
  if(id==CHARTEVENT_CLICK && sistemtrend)
   //if(id==CHARTEVENT_MOUSE_MOVE && Sistem)
   
   
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        int shiftdt=iBarShift(Symbol(),Period(),dt);
        
        
        if ( ObjectFind("TrenLine"+shiftdt) != -1 ) {
        ObjectMove("TrendLine "+dt,0,dt,High[shiftdt]);
        ObjectMove("TendLine "+dt,1,dt,Low[shiftdt]);
        } else {
        if ( Open[shiftdt] > Close[shiftdt] ) {
        ObjectCreate(ChartID(),"TrendLine "+dt,OBJ_TREND,0,Time[shiftdt],High[shiftdt],Time[shiftdt],Low[shiftdt]);
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_COLOR,clrRed);
        }
        if ( Open[shiftdt] < Close[shiftdt] ) {
        ObjectCreate(ChartID(),"TrendLine "+dt,OBJ_TREND,0,Time[shiftdt],Low[shiftdt],Time[shiftdt],High[shiftdt]);
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_COLOR,clrBlue);
        }        
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_RAY,false);
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_WIDTH,2);
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_SELECTABLE,true);
        ObjectSetInteger(ChartID(),"TrendLine "+dt,OBJPROP_BACK,true);
        
        }
        
        //Comment("Price:",price,"/Shift:",shiftdt,"mouseline",mouse_line);
        
               
                
        ///Comment("\nENTRY:",ENTRY,"\nTP1:",TP1,"\nTP2:",TP2,"\nTP3:",TP3);
       

        
        
         PrintFormat("Window=%d X=%d  Y=%d  =>  Time=%s  Price=%G",window,x,y,TimeToString(dt),price);
         //--- Perform reverse conversion: (X,Y) => (Time,Price)
         if(ChartTimePriceToXY(0,window,dt,price,x,y))
            PrintFormat("Time=%s  Price=%G  =>  X=%d  Y=%d",TimeToString(dt),price,x,y);
         else
            Print("ChartTimePriceToXY return error code: ",GetLastError());
         //--- delete lines
         /*ObjectDelete(0,"V Line");
         ObjectDelete(0,"H Line");
         //--- create horizontal and vertical lines of the crosshair
         ObjectCreate(0,"H Line",OBJ_HLINE,window,dt,price);
         ObjectCreate(0,"V Line",OBJ_VLINE,window,dt,price);
         ObjectSetInteger(0,"V Line",OBJPROP_COLOR,button_Colorz);
         ObjectSetInteger(0,"H Line",OBJPROP_COLOR,button_Colorz);
         ObjectSetInteger(0,"H Line",OBJPROP_BACK,true); 
         ObjectSetInteger(0,"V Line",OBJPROP_BACK,true); */
         
         //mouse_click=mouse_click+1;
         //Comment(mouse_line);
         
         
         
         ChartRedraw(0);
         
         
         if (GetMicrosecondCount() - click < dclick)
         {
            onDoubleClick(id, lparam, dparam, sparam);
            click = 0;
         } else {
            onClick(id, lparam, dparam, sparam);
            click = GetMicrosecondCount();
         }
         
         
        }
      else
         Print("ChartXYToTimePrice return error code: ",GetLastError());
      Print("+--------------------------------------------------------------+");
     }
  
  
  
  
  
  
  
  
  
  
  
  
  
  //Print("Param",id);
  
  if ( scale != ChartGetInteger(0,CHART_SCALE) ) {
  Comment("Scale:",ChartGetInteger(0,CHART_SCALE));
  scale=ChartGetInteger(0,CHART_SCALE);
  }
  
  
    if ( id == 9 ) {


  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }
  
  
  
/////////////////////////////////////////////////////////////  
if ( Chart_Pos < right_bound ) 
{
Chart_Rewind = true;Chart_Forward=false;
//Print("Geri Gidiyor");
ChartSetInteger(currChart,CHART_AUTOSCROLL,false);
}
else 
{
Chart_Rewind = false;Chart_Forward=true;
//Print("İleri Gidiyor");
if (Chart_Pos < 0 ) ChartSetInteger(currChart,CHART_AUTOSCROLL,true);
}
Chart_Pos = right_bound;
//Print(right_bound);
}

/////////////////////////////////////////////////////////////
  //sparam == 36 || j
  if (  sparam == 33 ) {
  
  Print("L-Param",sparam,"/ J /",fiboset);
  
  if ( fiboset ) {
  fiboset=false;
  Comment("Fiber Set:",fiboset," / Scale:",ChartGetInteger(0,CHART_SCALE));} 
  else {
  fiboset=true;
  Comment("Fiber Set:",fiboset," / Scale:",ChartGetInteger(0,CHART_SCALE));
  }
  
  
  }
  ///////////////////////////////////////////////////////////////////
  // 764 Senkronizasyon
  ///////////////////////////////////////////////////////////////////
  if (  sparam == 36 ) {
  if( fiboset==false  ) {
  fiboset=true;
  } else {
  fiboset=false;
  }
  
  }
  /////////////////////////////////////////////////////////////
  
  if ( sparam == 50 ) {
  
  Print("L-Param",sparam,"/ J /",fiboset);
  
  if ( sistemtrend ) {
  sistemtrend=false;
  Comment("Super Trend Set:",sistemtrend," / Scale:",ChartGetInteger(0,CHART_SCALE));} 
  else {
  sistemtrend=true;
  Comment("Super Trend Set:",sistemtrend," / Scale:",ChartGetInteger(0,CHART_SCALE));
  }
  
  
  }
  
  
    
  
//---
        
           string namet=sparam;
   long currChart=ChartID();
   
   
             int indexofibo = StringFind(namet,"Fibo", 0);         
             int indexorderline = StringFind(namet,"#", 0);         
             int indexofcizgi = StringFind(namet,"Cizgi", 0);         
             int indexofgen = StringFind(namet,"Genislik", 0);         
             int indexoftrend = StringFind(namet,"Trendline", 0); 

UsdIndex(sparam);             
   
OzhFormasyon(sparam);

        
   
   
     if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_EXPANSION && fiboset && SistemLine == false ) {
        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        
        if ( price1 > price2 ) {
        
        ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        ObjectMove(currChart,namet,2,time3,price2+(((price1-price2)/100)*61.8));
        int Fark=(((price1-price2)*4.5)-(((price1-price2)/100)*61.8))/Point;
        Comment(Fark);
        }
        
        if ( price2 > price1 ) {
        
        ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        ObjectMove(currChart,namet,2,time3,price2-(((price2-price1)/100)*61.8));
        int Fark=(((price2-price1)*4.5)-(((price2-price1)/100)*61.8))/Point;
        Comment(Fark);
       
        
        }
        
        }
        
        
if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_FIBO && fiboset && SistemLine == false ) {




        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        

        
        
        
        
        if ( price1 > price2 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
               
        
        //ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        }
        
        if ( price2 > price1 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
                
        
        
        //ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        //ObjectMove(currChart,namet,2,time3,Low[shift3]);
        }
        
        

        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
                
        
        
if ( ObjectFind(namet+" Line") == -1 ) {
ObjectCreate(ChartID(),namet+" Line",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_SELECTED,false);
} else {


if ( price1 < price2 ) {
ObjectMove(currChart,namet+" Line",0,time1+5*PeriodSeconds(),price1+(MathAbs(price1-price2)*3));
ObjectMove(currChart,namet+" Line",1,time2+5*PeriodSeconds(),price2+(MathAbs(price1-price2)*3));
}

if ( price1 > price2 ) {
ObjectMove(currChart,namet+" Line",0,time1+5*PeriodSeconds(),price1-(MathAbs(price1-price2)*3));
ObjectMove(currChart,namet+" Line",1,time2+5*PeriodSeconds(),price2-(MathAbs(price1-price2)*3));
}



}

        
        
        }
        
        
        
//TimeSet=true;









if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_RECTANGLE && TimeSet ) {




        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        

        
        
        
        /*
        if ( price1 > price2 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
               
        
        //ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        }
        
        if ( price2 > price1 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
                
        
        
        //ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        //ObjectMove(currChart,namet,2,time3,Low[shift3]);
        }*/
        
        

        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
                
                Comment("Shift:",shift1-shift2);
        
        
if ( ObjectFind(namet+" Line") == -1 ) {
ObjectCreate(ChartID(),namet+" Line",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

ObjectCreate(ChartID(),namet+" Lines",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

ObjectCreate(ChartID(),namet+" Linex",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,true);

ObjectCreate(ChartID(),namet+" Linesx",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,true);

ObjectCreate(ChartID(),namet+" Linesxx",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxs",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxss",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxsss",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxssy",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxsssy",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_COLOR,clrBlack);

} else {


if ( price1 < price2 ) {
ObjectMove(currChart,namet+" Line",0,time2,price1);
ObjectMove(currChart,namet+" Line",1,time2+((time2-time1)/2),price1+((price2-price1)/2));

ObjectMove(currChart,namet+" Lines",0,time2,price2);
ObjectMove(currChart,namet+" Lines",1,time2+((time2-time1)/2),price2-((price2-price1)/2));


ObjectMove(currChart,namet+" Linesxxsss",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsss",1,time2+((time2-time1)),price2);

ObjectMove(currChart,namet+" Linesxxsssy",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsssy",1,time2+((time2-time1)),price1);



ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,true);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linex",0,Time[shift2],price1);
ObjectMove(currChart,namet+" Linex",1,Time[shift2-int((shift1-shift2)/2)],price1+((price2-price1)/2));

ObjectMove(currChart,namet+" Linesx",0,Time[shift2],price2);
ObjectMove(currChart,namet+" Linesx",1,Time[shift2-int((shift1-shift2)/2)],price2-((price2-price1)/2));

ObjectMove(currChart,namet+" Linesxx",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxx",1,Time[shift2-int(shift1-shift2)],price2);


ObjectMove(currChart,namet+" Linesxxssy",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxssy",1,Time[shift2-int(shift1-shift2)],price1);



}

}

if ( price1 > price2 ) {
ObjectMove(currChart,namet+" Line",0,time2+(time2-time1),price2);
ObjectMove(currChart,namet+" Line",1,time2,price1);

ObjectMove(currChart,namet+" Lines",0,time2,price2);
ObjectMove(currChart,namet+" Lines",1,time2+(time2-time1),price1);

ObjectMove(currChart,namet+" Linesxxsss",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsss",1,time2+((time2-time1)),price2);

ObjectMove(currChart,namet+" Linesxxsssy",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsssy",1,time2+((time2-time1)),price1);



ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linex",0,Time[shift2-int(shift1-shift2)],price2);
ObjectMove(currChart,namet+" Linex",1,Time[shift2],price1);

ObjectMove(currChart,namet+" Linesx",0,Time[shift2],price2);
ObjectMove(currChart,namet+" Linesx",1,Time[shift2-int(shift1-shift2)],price1);

ObjectMove(currChart,namet+" Linesxx",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxx",1,Time[shift2-int(shift1-shift2)],price2);

ObjectMove(currChart,namet+" Linesxxssy",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxssy",1,Time[shift2-int(shift1-shift2)],price1);

}

}

ObjectMove(currChart,namet+" Linesxxs",0,time2+((time2-time1)),price2);
ObjectMove(currChart,namet+" Linesxxs",1,time2+((time2-time1)),price1);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linesxxss",0,Time[shift2-int(shift1-shift2)],price2);
ObjectMove(currChart,namet+" Linesxxss",1,Time[shift2-int(shift1-shift2)],price1);
}

}

        
        
        }
                
                
                
                //TimeSet=false;
                
if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_TRIANGLE && TimeSet ) {




        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        

        
        
        
        /*
        if ( price1 > price2 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,High[shift1]);
        }
        
               
        
        //ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        }
        
        if ( price2 > price1 ) {
        
        if ( Open[shift1] > Close[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Close[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
        if ( Close[shift1] > Open[shift1] ) {
        ObjectMove(currChart,namet,0,time1,Open[shift1]);
        if ( HighLow ) ObjectMove(currChart,namet,0,time1,Low[shift1]);
        }
        
                
        
        
        //ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        //ObjectMove(currChart,namet,2,time3,Low[shift3]);
        }*/
        
        

        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        
        int shiftfark = (shift1-shift2)+(shift1-shift3);
        int shiftfark4 = shiftfark*4;
        int shiftfark4618 = (shiftfark4/100)*61.8;
        
        if ( shiftfark > 0 ) {
        
if ( ObjectFind(namet+" Line") == -1 ) {

if ( shift1-shiftfark > -1 ) {
ObjectCreate(ChartID(),namet+" Line",OBJ_VLINE,0,Time[shift1-shiftfark],Ask);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_COLOR,clrYellow);
}


ObjectCreate(ChartID(),namet+" Lines",OBJ_VLINE,0,time1+((shiftfark)*PeriodSeconds()),Ask);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_COLOR,clrRed);


if ( shift3-shiftfark > -1 ) {
ObjectCreate(ChartID(),namet+" Linex",OBJ_VLINE,0,Time[shift3-shiftfark],Ask);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,true);
}


ObjectCreate(ChartID(),namet+" Linesx",OBJ_VLINE,0,time3+((shiftfark)*PeriodSeconds()),Ask);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,true);

//////////////////////////////////////////////////////////////////////////////////////////////////
ObjectCreate(ChartID(),namet+" Linesxx",OBJ_VLINE,0,time1+((shiftfark4)*PeriodSeconds()),Ask);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_COLOR,clrRed);
ObjectSetString(ChartID(),namet+" Linesxx",OBJPROP_TEXT,"4 Time");

//ObjectCreate(ChartID(),namet+" Liness",OBJ_VLINE,0,time1+((shiftfark*3)*PeriodSeconds()),Ask);
//ObjectCreate(ChartID(),namet+" Liness",OBJ_VLINE,0,Time[shift3-(shiftfark*3)]);
if ( shift1-shiftfark4 > -1 ) {
ObjectCreate(ChartID(),namet+" Liness",OBJ_VLINE,0,Time[int(shift1-shiftfark4)],Ask);
ObjectSetInteger(ChartID(),namet+" Liness",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Liness",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Liness",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Liness",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Liness",OBJPROP_COLOR,clrYellow);
ObjectSetString(ChartID(),namet+" Liness",OBJPROP_TEXT,"4 Shift");
} else {ObjectDelete(namet+" Liness");}

if ( shift1-shiftfark4618 > -1 ) {
ObjectCreate(ChartID(),namet+" Liness4",OBJ_VLINE,0,Time[int(shift1-shiftfark4618)],Ask);
ObjectSetInteger(ChartID(),namet+" Liness4",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Liness4",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Liness4",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Liness4",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Liness4",OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),namet+" Liness4",OBJPROP_TEXT,"4-618 Shift");
} else {ObjectDelete(namet+" Liness4");}

ObjectCreate(ChartID(),namet+" Liness4x",OBJ_VLINE,0,time1+((shiftfark4618)*PeriodSeconds()),Ask);
ObjectSetInteger(ChartID(),namet+" Liness4x",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Liness4x",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Liness4x",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Liness4x",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Liness4x",OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),namet+" Liness4x",OBJPROP_TEXT,"4-618 Shift");


} else {
if ( shift1-shiftfark > -1 ) ObjectMove(currChart,namet+" Line",0,Time[shift1-shiftfark],Ask);
ObjectMove(currChart,namet+" Lines",0,time1+((shiftfark)*PeriodSeconds()),Ask);
if ( shift3-shiftfark > -1 ) ObjectMove(currChart,namet+" Linex",0,Time[shift3-shiftfark],Ask);
ObjectMove(currChart,namet+" Linesx",0,time3+((shiftfark)*PeriodSeconds()),Ask);

ObjectMove(currChart,namet+" Linesxx",0,time1+((shiftfark4)*PeriodSeconds()),Ask);
//ObjectMove(currChart,namet+" Liness",0,Time[shift3-(shiftfark*3)],Ask);
if ( shift1-shiftfark4 > -1 )  ObjectMove(currChart,namet+" Liness",0,Time[int(shift1-shiftfark4)],Ask);

if ( shift1-shiftfark4618 > -1 )  ObjectMove(currChart,namet+" Liness4",0,Time[int(shift1-shiftfark4618)],Ask);
ObjectMove(currChart,namet+" Liness4x",0,time1+((shiftfark4618)*PeriodSeconds()),Ask);
}       
        
        
        }
                
                Comment(shift1,"Shift:",shift1-shift2,"/ shift1-shift2 ",shift1-shift3,"/ shiftfark",shiftfark,"/ Dönüş Yeri",shiftfark*4,"/",int(shift1-shiftfark4));
        
        /*
if ( ObjectFind(namet+" Line") == -1 ) {
ObjectCreate(ChartID(),namet+" Line",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Line",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

ObjectCreate(ChartID(),namet+" Lines",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Lines",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

ObjectCreate(ChartID(),namet+" Linex",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,true);

ObjectCreate(ChartID(),namet+" Linesx",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,true);

ObjectCreate(ChartID(),namet+" Linesxx",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxx",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxs",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxs",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxss",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxss",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxsss",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxsss",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxssy",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxssy",OBJPROP_COLOR,clrBlack);

ObjectCreate(ChartID(),namet+" Linesxxsssy",OBJ_TREND,0,time1+5*PeriodSeconds(),price1,time2+5*PeriodSeconds(),price2);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_SELECTED,false);
ObjectSetInteger(ChartID(),namet+" Linesxxsssy",OBJPROP_COLOR,clrBlack);

} else {


if ( price1 < price2 ) {
ObjectMove(currChart,namet+" Line",0,time2,price1);
ObjectMove(currChart,namet+" Line",1,time2+((time2-time1)/2),price1+((price2-price1)/2));

ObjectMove(currChart,namet+" Lines",0,time2,price2);
ObjectMove(currChart,namet+" Lines",1,time2+((time2-time1)/2),price2-((price2-price1)/2));


ObjectMove(currChart,namet+" Linesxxsss",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsss",1,time2+((time2-time1)),price2);

ObjectMove(currChart,namet+" Linesxxsssy",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsssy",1,time2+((time2-time1)),price1);



ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,true);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linex",0,Time[shift2],price1);
ObjectMove(currChart,namet+" Linex",1,Time[shift2-int((shift1-shift2)/2)],price1+((price2-price1)/2));

ObjectMove(currChart,namet+" Linesx",0,Time[shift2],price2);
ObjectMove(currChart,namet+" Linesx",1,Time[shift2-int((shift1-shift2)/2)],price2-((price2-price1)/2));

ObjectMove(currChart,namet+" Linesxx",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxx",1,Time[shift2-int(shift1-shift2)],price2);


ObjectMove(currChart,namet+" Linesxxssy",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxssy",1,Time[shift2-int(shift1-shift2)],price1);



}

}

if ( price1 > price2 ) {
ObjectMove(currChart,namet+" Line",0,time2+(time2-time1),price2);
ObjectMove(currChart,namet+" Line",1,time2,price1);

ObjectMove(currChart,namet+" Lines",0,time2,price2);
ObjectMove(currChart,namet+" Lines",1,time2+(time2-time1),price1);

ObjectMove(currChart,namet+" Linesxxsss",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsss",1,time2+((time2-time1)),price2);

ObjectMove(currChart,namet+" Linesxxsssy",0,time2,price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxsssy",1,time2+((time2-time1)),price1);



ObjectSetInteger(ChartID(),namet+" Linesx",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),namet+" Linex",OBJPROP_RAY,false);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linex",0,Time[shift2-int(shift1-shift2)],price2);
ObjectMove(currChart,namet+" Linex",1,Time[shift2],price1);

ObjectMove(currChart,namet+" Linesx",0,Time[shift2],price2);
ObjectMove(currChart,namet+" Linesx",1,Time[shift2-int(shift1-shift2)],price1);

ObjectMove(currChart,namet+" Linesxx",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxx",1,Time[shift2-int(shift1-shift2)],price2);

ObjectMove(currChart,namet+" Linesxxssy",0,Time[shift2],price1+((price2-price1)/2));
ObjectMove(currChart,namet+" Linesxxssy",1,Time[shift2-int(shift1-shift2)],price1);

}

}

ObjectMove(currChart,namet+" Linesxxs",0,time2+((time2-time1)),price2);
ObjectMove(currChart,namet+" Linesxxs",1,time2+((time2-time1)),price1);

if ( shift2-int(shift1-shift2) > 0 ) {
ObjectMove(currChart,namet+" Linesxxss",0,Time[shift2-int(shift1-shift2)],price2);
ObjectMove(currChart,namet+" Linesxxss",1,Time[shift2-int(shift1-shift2)],price1);
}

}
*/
        
        
        }
                         
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
   
  }
//+------------------------------------------------------------------+


 
  ulong click = 0;
ulong dclick = 200000;


void onDoubleClick(const int id,
                  const long& lparam,
                  const double& dparam,
                  const string& sparam)
{
   int x = (int)lparam;
   int y = (int)dparam;

   int window  = 0;
   datetime dt = 0;
   double   p  = 0;


   if (ChartXYToTimePrice(0, x, y, window, dt, p))
      onXYDoubleClick(window, x, y, dt, p);   
      
      
      
//      Alert("DoubleClick");
         
}

void onClick(const int id,
                  const long& lparam,
                  const double& dparam,
                  const string& sparam)
{
   int x = (int)lparam;
   int y = (int)dparam;

   int window  = 0;
   datetime dt = 0;
   double   p  = 0;

   if (ChartXYToTimePrice(0, x, y, window, dt, p))
      onXYClick(window, x, y, dt, p);      
}

void onXYDoubleClick(int window, int x, int y, datetime dt, double p)
{


//Alert("Double Click");



if ( Sistem ) {

      ObjectDelete(0,"V Line");
      ObjectDelete(0,"H Line");
      Sistem=false;

} else {

if ( !Sistem ) {
Sistem=true;
mouse_line=mouse_line+1;

if ( fiboset ) {
ObjectCreate(ChartID(),"MouseLine"+mouse_line,OBJ_TREND,0,Time[1],Close[1],Time[5],Close[1]);
ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_WIDTH,2);

} else {

ObjectCreate(ChartID(),"MouseLine"+mouse_line,OBJ_TREND,0,Time[1],Close[1],Time[5],Close[1]);
ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_RAY,0);
ObjectSetInteger(ChartID(),"MouseLine"+mouse_line,OBJPROP_WIDTH,2);
}
//mouse_line

}
}



   
   double   price =p;
   //int      window=0;
   int per=Period();

}  
  

  
  
  void onXYClick(int window, int x, int y, datetime dt, double p)
{

}


//////////////////////////////////////////////////////////////////////////////
// Object Delete
/////////////////////////////////////////////////////////////////////////////

void ObjectDeletes(string name) {

             long currChart=ChartID();
         
        string namet;
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        
        
        namet = ObjectName(currChart,i);
        int indexof = StringFind(namet,name, 0); 
        //int indexofp = StringFind(namet,"PATTERN", 0);
        
        if ( indexof != -1 ) ObjectDelete(currChart,namet);
        //Sleep(10);
        
        }

}


string GetPeriyodString(int per) {

string TVL_time="";

        if ( per == PERIOD_MN1 ) TVL_time="MN1";
        if ( per == PERIOD_W1 ) TVL_time="W1";
        if ( per == PERIOD_D1 ) TVL_time="D1";
        if ( per == PERIOD_H4 ) TVL_time="H4";
        if ( per == PERIOD_H1 ) TVL_time="H1";
        if ( per == PERIOD_M30 ) TVL_time="M30";
        if ( per == PERIOD_M15 ) TVL_time="M15";
        if ( per == PERIOD_M5 ) TVL_time="M5";
        if ( per == PERIOD_M1 ) TVL_time="M1";

return TVL_time;

}


void AllChart() {


int bspixely = 40;//55;//615;
  int bspixelx = -90;
  int bline = 2;
  int bsay = 0;
  
  ObjectDeletes("PARITE");
  
    if ( ChartID() == ChartFirst() ) {
  //Alert(ChartSymbol());
  
       bool pairCheck=false;
     
          long currChart,prevChart=ChartFirst();
   int i=0,limit=100;
   //Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      if(currChart<0) break;          // Have reached the end of the chart list
      Print(i,ChartSymbol(currChart)," ID =",currChart);
      
      
      if ( bsay == 10 ) {
      bspixely = bspixely+30;
      bsay=0;
      bspixelx=-90;      
      }
      bspixelx=bspixelx+100;
      bsay=bsay+1;
      
      
//long currChart = sinyal_charid;
   string buttonID="ButtonPARITE"+currChart; // Support LeveL Show
              Print(buttonID,"/",bspixely);    
              //ObjectDelete(ChartFirst(),buttonID);  
              
              long currCharts=ChartFirst();
                              
   ObjectCreate(currCharts,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_BGCOLOR,clrDarkGray);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_XDISTANCE,bspixelx);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_YDISTANCE,bspixely);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_XSIZE,100);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_YSIZE,20);
    ObjectSetString(currCharts,buttonID,OBJPROP_FONT,"Arial");
    ObjectSetString(currCharts,buttonID,OBJPROP_TEXT,ChartSymbol(currChart)+" "+GetPeriyodString(ChartPeriod(currChart)));
    ObjectSetString(currCharts,buttonID,OBJPROP_TOOLTIP,currChart);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(currCharts,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   
   
      
      //ChartSetSymbolPeriod(currChart,Symbol(), ChartPeriod(currChart));      
      //ChartSetInteger(currChart,CHART_AUTOSCROLL,false);

      //if ( ChartSymbol(currChart) == sinyal_sym ) pairCheck = true;
            
      //if ( ChartFirst() != currChart && pairCheck && Symbol() != ChartSymbol(currChart) ) {pairCheck =false;///ChartClose(currChart);
      //ChartSetInteger(currChart,CHART_BRING_TO_TOP,1);
      //} // Önceki pair kapatıp sona açar

      prevChart=currChart;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
     }
     }
     
     
     }
     
     
////////////////////////////////////////////////////////////////////////////////////////////
// SON EKLENEN OBJE SEÇİLİR
////////////////////////////////////////////////////////////////////////////////////////////
void AlertObject(){

//Alert("Last_Object",last_object);

if ( ObjectFind(ChartID(),last_object) == -1 ) { 
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_HLINE);
}


/*
           long currChart=ChartID();
         int obj_total=ObjectsTotal(currChart);
        string namet;
        for(int i=0;i<obj_total;i++)
        {
        
        
        
        namet = ObjectName(currChart,i);
        //namet = ObjectName(i);
        
        Print(namet,"Text:",ObjectGetString(currChart,namet,OBJPROP_TEXT,0));
        //int indexof = StringFind(namet,"#", 0); 
        //int indexofp = StringFind(namet,"PATTERN", 0); 
        
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_TEXT ) {
        ObjectDelete(ChartID(),namet);
        }
        
        
        if ( ObjectFind(ChartID(),last_object) == -1 ) { 
        //Alert("Silinmiş");
        
        int indexof = StringFind(namet,last_object, 0); 
        
        if ( indexof != -1 ) {
        //ObjectDelete(ChartID(),namet);
        
        
        
        
        }
        
        
        }
        
        Sleep(100);
        
        
        //string obj_id = sparam;
       //int replaced=StringReplace(obj_id," TrendAngle","");
        
      /*  
        if ( ObjectFind(ChartID(),buttonID) == -1 ) { 
        
        
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) != OBJ_BUTTON && namet!="TEPE" && namet!="DIP" && indexof == -1
        
        && ObjectGetInteger(currChart,namet,OBJPROP_TYPE) != OBJ_VLINE
        
        //&& !LinePrice
        
        && indexofp == -1
        
        ) { 
        
        } 
        */
          



string name="CandleLine";
    if ( ObjectFind(ChartID(),name) == -1 ) { 
    name="CandleCenter";
    ObjectDelete(ChartID(),name);
    }

//return;

//return;

//Alert("AlertObject");

           long currChart=ChartID();
         int obj_total=ObjectsTotal(currChart);
        string namet;
        for(int i=0;i<obj_total;i++)
        {
        
        
        
        namet = ObjectName(currChart,i);
        int indexof = StringFind(namet,"#", 0); 
        int indexofp = StringFind(namet,"PATTERN", 0); 
        
      
 


        
        
//if ( indexof != -1 ) ObjectSetInteger(currChart,name,OBJPROP_BACK,false);

        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) != OBJ_BUTTON && namet!="TEPE" && namet!="DIP" && indexof == -1
        
        && ObjectGetInteger(currChart,namet,OBJPROP_TYPE) != OBJ_VLINE
        
        //&& !LinePrice
        
        && indexofp == -1
        
        ) { 
        //Print("namet:",namet,"=",indexof);
        ///ObjectSetInteger(currChart,namet,OBJPROP_BACK,true);
        
        }  // Objeleri Arka Plana Atar

        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_FIBOFAN ) {ObjectSetInteger(currChart,namet,OBJPROP_SELECTED,true);}//Alert(namet);
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_GANNFAN ) {ObjectSetInteger(currChart,namet,OBJPROP_SELECTED,true);}
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_FIBO ) {ObjectSetInteger(currChart,namet,OBJPROP_SELECTED,true);}        


/////////////////////////////////////////////////////////////////////////////



         int indexoship = StringFind(namet,"Ship", 0);
         int indexpullback = StringFind(namet,"PullBack", 0);
         
         
        /*if ( indexpullback != -1 ) {
         
        string obj_id = namet;
        int replaced=StringReplace(obj_id,"Rectangle ","");
         
         }*/
         

        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_RECTANGLE && indexoship == -1 ) {
        if ( indexpullback == -1 ) ObjectSetInteger(currChart,namet,OBJPROP_SELECTED,true);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
       datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
       datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
       double price_fark = MathAbs(price1-price2)/MarketInfo(Symbol(),MODE_POINT);
       
       bool Pull_Back=false;
       //if ( Pull_Back && Symbol() != "USDINDEXFUT" && indexpullback == -1 ) {
       if ( Pull_Back && indexpullback == -1 ) {
       
       string obj_id = namet;
       int replaced=StringReplace(obj_id,"Rectangle ","");

       //for (int x=1;x<=2;x++) { }   
       
          if ( price1 >  price2 ) {
          
         string name=namet + " PullBack 1";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2,time2,price2-(price1-price2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrGreen); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 2";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2,time2,price2-(price1-price2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_BACK,false); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 3";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2-(price1-price2),time2,price2-((price1-price2)*2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 4";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2-(price1-price2),time2,price2-((price1-price2)*2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_BACK,false); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
                  
                           
          
          }
         
          
          if ( price2 >  price1 ) {


         string name=namet + " PullBack 1";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2,time2,price2+(price2-price1));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrGreen); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 2";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2,time2,price2+(price2-price1));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_BACK,false); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 3";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2+(price2-price1),time2,price2+((price2-price1)*2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " PullBack 4";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,price2+(price2-price1),time2,price2+((price2-price1)*2));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_BACK,false); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         
         
                   
          
          }
              

       
       
       }
       
       
       //int price_pip = price_fark * 13.543; 
       int price_pip = price_fark * 1.3543; 
       if ( Symbol() != "USDX-MAR21" ) price_pip = price_fark * 1;
        //Alert("Dikdörtgen",price1,"/",price2,"=",price_fark," / pip=",price_pip);
        //Alert("Dikdörtgen",price1,"/",price2,"=",price_fark," / pip=",price_pip);
        
        /*ObjectDelete(currChart,namet+"l");
        ObjectCreate(currChart,namet+"l",OBJ_LABEL,0,0);
        ObjectSetString(currChart,namet+"l",OBJPROP_TEXT,"pip"+price_pip);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_COLOR,clrWhite);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_FONTSIZE,30);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_CORNER,CORNER_RIGHT_UPPER);*/
        
        //string LabelChart = "PricePipUSINDEX";//namet+"pricepip";
        string LabelChart = namet+" pricepip";
        string LabelText = "Pip:"+price_pip;
        
string bilgi = ObjectGetString(currChart,namet,OBJPROP_TEXT);
color kuturenk = ObjectGetInteger(currChart,namet,OBJPROP_COLOR);

if ( bilgi != "T" && bilgi != "O" && kuturenk != clrYellowGreen && kuturenk != clrGoldenrod ) return;        
      
        
        if(ObjectFind(currChart,LabelChart) == -1  ) {
        
     //ObjectDelete(currChart,LabelChart);   
     ObjectCreate(currChart,LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChart,OBJPROP_TEXT,LabelText);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_XDISTANCE, 500);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_YDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_XSIZE, 500); 
     
          } else {
               
          ObjectSetString(currChart,LabelChart,OBJPROP_TEXT,LabelText);
     
     
     }
     
     
        
        }
        
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_LABEL ) {
        
        ///Alert("Sil",last_object,"/",rectangle_last_object);
        

                string text = namet;
        int replaced=StringReplace(text," pricepip","");
            //replaced+=StringReplace(text," 1-2","");
        
        //Print("OBJ_Rectangle",text);
        
        int indext = StringFind(namet, "Rectangle ", 0);
     
        if ( indext != -1 ) { 
        
        if ( ObjectFind(currChart,text) == -1 ) {
        
       /// Alert("Sil2",last_object,"/",rectangle_last_object);
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
        last_object=text;

          long currChartx,prevChart=ChartFirst();
   int i=0,limit=50;
   //Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      currChartx=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      
      //Print(currChartx);
      
      //if(currChartx<0) break;          // Have reached the end of the chart list
      if ( prevChart > -1 ) {



///Print(ChartSymbol(currChartx),"/",currChartx);//ObjectFind(prevChart,last_object) != -1 && && ChartSymbol(prevChart) != "USDX-MAR21"

//if ( ObjectFind(ChartID(),last_object) == -1 ) { 
//if ( prevChart!=ChartID() ) { 

ObjectDelete(currChartx,text+" pricepip");
ObjectDelete(currChartx,text);
//ObjectDelete(prevChart,text+" pricepip");
//ObjectDelete(prevChart,text);
///Alert(ChartSymbol(currChartx),"/",currChartx);
ChartRedraw(currChartx);
//ChartRedraw(prevChart);

/*ObjectsDeleteAlls(prevChart,last_object,0,OBJ_TREND);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_HLINE);
ObjectsDeleteAlls(prevChart,last_object,0,OBJ_LABEL);*/
//}
//}
    
}    
    
      prevChart=currChartx;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter    
    
}
/////////////////////////////////////////////////////////////////////////////            

       
        //Print("Sil",text+" "+315);xx
       
        ObjectDelete(currChart,text+" pricepip");//              
        ChartRedraw(currChart);
        }
             
        }
        
        
        
        
        }
        /////////////////////////////////////


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
        
        
///////////////////////////////////////////////
// Symbol Bekleyen Emir
///////////////////////////////////////////////
int OrderCommetbs(string cmt,string sym){

int com = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

  
   if ( type == OP_BUYLIMIT || type == OP_BUYSTOP || type == OP_SELLLIMIT || type == OP_SELLSTOP ) {
   
int index=StringFind(OrderComment(), cmt, 0);

if(index!=-1 && (OrderSymbol() == sym || sym == "*") ){com++;};
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
 
 }
 }
return com;
};
        
        
        

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// BEKLEYEN EMİRLERİ KAPAT - ClosePendingTrades
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void ClosePendingTradesCommentSym(string cmt,string sym)
 {
 
 /*
   string text="The quick brown fox jumped over the lazy dog.";
  int replaced=StringReplace(text,"quick","slow");
  replaced+=StringReplace(text,"brown","black");
  replaced+=StringReplace(text,"fox","bear");
  Print("Replaced: ", replaced,". Result=",text);
  */
  
  //    |sadece|   cmt == OrderComment()
  //        *  hepsi
  //    indexof
  //    Boş Arama için || olucak ( aramayı daraltma )
  //   veya
  //  (string sym,string src,string wrd)   // arama için src  sabit için wrd sembol için sym // arama da * hepsi 
  

     
 
   int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
    
  int index=-1;  
  if (cmt != ""){ 
  index = StringFind(OrderComment(), cmt, 0); // wilcard arama
  }
  //if(index!=-1 ) 
    
  ///string dcmt="";  
    
  int dindex = StringFind(OrderComment(), "|", 0); // direk arama // sadece o
  if(dindex!=-1 ) { int dcmt = StringReplace(cmt,"|",""); }   
  
    
    
    if ( sym==OrderSymbol() && ( cmt=="*" || ( cmt==OrderComment() && dindex!=-1 ) || index!=-1)) {
    
    if ( OrderType() == OP_SELLSTOP || OrderType() ==  OP_SELLLIMIT || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT ) {
     OrderDelete( OrderTicket());
    }
    
}
}

 
 }
               
               
               
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Gizle Goster
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
void GizleGoster(string obje_listesi) {



long cid=0;
cid = ChartID();

Print(cid,"/",OBJECTHIDE);

     /*if ( ObjectGetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT) == "SHOW" ) {
     OBJECTHIDE=true;//ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"HIDE");
     Print("Gizle");
     //ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"HIDE");
     } else {
     Print("Goster");
     OBJECTHIDE=false;
     //ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"SHOW");     
     //if ( ObjectGetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT) == "HIDE" ) OBJECTHIDE=false;//ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"SHOW");
     }
     */
/*
   //--- The number of windows on the chart (at least one main window is always present) 
   int windows=(int)ChartGetInteger(cid,CHART_WINDOWS_TOTAL); 
   //--- Check all windows 
   for(int w=0;w<windows;w++) 
     { 
      //--- the number of indicators in this window/subwindow 
      int total=ChartIndicatorsTotal(cid,w); 
      //--- Go through all indicators in the window 
      for(int i=0;i<total;i++) 
        { 
         //--- get the short name of an indicator 
         string name=ChartIndicatorName(cid,w,i);
         

Print(name);   

int indexof = StringFind(name,"yay", 0);

     if ( indexof != -1 ) ChartIndicatorDelete(cid,w,name); 
     
     //IndicatorSetInteger

//if ( OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
//if ( !OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );


         
        } 
     }
     
     */

/*
       int obj_totali=ChartIndicatorsTotal(cid,0);
  string namei;
  for(int i=0;i<obj_totali;i++)
    {
     namei = ChartIndicatorName(cid,i,0);
     
     Print(i," indicator - ",namei);
    
     
if ( OBJECTHIDE ) ObjectSetInteger(cid,namei, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
if ( !OBJECTHIDE ) ObjectSetInteger(cid,namei, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );
     
     
     }*/
  

//Print(chart_active); 
 
       int obj_total=ObjectsTotal(cid);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(cid,i);
     //Print(i," object - ",name);





/*int OBJ_PERIOD

if ( Period() == PERIOD_M5 ) OBJ_PERIOD=OBJ_PERIOD_M5;
if ( Period() == PERIOD_M15 ) OBJ_PERIOD=OBJ_PERIOD_M15;
if ( Period() == PERIOD_M30 ) OBJ_PERIOD=OBJ_PERIOD_M30;
if ( Period() == PERIOD_H1 ) OBJ_PERIOD=OBJ_PERIOD_H1;*/

int indexof = StringFind(obje_listesi,name, 0);

int fe4 = StringFind(name,"FE 4", 0);
int fe35 = StringFind(name,"FE 3.5", 0);
int fe30 = StringFind(name,"FE 3.0", 0);

int cizgi = StringFind(name,"Cizgi", 0);
int kare = StringFind(name,"Kare", 0);
int aci = StringFind(name,"Aci", 0);
int genislik = StringFind(name,"Genislik", 0);

if ( sekil ) {

if ( cizgi != -1 || kare != -1 || aci != -1 || genislik != -1) {
if ( OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
if ( !OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );
}

} else {

if ( fe4 != -1 || fe35 != -1 || fe30 != -1 ) continue;

//if ( indexof != -1 ) continue;
//if(ObjectType(name)!=OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_FIBO ) continue;
if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_RECTANGLE ) continue;

if ( OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
if ( !OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );

}


    }




}
               
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////               
               
void SekilCiz(double cizgi_prc1,double cizgi_prc2,int cizgi_shift1,int cizgi_shift2,string cizgi_name,string cizgi_namet,int cizgi_obje, color cizgi_renk) {

string namet=cizgi_namet;
string name = namet + cizgi_name;

if ( sekil == false ) return;

if ( cizgi_shift1 <= 0 ) ObjectDelete(name);
if ( cizgi_shift2 <= 0 ) ObjectDelete(name);

//Print(cizgi_shift1,"/",cizgi_shift2);

if ( cizgi_shift1 <= 1 ) return;
if ( cizgi_shift2 <= 1 ) return;

//TrendShift
//TrendTime

//if ( Time[cizgi_shift1] > Time[1] || Time[cizgi_shift2] > Time[1] ) return;

//if ( TrendTime + cizgi_shift1*PeriodSeconds() >= TimeCurrent() ) return;
//if ( TrendTime + cizgi_shift2*PeriodSeconds() >= TimeCurrent() ) return;



///datetime zaman1 = TrendTime+(MathAbs(cizgi_shift1)*PeriodSeconds());
///datetime zaman2 = TrendTime+(MathAbs(cizgi_shift2)*PeriodSeconds());


//cizgi_shift1=cizgi_shift1-formasyon_alani_shift;
//cizgi_shift2=cizgi_shift2-formasyon_alani_shift;

         
         
         
         
         ObjectDelete(0,name);
         
         //if ( cizgi_shift1 <= 1 && cizgi_shift2 <= 1 ) {
         ObjectCreate(0,name, cizgi_obje, 0, Time[cizgi_shift1], cizgi_prc1,Time[cizgi_shift2],cizgi_prc2);       
        // } else {
         ///ObjectCreate(0,name, cizgi_obje, 0, zaman1, cizgi_prc1,zaman2,cizgi_prc2);       
         //}
                           
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, cizgi_renk );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,cizgi_name);  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);
         if(ObjectGetInteger(currChart,name,OBJPROP_TYPE) == OBJ_RECTANGLE ) {ObjectSetInteger(0,name,OBJPROP_BACK,true);ObjectSetInteger(0,name,OBJPROP_FILL,true);} 
    
    if ( cizgi_renk == clrWhite ) ObjectSetInteger(0,name,OBJPROP_WIDTH,1);


}  


////////////////////////////////////////////////////////////////////////////////////////////////////////////
void UsdIndex(string sparam) {

string bilgi = ObjectGetString(currChart,sparam,OBJPROP_TEXT);
color kuturenk = ObjectGetInteger(currChart,sparam,OBJPROP_COLOR);

if ( bilgi != "T" && bilgi != "O" && kuturenk != clrYellowGreen && kuturenk != clrGoldenrod ) return;

///if ( kuturenk == clrYellowGreen && last_object == "" ) {Alert("Objeyi Seç Trend Çizgisi");return;}


long currChart=ChartID();

///////////////////////////////////////////////////////////////////////////////////////////////

          
          string namet=sparam;
        ObjectSetInteger(currChart,namet,OBJPROP_SELECTED,true);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
       datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
       datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
       
       double price_fark = MathAbs(price1-price2)/MarketInfo(Symbol(),MODE_POINT);

          
          //if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_RECTANGLE && Symbol() == "USDINDEXFUT" ) {
          if(//!Pull_Back && 
          ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_RECTANGLE ) {
          
          //Alert("Evet",symbolfind("EURUSD"));
          

       
       
       
       
       if ( bilgi == "T" || kuturenk == clrYellowGreen ) {//Alert(bilgi);
       
       /*prc4236
       prc40
       prc3236*/
       
       //Alert(prc4236,"/",prc40,"/",prc3236,"/",fiboset_price1,fiboset_price2);
       
       if ( fiboset_price1 < fiboset_price2 ) {
       

      //if(ObjectFind(ChartID(),namet + " TASMA T40") == -1  ) {
      
      //Alert("Yok",prevChart);
      string tasma = fiboset_name + " TASMA T40"; 
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc40,time2,prc40+MathAbs(price1-price2));
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrDarkGreen);  
           
      tasma = fiboset_name + " TASMA T4236"; 
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc4236,time2,prc4236+MathAbs(price1-price2));
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrGreen);       
      
      tasma = fiboset_name + " TASMA T3236"; 
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc3236,time2,prc3236+MathAbs(price1-price2));  
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrLimeGreen);        
      
       }
       
       if ( fiboset_price2 < fiboset_price1 ) {

      string tasma = fiboset_name + " TASMA T40"; 
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc40,time2,prc40-MathAbs(price2-price1));
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrDarkGreen);       

      tasma = fiboset_name + " TASMA T4236"; 
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc4236,time2,prc4236-MathAbs(price2-price1));
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrGreen);       

      tasma = fiboset_name + " TASMA T3236";
      ObjectDelete(ChartID(),tasma);
      ObjectCreate(ChartID(),tasma, OBJ_RECTANGLE,0,time1,prc3236,time2,prc3236-MathAbs(price2-price1));  
      ObjectSetInteger(ChartID(),tasma, OBJPROP_COLOR, clrLimeGreen);       
       
       
       //}
       
       }
       
              
       return;
       }
       }

         if(//!Pull_Back && 
          ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_RECTANGLE && Symbol() == "USDX-MAR21" && (bilgi == "B" || kuturenk == clrGoldenrod) ) {       
       
       
       //int price_pip = price_fark * 13.543; 
       int price_pip = price_fark * 1.3543; 
       
        //Alert("Dikdörtgen",price1,"/",price2,"=",price_fark," / pip=",price_pip);
        //Alert("Dikdörtgen",price1,"/",price2,"=",price_fark," / pip=",price_pip);
        
        /*ObjectDelete(currChart,namet+"l");
        ObjectCreate(currChart,namet+"l",OBJ_LABEL,0,0);
        ObjectSetString(currChart,namet+"l",OBJPROP_TEXT,"pip"+price_pip);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_COLOR,clrWhite);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_FONTSIZE,30);
        ObjectSetInteger(currChart,namet+"l",OBJPROP_CORNER,CORNER_RIGHT_UPPER);*/
        
        //string LabelChart = "PricePipUSINDEX";//namet+"pricepip";
        string LabelChart = namet+" pricepip";
        string LabelText = "Pip:"+price_pip + "/" + DoubleToString(price_fark,2);
        
        if(ObjectFind(currChart,LabelChart) == -1  ) {
        
     //ObjectDelete(currChart,LabelChart);   
     ObjectCreate(currChart,LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChart,OBJPROP_TEXT,LabelText);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_XDISTANCE, 500);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_YDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChart, OBJPROP_XSIZE, 500); 
     
          } else {
               
          ObjectSetString(currChart,LabelChart,OBJPROP_TEXT,LabelText);
     
     
     }
     
     
          long currChartx,prevChart=ChartFirst();
   int i=0,limit=50;
   //Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      currChartx=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      
      //Print(currChartx);
      
      //if(currChartx<0) break;          // Have reached the end of the chart list
      if ( prevChart > -1 && currChartx < ChartID() // ***** en son charta çiziyor.
      ) { 
      
      if ( ChartSymbol(prevChart) == symbolfind("EURUSD") || ChartSymbol(prevChart) == symbolfind("GOLD")// || ChartSymbol(prevChart) == symbolfind("XAUUSDMini") || ChartSymbol(prevChart) == symbolfind("XAUUSD")
      ) {
      
      if ( ChartSymbol(prevChart) == symbolfind("EURUSD") ) price_pip = price_fark * 1.3543; 
      //if ( ChartSymbol(prevChart) == symbolfind("EURUSD") ) price_pip = price_fark * 13.543;
      if ( ChartSymbol(prevChart) == symbolfind("GBPUSD") )  price_pip = price_fark * 13.343; 
      if ( ChartSymbol(prevChart) == symbolfind("XAUUSDMini") )  price_pip = price_fark * 25.9636; 
      if ( ChartSymbol(prevChart) == symbolfind("XAUUSD") )  price_pip = price_fark * 25.9636;
      if ( ChartSymbol(prevChart) == symbolfind("GOLD") )  price_pip = price_fark * 5.13;
      
      
      //Print(i,ChartSymbol(prevChart)," ID =",prevChart);
      
      if(ObjectFind(prevChart,namet) == -1  ) {
      
      //Alert("Yok",prevChart);
      
      ObjectCreate(prevChart,namet, OBJ_RECTANGLE,0,time1,MarketInfo(ChartSymbol(prevChart),MODE_ASK),time2,MarketInfo(ChartSymbol(prevChart),MODE_ASK)+price_pip*MarketInfo(ChartSymbol(prevChart),MODE_POINT));
      
     ObjectCreate(prevChart,LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(prevChart,LabelChart,OBJPROP_TEXT,LabelText);
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(prevChart,LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_XDISTANCE, 500);
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_YDISTANCE, 10);
     ObjectSetInteger(prevChart,LabelChart, OBJPROP_XSIZE, 500); 
     
      
      
      } else {
      
      int time1Shift=iBarShift(ChartSymbol(prevChart),ChartPeriod(prevChart),time1);
      int time2Shift=iBarShift(ChartSymbol(prevChart),ChartPeriod(prevChart),time2);
      
      //Print(time1Shift);
      
      double TimePrice,TimePrices;
      
      if ( price1 > price2 ) {
      TimePrice=iOpen(ChartSymbol(prevChart),ChartPeriod(prevChart),time1Shift);
      //TimePrice=MarketInfo(ChartSymbol(prevChart),MODE_ASK);
      TimePrices=TimePrice-price_pip*MarketInfo(ChartSymbol(prevChart),MODE_POINT);      
      }
      
      if ( price1 < price2 ) {
      TimePrice=iClose(ChartSymbol(prevChart),ChartPeriod(prevChart),time1Shift);
      TimePrice=MarketInfo(ChartSymbol(prevChart),MODE_ASK);
      TimePrices=TimePrice+price_pip*MarketInfo(ChartSymbol(prevChart),MODE_POINT);      
      }      
      
      double time1Prices=MarketInfo(ChartSymbol(prevChart),MODE_ASK);
      
      ObjectMove(prevChart,namet,0,time1,TimePrice);
      ObjectMove(prevChart,namet,1,time2,TimePrices);
      ObjectSetString(prevChart,LabelChart,OBJPROP_TEXT,LabelText);
      
      }
      
      
      }
      
      }

      prevChart=currChartx;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
     }
     
     
     
     
        
        }
//////////////////////////////////////////////////////////////////////////////////////////

}
             

///////////////////////////////////////////////////////////////////////////////////////////////////////////

void OzhFormasyon(string sparam) {

   string namet=sparam;
   long currChart=ChartID();
   
   
             int indexofibo = StringFind(namet,"Fibo", 0);         
             int indexorderline = StringFind(namet,"#", 0);         
             int indexofcizgi = StringFind(namet,"Cizgi", 0);         
             int indexofgen = StringFind(namet,"Genislik", 0);         
             int indexoftrend = StringFind(namet,"Trendline", 0); 
             int indexofmouse = StringFind(namet,"MouseLine", 0); 
             
             

    if( (  (ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_RECTANGLE) && fiboset && indexofibo == -1 && indexorderline == -1 && indexofcizgi==-1 && indexofgen == -1 && indexofmouse == -1 )
    
    //|| (indexoftrend != -1 && fiboset && indexofibo == -1 && indexorderline == -1 && indexofcizgi==-1 && indexofgen == -1) 
    
    ) {
    
    
    
            int Fark;
        double tepe_fiyats,dip_fiyats;
        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        
        TrendTime=time2;
        TrendShift = shift2;
        
        
        int shiftd1=iBarShift(NULL,PERIOD_D1,time1);
        int shiftd2=iBarShift(NULL,PERIOD_D1,time2);
        
        fiboset_price1=price1;
        fiboset_price2=price2;
        fiboset_name = namet;
        
        
        bool pivot = false;
        
        if ( pivot ) {

        for(int pv=shiftd1;pv<=shiftd1+10;pv++){
        
        double pivot = (iHigh(NULL,PERIOD_D1,pv) + iLow(NULL,PERIOD_D1,pv) + iClose(NULL,PERIOD_D1,pv))/3;// Standard Pivot
        
        //Print(pv,"/",pivot);
        
        

         string name=namet + " FE PIVOT"+pv;
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,iTime(NULL,PERIOD_D1,pv),pivot,Time[0],pivot);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, iTime(NULL,PERIOD_D1,pv)+PeriodSeconds()*15, pivot);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT S"+pv);  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
                 
        
        
        
        }
        
        
                
        
        
        //Alert("Selam",TimeDay(time1),"/",shiftd1,"-",TimeDay(time2),"/",shiftd2);
        
        if ( TimeDay(time1) == TimeDay(time2) ) {
       
        //Alert("Günler Eşit");
        
        //double p = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
        
        double p = (iHigh(NULL,PERIOD_D1,shiftd1-1) + iLow(NULL,PERIOD_D1,shiftd1-1) + iClose(NULL,PERIOD_D1,shiftd1-1))/3;// Standard Pivot
        double p2 = (iHigh(NULL,PERIOD_D1,shiftd1-2) + iLow(NULL,PERIOD_D1,shiftd1-2) + iClose(NULL,PERIOD_D1,shiftd1-2))/3;// Standard Pivot
        
        //Alert(p);
        
         string name=namet + " FE PIVOT";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,p,Time[0],p);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, p);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);  
         

         name=namet + " FE PIVOT2";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,p2,Time[0],p2);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, p2);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT 2");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);   
         
                          

        }
        

        if ( TimeDay(time1) != TimeDay(time2) ) {
        
        //Alert("Günler Farklı");
        
        //double p = (yesterday_high + yesterday_low + yesterday_close)/3;// Standard Pivot
        
        double p = (iHigh(NULL,PERIOD_D1,shiftd1-1) + iLow(NULL,PERIOD_D1,shiftd1-1) + iClose(NULL,PERIOD_D1,shiftd1-1))/3;// Standard Pivot
        double p2 = (iHigh(NULL,PERIOD_D1,shiftd2-1) + iLow(NULL,PERIOD_D1,shiftd2-1) + iClose(NULL,PERIOD_D1,shiftd2-1))/3;// Standard Pivot
        double p3 = (iHigh(NULL,PERIOD_D1,shiftd2) + iLow(NULL,PERIOD_D1,shiftd2) + iClose(NULL,PERIOD_D1,shiftd2))/3;// Standard Pivot
        
        //Alert(p);
        
         string name=namet + " FE PIVOT";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,p,Time[0],p);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, p);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);     
         

         name=namet + " FE PIVOT2";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,p2,Time[0],p2);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, p2);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT 2");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);    
         

         name=namet + " FE PIVOT 3";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,p3,Time[0],p3);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, p3);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"PIVOT 3");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         
                             

        }
        
        
        }       
        
        
        
        
        
        
        
        
        
        if ( price1 > price2 ) {
        
        
        
        tepe_fiyats=High[shift1];
        dip_fiyats=Low[shift2];
        
        //Alert("Selam");

   double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="u886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level886;
  levels="u886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*2),Time[0],high_price+(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);
     
     
     
     
           
        
        if ( ObjectGetInteger(ChartID(),namet,OBJPROP_TYPE) == OBJ_TREND ) {
        ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        } else {
        
        tepe_fiyats=price1;
        dip_fiyats=price2;
        
        }
        
        
        
        
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        ObjectMove(currChart,namet,2,time3,price2+(((price1-price2)/100)*61.8));
        int Fark=(((price1-price2)*4.5)-(((price1-price2)/100)*61.8))/Point;
        Comment(Fark);
        
        string name;

        fiboset_tepe=tepe_fiyats;
        fiboset_dip=dip_fiyats;
        
        int fiboset_Fark=(tepe_fiyats-dip_fiyats)/Point;
        //Alert(shift2+1);
        double dip_fiyats_onceki=Low[shift2+1];
        double dip_fiyats_sonraki=Low[shift2-1];
        //string dib_bilgi = dip_fiyats_onceki+" "+dip_fiyats_sonraki;
        string dib_bilgi = int(MathAbs(dip_fiyats_onceki-dip_fiyats)/Point)+"/"+int(MathAbs(dip_fiyats_sonraki-dip_fiyats)/Point);
        
        
        
        double Pips_Price_valued = PipPrice(Symbol(),0,fiboset_Fark,1);
         name = namet + " Pip Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*2, tepe_fiyats+50*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,dib_bilgi+" "+fiboset_Fark+" pips "+DoubleToString(Pips_Price_valued,2)+"$"+" High:"+DoubleToString(tepe_fiyats,MarketInfo(Symbol(),MODE_DIGITS))+" Low:"+DoubleToString(dip_fiyats,MarketInfo(Symbol(),MODE_DIGITS)));  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
                



        Fark=(((tepe_fiyats-dip_fiyats)*1.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
         
         prcsl=tepe_fiyats+200*Point;
         prices[0]=prcsl;
         pricen[0]="SL 200";

         name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats+200*Point,Time[0],tepe_fiyats+200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         prc618 = tepe_fiyats-Fark*Point;
         prices[1]=tepe_fiyats-Fark*Point;
         pricen[1]="61.8";        
         name=namet + " FE 61.8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 61.8");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*2)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
         prc100 = tepe_fiyats-Fark*Point;
         prices[2]=tepe_fiyats-Fark*Point;
         pricen[2]="100";          
         name=namet + " FE 100";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 100");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         

        Fark=(((tepe_fiyats-dip_fiyats)*2.309)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc1309 = tepe_fiyats-Fark*Point;
         prices[3]=tepe_fiyats-Fark*Point;
         pricen[3]="1.309";          
         name=namet + " FE 1.309";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.309");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
                  

        Fark=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        
         prc1618 = tepe_fiyats-Fark*Point;        
         prices[4]=tepe_fiyats-Fark*Point;
         pricen[4]="1.168";  
                 
         name=namet + " FE 1.168";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = namet + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
                 

        Fark=(((tepe_fiyats-dip_fiyats)*2.707)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        
        prc17070 = tepe_fiyats-Fark*Point;        
         prices[5]=tepe_fiyats-Fark*Point;
         pricen[5]="1.7070";           
         name=namet + " FE 1.7070";         
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.7070");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         

         ////////////////////////////////////////////////////////////////////////////////////////////////
         
                  

        Fark=(((tepe_fiyats-dip_fiyats)*2.764)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        
        prc17640 = tepe_fiyats-Fark*Point;        
         prices[6]=tepe_fiyats-Fark*Point;
         pricen[6]="1.7640";           
         name=namet + " FE 1.7640";         
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = namet + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.7640");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
                  
         
         
         
         
         /*
         name = namet + " Aci";
         ObjectDelete(0,name);
         //ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         ObjectSetDouble(0,name,OBJPROP_ANGLE,315);
       
         datetime AngleTime = ObjectGetTimeByValue(0,name,tepe_fiyats-Fark*Point,0);
        ObjectSetInteger(0,name,OBJPROP_RAY,false);
        ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point);     
        
         

                         
         
           // if ( ObjectGetDouble(0,name,OBJPROP_ANGLE) == 0.0 ) Sleep(100);
           // ChartRedraw(0);
       



        //if ( ObjectGetDouble(0,name,OBJPROP_ANGLE) == 0.0 ) Sleep(100); Sleep(500);
        //datetime AngleTimes = ObjectGetTimeByValue(0,name,tepe_fiyats-Fark*Point,0);
        //Comment("AngleTime:",AngleTime,"Time:",angle_time2);
        //Alert("Selam");
  

  /* if ( ObjectGetDouble(0,name,OBJPROP_ANGLE) == 0.0 ) Sleep(100);
   ChartRedraw();
   double angle_price1=ObjectGetDouble(0,name,OBJPROP_PRICE,0);    // and retrieve the angle   
   double angle_price2=ObjectGetDouble(0,name,OBJPROP_PRICE,1);    // and retrieve the angle
   datetime angle_time1=ObjectGetInteger(0,name,OBJPROP_TIME,0);    // and retrieve the angle
   datetime angle_time2=ObjectGetInteger(0,name,OBJPROP_TIME,1);    // and retrieve the angle
      
   double angle_price11=ObjectGetDouble(0,name,OBJPROP_PRICE1);    // and retrieve the angle   
   double angle_price22=ObjectGetDouble(0,name,OBJPROP_PRICE2);    // and retrieve the angle
   datetime angle_time11=ObjectGetInteger(0,name,OBJPROP_TIME1);    // and retrieve the angle
   datetime angle_time22=ObjectGetInteger(0,name,OBJPROP_TIME2);    // and retrieve the angle   
   
          Sleep(1000);
          ChartRedraw();*/
          
                  //Alert(angle_time2,"/",angle_time22);
                  //Alert(angle_time2,"/",angle_time22);
                  
                 // Alert(angle_time2);
  /*
         if ( angle_value != 0 ) {}*/     
         //Alert("cizgi");
      /*   name = namet + " Cizgi 1.618";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrRed );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
           
         
        
        
        /*ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point);*/
        

         /*name = namet + " Kare 1618";
         //Alert(name);
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_RECTANGLE, 0, time1+((time1-time2)*6)-3*PeriodSeconds(), tepe_fiyats-(Fark-20)*Point,time1+((time1-time2)*6)+3*PeriodSeconds(),(tepe_fiyats-(Fark+50)*Point));                         
         //ObjectCreate(0,name, OBJ_RECTANGLE, 0, AngleTime,tepe_fiyats-Fark*Point,AngleTime-(time1-time2),(tepe_fiyats-(Fark+50)*Point));                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen ); */
         
         //SekilCiz(tepe_fiyats-(Fark-20)*Point,tepe_fiyats-(Fark+50)*Point,shift1-35,shift1-37," Kare 1618",namet,OBJ_RECTANGLE,clrGreen);
         
         
         
         
/*ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point);*/
        /* name = namet + " Cizgi 1.618-100";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*6), tepe_fiyats-Fark*Point,time1+((time1-time2)*8),prc100);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen );
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
         

 
/*
         name = namet + " Kare 168";
         //Alert(name);
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_RECTANGLE, 0, time1+((time1-time2)*6)-3*PeriodSeconds(), tepe_fiyats-(Fark-20)*Point,time1+((time1-time2)*6)+3*PeriodSeconds(),(tepe_fiyats-(Fark+50)*Point));                         
         //ObjectCreate(0,name, OBJ_RECTANGLE, 0, AngleTime,tepe_fiyats-Fark*Point,AngleTime-(time1-time2),(tepe_fiyats-(Fark+50)*Point));                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen ); 
         ChartRedraw();*/
        
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        double Farks=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc20 = tepe_fiyats-Fark*Point;
         prices[7]=tepe_fiyats-Fark*Point;
         pricen[7]="2.0";           
         name=namet + " FE 2.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.0 / 3.5 Dönüş Yeri");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         
/*
         name = namet + " Cizgi 20";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
           
                 
        
        
        
        /*ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point);*/
        
/*
         name = namet + " Kare 20";
         //Alert(name);
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_RECTANGLE, 0, time1+((time1-time2)*6)-3*PeriodSeconds(), tepe_fiyats-(Fark-20)*Point,time1+((time1-time2)*6)+3*PeriodSeconds(),(tepe_fiyats-(Fark+50)*Point));                         
         //ObjectCreate(0,name, OBJ_RECTANGLE, 0, AngleTime,tepe_fiyats-Fark*Point,AngleTime-(time1-time2),(tepe_fiyats-(Fark+50)*Point));                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen ); */
         

        //SekilCiz(tepe_fiyats-(Fark-20)*Point,(tepe_fiyats-(Fark+50)*Point),shift1-35,shift1-37," Kare 20",namet,OBJ_RECTANGLE,clrGreen);

/*

         name = namet + " Cizgi 20-100";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*6), tepe_fiyats-Fark*Point,time1+((time1-time2)*8),prc100);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen );
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
         

         
                           
         
         
         /*name = namet + " Aci 2.0";
         ObjectDelete(0,name);
         //ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         ObjectSetDouble(0,name,OBJPROP_ANGLE,300);
       
         AngleTime = ObjectGetTimeByValue(0,name,tepe_fiyats-Fark*Point,0);
        ObjectSetInteger(0,name,OBJPROP_RAY,false);
        ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point); */




         ////////////////////////////////////////////////////////////////////////////////////////////////
         
        Fark=(((tepe_fiyats-dip_fiyats)*3.25)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc225 = tepe_fiyats-Fark*Point;
        
         prices[8]=tepe_fiyats-Fark*Point;
         pricen[8]="2.25";   
                 
         name=namet + " FE 2.25";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkGreen); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.25");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
                 
                 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
        Fark=(((tepe_fiyats-dip_fiyats)*3.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc25 = tepe_fiyats-Fark*Point;
        
         prices[9]=tepe_fiyats-Fark*Point;
         pricen[9]="2.5";   
                 
         name=namet + " FE 2.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
        Fark=(((tepe_fiyats-dip_fiyats)*3.75)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc275 = tepe_fiyats-Fark*Point;

         prices[10]=tepe_fiyats-Fark*Point;
         pricen[10]="2.75";           
        
         name=namet + " FE 2.75";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.75");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         
         
         
         
/*
         name = namet + " Cizgi 25";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/



/*
         name = namet + " Kare 25";
         //Alert(name);
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_RECTANGLE, 0, time1+((time1-time2)*6)-3*PeriodSeconds(), tepe_fiyats-(Fark-20)*Point,time1+((time1-time2)*6)+3*PeriodSeconds(),(tepe_fiyats-(Fark+50)*Point));                         
         //ObjectCreate(0,name, OBJ_RECTANGLE, 0, AngleTime,tepe_fiyats-Fark*Point,AngleTime-(time1-time2),(tepe_fiyats-(Fark+50)*Point));                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen ); */

//SekilCiz(tepe_fiyats-(Fark-20)*Point,(tepe_fiyats-(Fark+50)*Point),shift1-35,shift1-37," Kare 25",namet,OBJ_RECTANGLE,clrGreen);
//SekilCiz(tepe_fiyats-(Fark-20)*Point,(tepe_fiyats-(Fark+50)*Point),shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);

              
/*
         name = namet + " Cizgi 25-100";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*6), tepe_fiyats-Fark*Point,time1+((time1-time2)*8),prc100);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrGreen );
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
         
                           
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
                  
        
        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc30 = tepe_fiyats-Fark*Point;
        
        //Alert("Selam");
        ENTRY3=tepe_fiyats-Fark*Point;        
        
         prices[11]=tepe_fiyats-Fark*Point;
         pricen[11]="3.0";           
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.0");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         

        /* name = namet + " Aci 3.0";
         ObjectDelete(0,name);
         //ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, prc25);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrRed );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         ObjectSetDouble(0,name,OBJPROP_ANGLE,280);
       
         AngleTime = ObjectGetTimeByValue(0,name,tepe_fiyats-Fark*Point,0);
        ObjectSetInteger(0,name,OBJPROP_RAY,false);
        ObjectMove(0,name,1,AngleTime,tepe_fiyats-Fark*Point);*/ 
        
////////////////////////////////////////////////////////////////////////////////////////////////                 
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc35 = tepe_fiyats-Fark*Point;
        ENTRY35=tepe_fiyats-Fark*Point;    

         prices[13]=tepe_fiyats-Fark*Point;
         pricen[13]="3.5";   
         
         name=namet + " FE 3.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);     
         
         /*
         name = namet + " Cizgi 35";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*8), prc100,time1+((time1-time2)*11),prc30);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
         
         

         
         
         
/*
         name = namet + " Cizgi 3-25";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*11), prc30,time1+((time1-time2)*15),prc25);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
                  
                         



        Fark=(((tepe_fiyats-dip_fiyats)*4.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc3618 = tepe_fiyats-Fark*Point;
        //ENTRY35=tepe_fiyats-Fark*Point;    

         prices[14]=tepe_fiyats-Fark*Point;
         pricen[14]="3.618";   
         
         name=namet + " FE 3.618";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         
                  

        Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);     
        prc40 = tepe_fiyats-Fark*Point;
        ENTRY4=tepe_fiyats-Fark*Point;
         
         prices[15]=tepe_fiyats-Fark*Point;
         pricen[15]="4.0";                
         
         name=namet + " FE 4";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " FE 4 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1);          
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         /*name=namet + " FE 4 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+8*PeriodSeconds(),tepe_fiyats-Fark*Point,time1+11*PeriodSeconds(),((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);*/              

         


        /* name = namet + " Cizgi 25-40";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1+((time1-time2)*15), prc25,time1+((time1-time2)*17),prc40);                         
         //ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,315);*/
         
         


        Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);     
        prc4236 = tepe_fiyats-Fark*Point;
        //ENTRY4=tepe_fiyats-Fark*Point;
         
         //prices[16]=tepe_fiyats-Fark*Point;
         //pricen[16]="4.236";   

         prices[16]=tepe_fiyats-Fark*Point;
         pricen[16]="4.236";                         
         
         name=namet + " FE 4.236";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 

         name=namet + " FE 4.236 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         

         name=namet + " FE 4 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,prc4236,Time[Bars-1],prc40);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
                  
                  
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.236");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
         /*name=namet + " FE 4.236 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+5*PeriodSeconds(),tepe_fiyats-Fark*Point,time1+8*PeriodSeconds(),((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);   */           
         
         name=namet + " FE 3.236 (4.236) TRUE";
         prc3236=((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats));
         
         prices[12]=tepe_fiyats-Fark*Point;
         pricen[12]="3.236";   
         
         
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)),Time[0],((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,"3.236 :"+int((tepe_fiyats-dip_fiyats)/Point)+" Pips");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);    

                  

        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc50 = tepe_fiyats-Fark*Point;
        
         SL5 = tepe_fiyats-Fark*Point;   
         
         prices[18]=tepe_fiyats-Fark*Point;
         pricen[18]="5.0";                
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         

         name=namet + " FE 5 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1);          
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         



        Fark=(((tepe_fiyats-dip_fiyats)*5.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc45 = tepe_fiyats-Fark*Point;
        
         ///SL5 = tepe_fiyats-Fark*Point;   
         
         prices[17]=tepe_fiyats-Fark*Point;
         pricen[17]="4.5";                
         
         name=namet + " FE 4.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkGray); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
  
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382); prc45             
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);   
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*5.736)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc4736 = tepe_fiyats-Fark*Point;
        
         ///SL5 = tepe_fiyats-Fark*Point;    

         prices[18]=tepe_fiyats-Fark*Point;
         pricen[18]="61.8";   
                     
         
         name=namet + " FE 4.736";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrLightGray); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
  
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.736");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);  prc4736            
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);                 
         

         /*name=namet + " FE 5 TRUE";         
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+3*PeriodSeconds(),tepe_fiyats-Fark*Point,time1+5*PeriodSeconds(),((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1); */           
         


        Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50 = tepe_fiyats-Fark*Point;
        prc5236=tepe_fiyats-Fark*Point;
        
         //SL5 = tepe_fiyats-Fark*Point;     

         prices[19]=tepe_fiyats-Fark*Point;
         pricen[19]="6.236";              
         
         name=namet + " FE 5.236";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " FE 5.236 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1);      
         

         name=namet + " FE 5 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,prc5236,Time[Bars-1],prc50);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
   
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5.236");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         


        Fark=(((tepe_fiyats-dip_fiyats)*6.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        //prc50 = tepe_fiyats-Fark*Point;
        prc55=tepe_fiyats-Fark*Point;
        
         //SL5 = tepe_fiyats-Fark*Point;  

         prices[20]=tepe_fiyats-Fark*Point;
         pricen[20]="5.5";                 
         
         name=namet + " FE 5.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         name=namet + " FE 5.5 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1);      
         

         name=namet + " FE 5.5 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,Time[0]+100*PeriodSeconds(),prc55,time1,prc5236);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrCrimson); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
   
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5.5 Stop Bölgesi");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
                  

         /*name=namet + " FE 5.236 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,tepe_fiyats-Fark*Point,time1+3*PeriodSeconds(),((tepe_fiyats-Fark*Point)+(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1); */  
         
         //Alert("Selam");


        Fark=(((tepe_fiyats-dip_fiyats)*7)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         prc60 = tepe_fiyats-Fark*Point;
         SL6 = tepe_fiyats-Fark*Point;
         
         prices[21]=tepe_fiyats-Fark*Point;
         pricen[21]="6.0";   
         
         name=namet + " FE 6";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 6 - STOP LV1");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         

        Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         prc70 = tepe_fiyats-Fark*Point;
         SL7 = tepe_fiyats-Fark*Point;

         prices[22]=tepe_fiyats-Fark*Point;
         pricen[22]="7.0";            
         
         name=namet + " FE 7";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 7 - STOP LV2");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
                  
        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         prc80 = tepe_fiyats-Fark*Point;
         SL8 = tepe_fiyats-Fark*Point;

         prices[23]=tepe_fiyats-Fark*Point;
         pricen[23]="8.0";   
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 8 - STOP LV3");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         



        Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);         
         double prc110 = tepe_fiyats-Fark*Point;
         double SL11 = tepe_fiyats-Fark*Point;

         prices[24]=tepe_fiyats-Fark*Point;
         pricen[24]="11.0";   
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,tepe_fiyats-Fark*Point,Time[0],tepe_fiyats-Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time2+PeriodSeconds()*15, tepe_fiyats-Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 11 - STOP LV3");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 



//Print("Selam");
/*
for (int p=0;p<=24;p++) {
Print(p,"/",pricen[p],"/",prices[p]);
}*/




if ( sekil ) {
         /*name = namet + " Aci";
         ObjectDelete(0,name);
         //ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, tepe_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         ObjectSetDouble(0,name,OBJPROP_ANGLE,315);
       
         datetime AngleTime = ObjectGetTimeByValue(0,name,prc4236,0);
        ObjectSetInteger(0,name,OBJPROP_RAY,false);
        ObjectMove(0,name,1,AngleTime,prc4236); */
        
        
         name = namet + " Genislik";
         //ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+PeriodSeconds()*5,tepe_fiyats);                                 
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");         
         
        }
                          
         

int genisleme_fark = 6;

int genisleme = genisleme_fark+formasyon_alani_shift;

//6
SekilCiz(tepe_fiyats,prc618,shift1,shift1-(6+formasyon_alani_shift)," Cizgi 61.8 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc618,prc618-150*Point,shift1-(6+formasyon_alani_shift),shift1-(9+formasyon_alani_shift)," Cizgi 61.8 Down",namet,OBJ_TREND,clrWhite);  


SekilCiz(prc618,prc100,shift1-(6+formasyon_alani_shift),shift1-(13+formasyon_alani_shift)," Cizgi 61.8-100 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc100,prc618,shift1-(13+formasyon_alani_shift),shift1-(19+formasyon_alani_shift)," Cizgi 100-61.8 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc100,prc1309,shift1-(13+formasyon_alani_shift),shift1-(19+formasyon_alani_shift)," Cizgi 100-1.309 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1309,prc100,shift1-(19+formasyon_alani_shift),shift1-(23+formasyon_alani_shift)," Cizgi 1.309-100 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1309,prc1618,shift1-(19+formasyon_alani_shift),shift1-(25+formasyon_alani_shift)," Cizgi 1.309-1.618 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1618,prc1309,shift1-(25+formasyon_alani_shift),shift1-(27+formasyon_alani_shift)," Cizgi 1.618-1.309 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1618,prc20,shift1-(25+formasyon_alani_shift),shift1-(33+formasyon_alani_shift)," Cizgi 1.618-20 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc1618,shift1-(33+formasyon_alani_shift),shift1-(35+formasyon_alani_shift)," Cizgi 20-1.618 Down",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc100,shift1-(33+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 20-100",namet,OBJ_TREND,clrGreen);
SekilCiz(prc1618,prc100,shift1-(25+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 1.618-100",namet,OBJ_TREND,clrGreen);

SekilCiz(prc20,prc25,shift1-(33+formasyon_alani_shift),shift1-(36+formasyon_alani_shift)," Cizgi 20-25 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc25,prc20,shift1-(36+formasyon_alani_shift),shift1-(39+formasyon_alani_shift)," Cizgi 20-25 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1618-15*Point,prc1618+20*Point,shift1-(24+formasyon_alani_shift),shift1-(26+formasyon_alani_shift)," Kare 1618",namet,OBJ_RECTANGLE,clrRed);
SekilCiz(prc20-15*Point,prc20+20*Point,shift1-(32+formasyon_alani_shift),shift1-(34+formasyon_alani_shift)," Kare 20",namet,OBJ_RECTANGLE,clrRed);
SekilCiz(prc25-15*Point,prc25+20*Point,shift1-(35+formasyon_alani_shift),shift1-(37+formasyon_alani_shift)," Kare 25",namet,OBJ_RECTANGLE,clrRed);
SekilCiz(prc25-15*Point,prc25+20*Point,shift1-(58+formasyon_alani_shift),shift1-(60+formasyon_alani_shift)," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrRed);
SekilCiz(prc40-15*Point,prc40+20*Point,shift1-(62+formasyon_alani_shift),shift1-(64+formasyon_alani_shift)," Kare 40",namet,OBJ_RECTANGLE,clrRed);
SekilCiz(prc35-15*Point,prc35+20*Point,shift1-(60+formasyon_alani_shift),shift1-(62+formasyon_alani_shift)," Kare 35",namet,OBJ_RECTANGLE,clrRed);


SekilCiz(prc100,prc618,shift1-(48+formasyon_alani_shift),shift1-(51+formasyon_alani_shift)," Cizgi 100-61.6",namet,OBJ_TREND,clrGreen);
SekilCiz(prc618,prc100,shift1-(51+formasyon_alani_shift),shift1-(56+formasyon_alani_shift)," Cizgi 61.8-100",namet,OBJ_TREND,clrRed);
//SekilCiz(prc20-20*Point,prc20+50*Point,shift1-35,shift1-37," Kare 20",namet,OBJ_RECTANGLE,clrRed);

//SekilCiz(prc25-20*Point,prc25+50*Point,shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25,prc100,shift1-(36+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 25-100",namet,OBJ_TREND,clrGreen);         
SekilCiz(prc100,prc25,shift1-(48+formasyon_alani_shift),shift1-(53+formasyon_alani_shift)," Cizgi 35",namet,OBJ_TREND,clrRed);
SekilCiz(prc25,prc30,shift1-(53+formasyon_alani_shift),shift1-(56+formasyon_alani_shift)," Cizgi 25-30",namet,OBJ_TREND,clrRed);
SekilCiz(prc30,prc25,shift1-(56+formasyon_alani_shift),shift1-(59+formasyon_alani_shift)," Cizgi 30-25",namet,OBJ_TREND,clrGreen);
SekilCiz(prc25,prc35,shift1-(59+formasyon_alani_shift),shift1-(61+formasyon_alani_shift)," Cizgi 25-35",namet,OBJ_TREND,clrRed);
SekilCiz(prc35,prc40,shift1-(61+formasyon_alani_shift),shift1-(63+formasyon_alani_shift)," Cizgi 35-40",namet,OBJ_TREND,clrRed);
SekilCiz(prc40,prc30,shift1-(63+formasyon_alani_shift),shift1-(66+formasyon_alani_shift)," Cizgi 40-30",namet,OBJ_TREND,clrGreen);
SekilCiz(prc30,prc25,shift1-(66+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 30-25 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc3618,prc30,shift1-(64+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 45-30",namet,OBJ_TREND,clrYellow);
SekilCiz(prc25,prc20,shift1-(69+formasyon_alani_shift),shift1-(73+formasyon_alani_shift)," Cizgi 25-20 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc40,prc4236,shift1-(63+formasyon_alani_shift),shift1-(66+formasyon_alani_shift)," Cizgi 40-4326 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc4236,prc40,shift1-(66+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 4326-40 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc40,prc35,shift1-(69+formasyon_alani_shift),shift1-(71+formasyon_alani_shift)," Cizgi 40-35 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc35,prc25,shift1-(71+formasyon_alani_shift),shift1-(79+formasyon_alani_shift)," Cizgi 35-25 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc25,prc1618,shift1-(79+formasyon_alani_shift),shift1-(86+formasyon_alani_shift)," Cizgi 25-1618 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc1618,prc1309,shift1-(86+formasyon_alani_shift),shift1-(93+formasyon_alani_shift)," Cizgi 1618-1309 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc1309,prc20,shift1-(93+formasyon_alani_shift),shift1-(99+formasyon_alani_shift)," Cizgi 1309-20 DOWN",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618,prc20,shift1-(86+formasyon_alani_shift),shift1-(89+formasyon_alani_shift)," Cizgi 1618-20 DOWN",namet,OBJ_TREND,clrRed);              



/*
SekilCiz(tepe_fiyats,prc1618,shift1,shift1-36," Cizgi 1.618",namet,OBJ_TREND,clrWhite);
SekilCiz(prc1618-20*Point,prc1618+50*Point,shift1-35,shift1-37," Kare 1618",namet,OBJ_RECTANGLE,clrGreen);
         SekilCiz(prc1618,prc100,shift1-36,shift1-48," Cizgi 1.618-100",namet,OBJ_TREND,clrGreen);
         SekilCiz(prc100,prc618,shift1-48,shift1-51," Cizgi 100-61.6",namet,OBJ_TREND,clrGreen);
         SekilCiz(prc618,prc100,shift1-51,shift1-56," Cizgi 61.8-100",namet,OBJ_TREND,clrRed);
                    SekilCiz(tepe_fiyats,prc20,shift1,shift1-36," Cizgi 20",namet,OBJ_TREND,clrWhite);         
         SekilCiz(prc20-20*Point,prc20+50*Point,shift1-35,shift1-37," Kare 20",namet,OBJ_RECTANGLE,clrGreen);
         SekilCiz(prc20,prc100,shift1-36,shift1-48," Cizgi 20-100",namet,OBJ_TREND,clrGreen);
SekilCiz(tepe_fiyats,prc25,shift1,shift1-36," Cizgi 25",namet,OBJ_TREND,clrWhite);         

SekilCiz(prc25-20*Point,prc25+50*Point,shift1-35,shift1-37," Kare 25",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25-20*Point,prc25+50*Point,shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);
    SekilCiz(prc25,prc100,shift1-36,shift1-48," Cizgi 25-100",namet,OBJ_TREND,clrGreen);         
         SekilCiz(prc100,prc25,shift1-48,shift1-53," Cizgi 35",namet,OBJ_TREND,clrRed);
         SekilCiz(prc25,prc30,shift1-53,shift1-56," Cizgi 25-30",namet,OBJ_TREND,clrRed);
         SekilCiz(prc30,prc25,shift1-56,shift1-59," Cizgi 30-25",namet,OBJ_TREND,clrGreen);
         SekilCiz(prc25,prc35,shift1-59,shift1-61," Cizgi 25-35",namet,OBJ_TREND,clrRed);

         SekilCiz(prc35,prc40,shift1-61,shift1-63," Cizgi 35-40",namet,OBJ_TREND,clrRed);
         SekilCiz(prc40,prc30,shift1-63,shift1-66," Cizgi 40-30",namet,OBJ_TREND,clrGreen);
         SekilCiz(prc30,prc25,shift1-66,shift1-69," Cizgi 30-25 UP",namet,OBJ_TREND,clrGreen);
         SekilCiz(prc3618,prc30,shift1-64,shift1-69," Cizgi 45-30",namet,OBJ_TREND,clrYellow);
         
         
         SekilCiz(prc25,prc20,shift1-69,shift1-73," Cizgi 25-20 UP",namet,OBJ_TREND,clrGreen);                  
                  SekilCiz(prc40,prc4236,shift1-63,shift1-66," Cizgi 40-4326 UP",namet,OBJ_TREND,clrRed);
                  SekilCiz(prc4236,prc40,shift1-66,shift1-69," Cizgi 4326-40 UP",namet,OBJ_TREND,clrGreen);
                  SekilCiz(prc40,prc35,shift1-69,shift1-71," Cizgi 40-35 UP",namet,OBJ_TREND,clrGreen);
                  SekilCiz(prc35,prc25,shift1-71,shift1-79," Cizgi 35-25 UP",namet,OBJ_TREND,clrGreen);
                  SekilCiz(prc25,prc1618,shift1-79,shift1-86," Cizgi 25-1618 UP",namet,OBJ_TREND,clrGreen);
                  SekilCiz(prc1618,prc1309,shift1-86,shift1-93," Cizgi 1618-1309 UP",namet,OBJ_TREND,clrGreen);
                  SekilCiz(prc1309,prc20,shift1-93,shift1-99," Cizgi 1309-20 DOWN",namet,OBJ_TREND,clrRed);
                  SekilCiz(prc1618,prc20,shift1-86,shift1-89," Cizgi 1618-20 DOWN",namet,OBJ_TREND,clrRed);
                  */              
              
     //if ( cevap == 6 ) {MonitorScreen_Order="BUY";MonitorScreen_Price=MarketInfo(MonitorScreen_Symbol,MODE_BID);}
     //if ( cevap == 7 ) {MonitorScreen_Order="SELL";MonitorScreen_Price=MarketInfo(MonitorScreen_Symbol,MODE_ASK);}
    // if ( cevap == 3 ) return 0 ;
    
    

if ( TradeAllow && OrderCommetbs("BL ENTRY 3.0",Symbol()) == 0) {

         prices[0]=prcsl;
         pricen[0]="SL 200"; 
         prices[1]=prc618;
         pricen[1]="61.8"; 
         prices[2]=prc100;
         pricen[2]="100";
         prices[3]=prc1309;
         pricen[3]="1.309";  
         prices[4]=prc1618;
         pricen[4]="1.618";
         prices[5]=prc17070;
         pricen[5]="1.7070";
         prices[6]=prc17640;
         pricen[6]="1.7640";
         prices[6]=prc17640;
         pricen[6]="1.7640"; 
         prices[7]=prc20;
         pricen[7]="2.0"; 
         prices[8]=prc225;
         pricen[8]="2.25";  
         prices[9]=prc25;
         pricen[9]="2.5";   
         prices[10]=prc275;
         pricen[10]="2.75";  
         prices[11]=prc30;
         pricen[11]="3.0"; 
       prices[12]=prc3236;
         pricen[12]="3.236"; 
       prices[13]=prc35;
         pricen[13]="3.5";  
       prices[14]=prc3618;
         pricen[14]="3.618";
       prices[15]=prc40;
         pricen[15]="4.0"; 
       prices[16]=prc4236;
         pricen[16]="4.236"; 
       prices[17]=prc45;
         pricen[17]="4.45";  
       prices[18]=prc4736;
         pricen[18]="4.736";  
       prices[19]=prc50;
         pricen[19]="5.0";
      prices[20]=prc5236;
         pricen[20]="5.236";
      prices[21]=prc55;
         pricen[21]="5.5";    
      prices[22]=prc60;
         pricen[22]="6.0"; 
      prices[23]=prc70;
         pricen[23]="7.0"; 
      prices[24]=prc80;
         pricen[24]="8.0"; 
      prices[25]=prc110;
         pricen[25]="11.0";         
        

for (int p=0;p<=25;p++) {
Print(p,"/",pricen[p],"/",prices[p]);
}

/*
   double cprice_5=NormalizeDouble(prices[19],Digits);
   double cprice_8=NormalizeDouble(prices[24],Digits);
   double cprice_tp8=NormalizeDouble(prices[24],Digits);
   double cprice_tp11=NormalizeDouble(prices[25],Digits);
   
int cevapc=MessageBox(Symbol(),"Casper İşlem Açmak 5 Seviye",3); //  / Spread:"+Spread_Yuzde+"%"    

if ( cevapc == 6 ) {   
   for (int c=1;c<=3;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_BUYLIMIT,LOTS,cprice_5,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_5,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_5,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_5,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
}
      
      
 cevapc=MessageBox(Symbol(),"Casper İşlem Açmak 8 Seviye",3); //  / Spread:"+Spread_Yuzde+"%"    

if ( cevapc == 6 ) {   
   for (int c=1;c<=1;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_BUYLIMIT,LOTS,cprice_8,0,0,0,"CasperBuy",magic,0,clrNONE);   
   string cmt="CasperSell"+ticket_buy;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
   //if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   //if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
}
      
      */
      
      
            
      


         
      



int cevap=MessageBox(Symbol(),"1İşlem Açmak Yes=BUYLIMIT No=SELLSTOP",3); //  / Spread:"+Spread_Yuzde+"%"    


string limit_list="[4.736],[5.0],[5.5],[6.0],[7.0],[8.0],[11.0]";


if ( cevap == 6 ) {
for (int p=0;p<=25;p++) {
//Print(p,"/",pricen[p],"/",prices[p]);
if ( StringFind(limit_list,"["+pricen[p]+"]",0) != -1 ) {
if ( OrderCommetbs(pricen[p],Symbol()) == 0 && OrderCommetssType(pricen[p],Symbol(),OP_BUY) == 0 )  int tickets = OrderSend(Symbol(),OP_BUYLIMIT,LOTS,prices[p],0,0,0,pricen[p],magic,0,clrAliceBlue);    
}
}
    
}

string stop_list="[61.8],[100],[1.309],[1.618],[2.0],[2.5],[2.75],[3.0],[3.236],[3.618],[4.0]";

if ( cevap == 7 ) {
for (int p=0;p<=25;p++) {
//Print(p,"/",pricen[p],"/",prices[p]);
if ( StringFind(stop_list,"["+pricen[p]+"]",0) != -1 ) {
if ( OrderCommetbs(pricen[p],Symbol()) == 0 && OrderCommetssType(pricen[p],Symbol(),OP_SELL) == 0 ) int tickets = OrderSend(Symbol(),OP_SELLSTOP,LOTS,prices[p],0,0,0,pricen[p],magic,0,clrAliceBlue);    
}
}
}

}
    
    /*
for (int p=0;p<=24;p++) {
Print(p,"/",pricen[p],"/",prices[p]);
}*/
    
    
    /*
         
         if ( TradeAllow && OrderCommetbs("BL ENTRY 3.0",Symbol()) == 0) {
         
         LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0); 
         
        int cevap=MessageBox(Symbol(),"İşlem Açmak Yes=SL5 No=SL6",3); //  / Spread:"+Spread_Yuzde+"%"    
        if ( cevap == 6 || cevap == 7 ) { 
        
        double SL;
        if ( cevap == 6 ) {SL=SL5;}
        if ( cevap == 7 ) {SL=SL6;}
            
        if ( OrderCommetbs("BL ENTRY 3.0",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_BUYLIMIT,LOTS,ENTRY3,0,SL,0,"BL ENTRY 3.0",0,0,clrAliceBlue);    
        if ( OrderCommetbs("BL ENTRY 3.5",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_BUYLIMIT,LOTS*2,ENTRY35,0,SL,0,"BL ENTRY 3.5",0,0,clrAliceBlue);              
        if ( OrderCommetbs("BL ENTRY 4.0",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_BUYLIMIT,LOTS*3,ENTRY4,0,SL,0,"BL ENTRY 4.0",0,0,clrAliceBlue); 
        //if ( OrderCommetbs("BL ENTRY 4.0",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_BUYLIMIT,LOTS*3,ENTRY5,0,SL,0,"BL ENTRY 4.0",0,0,clrAliceBlue); 
        }
        
        }*/
        
        
        
        
        
        
        
        }
        
        if ( price2 > price1 ) {
        
       tepe_fiyats=High[shift2];
        dip_fiyats=Low[shift1];


//Alert("Selam");


  double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="d618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="d886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  

  level=level886;
  levels="d886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*2),Time[0],low_price-(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);
  
    
                         
        
        if ( ObjectGetInteger(ChartID(),namet,OBJPROP_TYPE) == OBJ_TREND ) {
        ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        } else {
        
        tepe_fiyats=price2;
        dip_fiyats=price1;
        
        
        }
        
        
        ObjectMove(currChart,namet,2,time3,price2-(((price2-price1)/100)*61.8));
        int Fark=(((price2-price1)*4.5)-(((price2-price1)/100)*61.8))/Point;
        //Comment(Fark);
        
       


       
        
       /* ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        ObjectMove(currChart,namet,2,time3,price2+(((price1-price2)/100)*61.8));
        Fark=(((price1-price2)*4.5)-(((price1-price2)/100)*61.8))/Point;
        Comment(Fark);*/
        
        string name;
        

        fiboset_tepe=tepe_fiyats;
        fiboset_dip=dip_fiyats;        

        int fiboset_Fark = (fiboset_tepe-fiboset_dip)/Point;
        
        /*double dip_fiyats_onceki=Low[shift2+1];
        double dip_fiyats_sonraki=Low[shift2-1];
        //string dib_bilgi = dip_fiyats_onceki+" "+dip_fiyats_sonraki;
        string dib_bilgi = int(MathAbs(dip_fiyats_onceki-dip_fiyats)/Point)+"/"+int(MathAbs(dip_fiyats_sonraki-dip_fiyats)/Point);*/
        
        double tepe_fiyats_onceki=High[shift2+1];
        double tepe_fiyats_sonraki=High[shift2-1];
        //string dib_bilgi = dip_fiyats_onceki+" "+dip_fiyats_sonraki;
        string tepe_bilgi = int(MathAbs(tepe_fiyats_onceki-tepe_fiyats)/Point)+"/"+int(MathAbs(tepe_fiyats_sonraki-tepe_fiyats)/Point);
                
        

         double Pips_Price_valued = PipPrice(Symbol(),0,fiboset_Fark,1);
         name = namet + " Pip Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*2, dip_fiyats-50*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetString(0,name,OBJPROP_TEXT,tepe_bilgi+" "+fiboset_Fark+" pip "+DoubleToString(Pips_Price_valued,2)+"$"+" High:"+DoubleToString(tepe_fiyats,MarketInfo(Symbol(),MODE_DIGITS))+" Low:"+DoubleToString(dip_fiyats,MarketInfo(Symbol(),MODE_DIGITS)));  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
       
         prcsl=dip_fiyats-200*Point;
         prices[0]=prcsl;
         pricen[0]="SL 200";  
         


         name=namet + " FE SL 200";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats-200*Point,Time[0],dip_fiyats-200*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         


        Fark=(((tepe_fiyats-dip_fiyats)*1.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc618=dip_fiyats+Fark*Point;
        
         prices[1]=dip_fiyats+200*Point;
         pricen[1]="61.8";  
        

        
         name=namet + " FE 61.8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 61.8");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*2)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc100=dip_fiyats+Fark*Point;

         prices[2]=prc100;
         pricen[2]="100";          
        
         name=namet + " FE 100";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 100");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
        Fark=(((tepe_fiyats-dip_fiyats)*2.309)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc1309=dip_fiyats+Fark*Point;
        
         prices[3]=prc1309;
         pricen[3]="1.309";           
        
         name=namet + " FE 1.309";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
         ObjectSetInteger(0,name,OBJPROP_BACK,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.309");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////         
         

        Fark=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc1618=dip_fiyats+Fark*Point;

         prices[4]=prc1618;
         pricen[4]="1.618";        
        
         name=namet + " FE 1.168";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         


        Fark=(((tepe_fiyats-dip_fiyats)*2.707)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc17070=dip_fiyats+Fark*Point;
        
         prices[5]=prc17070;
         pricen[5]="1.7070";         
        
         name=namet + " FE 1.7070";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.7070");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////


        Fark=(((tepe_fiyats-dip_fiyats)*2.764)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*2.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc17640=dip_fiyats+Fark*Point;

         prices[6]=prc17640;
         pricen[6]="1.7640";        
        
         name=namet + " FE 1.7640";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.7640");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        double Farks=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc20=dip_fiyats+Fark*Point;
        
         prices[7]=prc20;
         pricen[7]="2.0";          
        
         name=namet + " FE 2.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.0 / 3.5 Dönüş Yeri");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////

        Fark=(((tepe_fiyats-dip_fiyats)*3.25)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        //prc25=dip_fiyats+Fark*Point;

         prices[8]=prc225;
         pricen[8]="2.25";          
        
         name=namet + " FE 2.25";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkGreen); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.25");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
                  
         
        Fark=(((tepe_fiyats-dip_fiyats)*3.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc25=dip_fiyats+Fark*Point;
        
         prices[9]=prc25;
         pricen[9]="2.5";          
        
         name=namet + " FE 2.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////
         
         
        Fark=(((tepe_fiyats-dip_fiyats)*3.75)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*3)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc275=dip_fiyats+Fark*Point;

         prices[10]=prc275;
         pricen[10]="2.75";           
        
         name=namet + " FE 2.75";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 2.75");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         ////////////////////////////////////////////////////////////////////////////////////////////////                  
        
        Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc30=dip_fiyats+Fark*Point;
        
        ENTRY3=dip_fiyats+Fark*Point;
        
        prices[11]=prc30;
         pricen[11]="3.0";         
        
         name=namet + " FE 3.0";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.0");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
         

         
                   

        Fark=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);   
        prc35=dip_fiyats+Fark*Point;
        
        ENTRY35=dip_fiyats+Fark*Point;     

       prices[13]=prc35;
         pricen[13]="3.5";         
         
         name=namet + " FE 3.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);            



        Fark=(((tepe_fiyats-dip_fiyats)*4.618)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);
        //TP4=tepe_fiyats-Fark;
        prc3618=dip_fiyats+Fark*Point;

       prices[14]=prc3618;
         pricen[14]="3.618";          
        
        //ENTRY3=dip_fiyats+Fark*Point;
        
         name=namet + " FE 3.618";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 3.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         
                  

        Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);   
        prc40=dip_fiyats+Fark*Point;
        
        ENTRY4=dip_fiyats+Fark*Point;  
        
       prices[15]=prc40;
         pricen[15]="4.0";            
         
         name=namet + " FE 4";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);

         name=namet + " FE 4 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);         
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
         /*name=namet + " FE 4 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+8*PeriodSeconds(),dip_fiyats+Fark*Point,time1+11*PeriodSeconds(),((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);  */ 
                  
         
         
        Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);   
        prc4236=dip_fiyats+Fark*Point;
        
        //ENTRY4=dip_fiyats+Fark*Point; 

       prices[16]=prc4236;
         pricen[16]="4.236";  
                      
         
         name=namet + " FE 4.236";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         name=namet + " FE 4.236 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);  
         
         name=namet + " FE 4 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,prc4236,Time[Bars-1],prc40);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
                
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.236");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         

         /*name=namet + " FE 4.236 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+5*PeriodSeconds(),dip_fiyats+Fark*Point,time1+8*PeriodSeconds(),((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1); */  
         
         name=namet + " FE 3.236 (4.236) TRUE";
         prc3236=((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats));
         
        prices[12]=prc3236;
         pricen[12]="3.236";    
         
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)),Time[0],((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,"3.236 :"+int((tepe_fiyats-dip_fiyats)/Point)+" Pips");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);          
         
                     
         
         
        Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc50=dip_fiyats+Fark*Point;
        
        SL5=dip_fiyats+Fark*Point;      
        

       prices[19]=prc50;
         pricen[19]="5.0";           
         
         name=namet + " FE 5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);          
         
         name=namet + " FE 5 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);  
                         
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         



        Fark=(((tepe_fiyats-dip_fiyats)*5.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc45=dip_fiyats+Fark*Point;
        
        ///SL5=dip_fiyats+Fark*Point;        
         
       prices[17]=prc45;
         pricen[17]="4.45";  
         
         name=namet + " FE 4.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrDarkGray); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);          
         
 
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.5");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);prc45              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);    
         //ObjectSetString(0,name,OBJPROP_TOOLTIP,prc45); 
         


        Fark=(((tepe_fiyats-dip_fiyats)*5.736)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark); 
        prc4736=dip_fiyats+Fark*Point;
        
       prices[18]=prc4736;
         pricen[18]="4.736";          
        
        ///SL5=dip_fiyats+Fark*Point;        
         
         name=namet + " FE 4.736";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrLightGray); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         //ObjectSetString(0,name,OBJPROP_TOOLTIP,prc4736);           
         
 
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 4.736");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);                
         

        /* name=namet + " FE 5 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,dip_fiyats+Fark*Point,time1+3*PeriodSeconds(),((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);  */               
                  
         
         
       /*tepe_fiyats=High[shift2];
        dip_fiyats=Low[shift1];  */       
         
         

        Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);   
        prc5236=dip_fiyats+Fark*Point;
        
        //ENTRY4=dip_fiyats+Fark*Point;  
        
       prices[20]=prc5236;
         pricen[20]="5.236";             
         
         name=namet + " FE 5.236";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         name=namet + " FE 5.236 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         name=namet + " FE 5 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1,prc5236,Time[Bars-1],prc50);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBisque); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 

         
                  
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5.236");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         




        Fark=(((tepe_fiyats-dip_fiyats)*6.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);   
        prc55=dip_fiyats+Fark*Point;
        
        //ENTRY4=dip_fiyats+Fark*Point;
        
      prices[21]=prc55;
         pricen[21]="5.5";               
         
         name=namet + " FE 5.5";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlue); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         name=namet + " FE 5.5 ARZ";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,1); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         name=namet + " FE 5.5 AREA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,Time[0]+100*PeriodSeconds(),prc55,time1,prc5236);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrCrimson); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY,1);          
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 

         
                  
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 5.5 Stop Seviyesi");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);         
         
         /*name=namet + " FE 5.236 TRUE";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_RECTANGLE,0,time1+3*PeriodSeconds(),dip_fiyats+Fark*Point,time1+5*PeriodSeconds(),((dip_fiyats+Fark*Point)-(tepe_fiyats-dip_fiyats)));
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TOOLTIP,(tepe_fiyats-dip_fiyats)/Point);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1); */ 
                  

         
         
                        
        Fark=(((tepe_fiyats-dip_fiyats)*7)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        prc60=dip_fiyats+Fark*Point;
        
        SL6=dip_fiyats+Fark*Point;   

      prices[22]=prc60;
         pricen[22]="6.0";                
         
         name=namet + " FE 6";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 6 - STOP LV1");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         
        Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        prc70=dip_fiyats+Fark*Point;
        
        SL7=dip_fiyats+Fark*Point;    
        
      prices[23]=prc70;
         pricen[23]="7.0";            
         
         name=namet + " FE 7";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 7 - STOP LV2");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         


        Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        prc80=dip_fiyats+Fark*Point;
        
        SL8=dip_fiyats+Fark*Point;  
        
      prices[24]=prc80;
         pricen[24]="8.0";              
         
         name=namet + " FE 8";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 8 - STOP LV3");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER); 
         



        Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //double Farks=(((tepe_fiyats-dip_fiyats)*4.5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
        //Comment("Fark:",Fark);  
        double prc110=dip_fiyats+Fark*Point;
        
        double SL11=dip_fiyats+Fark*Point;      

      prices[25]=prc110;
         pricen[25]="11.0";          
         
         name=namet + " FE 11";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,time1,dip_fiyats+Fark*Point,Time[0],dip_fiyats+Fark*Point);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetString(0,name,OBJPROP_TEXT,name);
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,1); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         
         
         name = name + " Text";
         ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TEXT, 0, time1+PeriodSeconds()*15, dip_fiyats+Fark*Point);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,2);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,name,OBJPROP_BACK,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 11 - STOP LV3");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         
         
//SekilCiz(dip_fiyats,prc1618,shift1,shift1-36," Cizgi 1.618",namet,OBJ_TREND,clrWhite);
//SekilCiz(dip_fiyats,prc20,shift1,shift1-36," Cizgi 20",namet,OBJ_TREND,clrWhite);         
//SekilCiz(dip_fiyats,prc25,shift1,shift1-36," Cizgi 25",namet,OBJ_TREND,clrWhite);  

int genisleme_fark = 6;

int genisleme = genisleme_fark+formasyon_alani_shift;

//6
SekilCiz(dip_fiyats,prc618,shift1,shift1-(6+formasyon_alani_shift)," Cizgi 61.8 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc618,prc618-150*Point,shift1-(6+formasyon_alani_shift),shift1-(9+formasyon_alani_shift)," Cizgi 61.8 Down",namet,OBJ_TREND,clrWhite);  


SekilCiz(prc618,prc100,shift1-(6+formasyon_alani_shift),shift1-(13+formasyon_alani_shift)," Cizgi 61.8-100 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc100,prc618,shift1-(13+formasyon_alani_shift),shift1-(19+formasyon_alani_shift)," Cizgi 100-61.8 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc100,prc1309,shift1-(13+formasyon_alani_shift),shift1-(19+formasyon_alani_shift)," Cizgi 100-1.309 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1309,prc100,shift1-(19+formasyon_alani_shift),shift1-(23+formasyon_alani_shift)," Cizgi 1.309-100 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1309,prc1618,shift1-(19+formasyon_alani_shift),shift1-(25+formasyon_alani_shift)," Cizgi 1.309-1.618 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1618,prc1309,shift1-(25+formasyon_alani_shift),shift1-(27+formasyon_alani_shift)," Cizgi 1.618-1.309 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1618,prc20,shift1-(25+formasyon_alani_shift),shift1-(33+formasyon_alani_shift)," Cizgi 1.618-20 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc1618,shift1-(33+formasyon_alani_shift),shift1-(35+formasyon_alani_shift)," Cizgi 20-1.618 Down",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc100,shift1-(33+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 20-100",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618,prc100,shift1-(25+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 1.618-100",namet,OBJ_TREND,clrRed);

SekilCiz(prc20,prc25,shift1-(33+formasyon_alani_shift),shift1-(36+formasyon_alani_shift)," Cizgi 20-25 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc25,prc20,shift1-(36+formasyon_alani_shift),shift1-(39+formasyon_alani_shift)," Cizgi 20-25 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1618-15*Point,prc1618+20*Point,shift1-(24+formasyon_alani_shift),shift1-(26+formasyon_alani_shift)," Kare 1618",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc20-15*Point,prc20+20*Point,shift1-(32+formasyon_alani_shift),shift1-(34+formasyon_alani_shift)," Kare 20",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25-15*Point,prc25+20*Point,shift1-(35+formasyon_alani_shift),shift1-(37+formasyon_alani_shift)," Kare 25",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25-15*Point,prc25+20*Point,shift1-(58+formasyon_alani_shift),shift1-(60+formasyon_alani_shift)," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc40-15*Point,prc40+20*Point,shift1-(62+formasyon_alani_shift),shift1-(64+formasyon_alani_shift)," Kare 40",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc35-15*Point,prc35+20*Point,shift1-(60+formasyon_alani_shift),shift1-(62+formasyon_alani_shift)," Kare 35",namet,OBJ_RECTANGLE,clrGreen);


SekilCiz(prc100,prc618,shift1-(48+formasyon_alani_shift),shift1-(51+formasyon_alani_shift)," Cizgi 100-61.6",namet,OBJ_TREND,clrRed);
SekilCiz(prc618,prc100,shift1-(51+formasyon_alani_shift),shift1-(56+formasyon_alani_shift)," Cizgi 61.8-100",namet,OBJ_TREND,clrGreen);
//SekilCiz(prc20-20*Point,prc20+50*Point,shift1-35,shift1-37," Kare 20",namet,OBJ_RECTANGLE,clrRed);

//SekilCiz(prc25-20*Point,prc25+50*Point,shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25,prc100,shift1-(36+formasyon_alani_shift),shift1-(48+formasyon_alani_shift)," Cizgi 25-100",namet,OBJ_TREND,clrRed);         
SekilCiz(prc100,prc25,shift1-(48+formasyon_alani_shift),shift1-(53+formasyon_alani_shift)," Cizgi 35",namet,OBJ_TREND,clrGreen);
SekilCiz(prc25,prc30,shift1-(53+formasyon_alani_shift),shift1-(56+formasyon_alani_shift)," Cizgi 25-30",namet,OBJ_TREND,clrGreen);
SekilCiz(prc30,prc25,shift1-(56+formasyon_alani_shift),shift1-(59+formasyon_alani_shift)," Cizgi 30-25",namet,OBJ_TREND,clrRed);
SekilCiz(prc25,prc35,shift1-(59+formasyon_alani_shift),shift1-(61+formasyon_alani_shift)," Cizgi 25-35",namet,OBJ_TREND,clrGreen);
SekilCiz(prc35,prc40,shift1-(61+formasyon_alani_shift),shift1-(63+formasyon_alani_shift)," Cizgi 35-40",namet,OBJ_TREND,clrGreen);
SekilCiz(prc40,prc30,shift1-(63+formasyon_alani_shift),shift1-(66+formasyon_alani_shift)," Cizgi 40-30",namet,OBJ_TREND,clrRed);
SekilCiz(prc30,prc25,shift1-(66+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 30-25 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc3618,prc30,shift1-(64+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 45-30",namet,OBJ_TREND,clrYellow);
SekilCiz(prc25,prc20,shift1-(69+formasyon_alani_shift),shift1-(73+formasyon_alani_shift)," Cizgi 25-20 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc40,prc4236,shift1-(63+formasyon_alani_shift),shift1-(66+formasyon_alani_shift)," Cizgi 40-4326 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc4236,prc40,shift1-(66+formasyon_alani_shift),shift1-(69+formasyon_alani_shift)," Cizgi 4326-40 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc40,prc35,shift1-(69+formasyon_alani_shift),shift1-(71+formasyon_alani_shift)," Cizgi 40-35 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc35,prc25,shift1-(71+formasyon_alani_shift),shift1-(79+formasyon_alani_shift)," Cizgi 35-25 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc25,prc1618,shift1-(79+formasyon_alani_shift),shift1-(86+formasyon_alani_shift)," Cizgi 25-1618 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618,prc1309,shift1-(86+formasyon_alani_shift),shift1-(93+formasyon_alani_shift)," Cizgi 1618-1309 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc1309,prc20,shift1-(93+formasyon_alani_shift),shift1-(99+formasyon_alani_shift)," Cizgi 1309-20 DOWN",namet,OBJ_TREND,clrGreen);
SekilCiz(prc1618,prc20,shift1-(86+formasyon_alani_shift),shift1-(89+formasyon_alani_shift)," Cizgi 1618-20 DOWN",namet,OBJ_TREND,clrGreen);



/*
SekilCiz(dip_fiyats,prc618,shift1,shift1-6," Cizgi 61.8 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc618,prc618-150*Point,shift1-6,shift1-9," Cizgi 61.8 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc618,prc100,shift1-6,shift1-13," Cizgi 61.8-100 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc100,prc618,shift1-13,shift1-19," Cizgi 100-61.8 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc100,prc1309,shift1-13,shift1-19," Cizgi 100-1.309 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1309,prc100,shift1-19,shift1-23," Cizgi 1.309-100 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1309,prc1618,shift1-19,shift1-25," Cizgi 1.309-1.618 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc1618,prc1309,shift1-25,shift1-27," Cizgi 1.618-1.309 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc1618,prc20,shift1-25,shift1-33," Cizgi 1.618-20 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc1618,shift1-33,shift1-35," Cizgi 20-1.618 Down",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc20,prc100,shift1-33,shift1-48," Cizgi 20-100",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618,prc100,shift1-25,shift1-48," Cizgi 1.618-100",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618-15*Point,prc1618+20*Point,shift1-24,shift1-26," Kare 1618",namet,OBJ_RECTANGLE,clrGreen);

SekilCiz(prc20,prc25,shift1-33,shift1-36," Cizgi 20-25 UP",namet,OBJ_TREND,clrWhite);  
SekilCiz(prc25,prc20,shift1-36,shift1-39," Cizgi 20-25 Down",namet,OBJ_TREND,clrWhite);  

SekilCiz(prc20-15*Point,prc20+20*Point,shift1-32,shift1-34," Kare 20",namet,OBJ_RECTANGLE,clrGreen);

SekilCiz(prc25-15*Point,prc25+20*Point,shift1-35,shift1-37," Kare 25",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25-15*Point,prc25+20*Point,shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);

SekilCiz(prc40-15*Point,prc40+20*Point,shift1-62,shift1-64," Kare 40",namet,OBJ_RECTANGLE,clrGreen);

SekilCiz(prc35-15*Point,prc35+20*Point,shift1-60,shift1-62," Kare 35",namet,OBJ_RECTANGLE,clrGreen);


SekilCiz(prc100,prc618,shift1-48,shift1-51," Cizgi 100-61.6",namet,OBJ_TREND,clrRed);
SekilCiz(prc618,prc100,shift1-51,shift1-56," Cizgi 61.8-100",namet,OBJ_TREND,clrGreen);
//SekilCiz(prc20-20*Point,prc20+50*Point,shift1-35,shift1-37," Kare 20",namet,OBJ_RECTANGLE,clrRed);

//SekilCiz(prc25-20*Point,prc25+50*Point,shift1-58,shift1-60," Kare 25 SECOND",namet,OBJ_RECTANGLE,clrGreen);
SekilCiz(prc25,prc100,shift1-36,shift1-48," Cizgi 25-100",namet,OBJ_TREND,clrRed);         
SekilCiz(prc100,prc25,shift1-48,shift1-53," Cizgi 35",namet,OBJ_TREND,clrGreen);
SekilCiz(prc25,prc30,shift1-53,shift1-56," Cizgi 25-30",namet,OBJ_TREND,clrGreen);
SekilCiz(prc30,prc25,shift1-56,shift1-59," Cizgi 30-25",namet,OBJ_TREND,clrRed);
SekilCiz(prc25,prc35,shift1-59,shift1-61," Cizgi 25-35",namet,OBJ_TREND,clrGreen);
SekilCiz(prc35,prc40,shift1-61,shift1-63," Cizgi 35-40",namet,OBJ_TREND,clrGreen);
SekilCiz(prc40,prc30,shift1-63,shift1-66," Cizgi 40-30",namet,OBJ_TREND,clrRed);
SekilCiz(prc30,prc25,shift1-66,shift1-69," Cizgi 30-25 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc3618,prc30,shift1-64,shift1-69," Cizgi 45-30",namet,OBJ_TREND,clrYellow);
SekilCiz(prc25,prc20,shift1-69,shift1-73," Cizgi 25-20 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc40,prc4236,shift1-63,shift1-66," Cizgi 40-4326 UP",namet,OBJ_TREND,clrGreen);
SekilCiz(prc4236,prc40,shift1-66,shift1-69," Cizgi 4326-40 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc40,prc35,shift1-69,shift1-71," Cizgi 40-35 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc35,prc25,shift1-71,shift1-79," Cizgi 35-25 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc25,prc1618,shift1-79,shift1-86," Cizgi 25-1618 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc1618,prc1309,shift1-86,shift1-93," Cizgi 1618-1309 UP",namet,OBJ_TREND,clrRed);
SekilCiz(prc1309,prc20,shift1-93,shift1-99," Cizgi 1309-20 DOWN",namet,OBJ_TREND,clrGreen);
SekilCiz(prc1618,prc20,shift1-86,shift1-89," Cizgi 1618-20 DOWN",namet,OBJ_TREND,clrGreen);
*/

         if ( sekil ) {
        /* name = namet + " Aci";
         ObjectDelete(0,name);
         //ObjectCreate(0,name, OBJ_TREND, 0, time1, tepe_fiyats,time1+((time1-time2)*6),tepe_fiyats-Fark*Point);                         
         ObjectCreate(0,name, OBJ_TRENDBYANGLE, 0, time1, dip_fiyats);                         
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,true);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");  // ObjectSetString(0,name,OBJPROP_TEXT,"38.2"+pattern_382);              
         //ObjectSetDouble(0,name,OBJPROP_ANGLE,0);
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);          
         ObjectSetDouble(0,name,OBJPROP_ANGLE,45);
       
         datetime AngleTime = ObjectGetTimeByValue(0,name,prc4236,0);
        ObjectSetInteger(0,name,OBJPROP_RAY,false);
        ObjectMove(0,name,1,AngleTime,prc4236); */
        
                 
         name = namet + " Genislik";
         //ObjectDelete(0,name);
         ObjectCreate(0,name, OBJ_TREND, 0, time1, dip_fiyats,time1+PeriodSeconds()*5,dip_fiyats);                                 
         ObjectSetInteger(0,name,OBJPROP_COLOR, clrWhite );
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,true); 
         ObjectSetInteger(0,name,OBJPROP_BACK,0);
         ObjectSetInteger(0,name,OBJPROP_RAY,false);
         ObjectSetString(0,name,OBJPROP_TEXT,"FE 1.618");        
        
          
         }

         /*
         if ( TradeAllow && OrderCommetbs("SL ENTRY 3.0",Symbol()) == 0 ) {
         
                 int cevap=MessageBox(Symbol(),"İşlem Açmak Yes=SL5 No=SL6",3); //  / Spread:"+Spread_Yuzde+"%"    
        if ( cevap == 6 || cevap == 7 ) { 
        
        double SL;
        if ( cevap == 6 ) {SL=SL5;}
        if ( cevap == 7 ) {SL=SL6;}
        
        
            LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);     
        if ( OrderCommetbs("SL ENTRY 3.0",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_SELLLIMIT,LOTS,ENTRY3,0,SL,0,"SL ENTRY 3.0",0,0,clrAliceBlue);    
        if ( OrderCommetbs("SL ENTRY 3.5",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_SELLLIMIT,LOTS*2,ENTRY35,0,SL,0,"SL ENTRY 3.5",0,0,clrAliceBlue);              
        if ( OrderCommetbs("SL ENTRY 4.0",Symbol()) == 0 ) int tickets = OrderSend(OrderSymbol(),OP_SELLLIMIT,LOTS*3,ENTRY4,0,SL,0,"SL ENTRY 4.0",0,0,clrAliceBlue); 
                
        
                }
       
        }*/
        
        


        


if ( TradeAllow && OrderCommetbs("BL ENTRY 3.0",Symbol()) == 0) {

         prices[0]=prcsl;
         pricen[0]="SL 200"; 
         prices[1]=prc618;
         pricen[1]="61.8"; 
         prices[2]=prc100;
         pricen[2]="100";
         prices[3]=prc1309;
         pricen[3]="1.309";  
         prices[4]=prc1618;
         pricen[4]="1.618";
         prices[5]=prc17070;
         pricen[5]="1.7070";
         prices[6]=prc17640;
         pricen[6]="1.7640";
         prices[6]=prc17640;
         pricen[6]="1.7640"; 
         prices[7]=prc20;
         pricen[7]="2.0"; 
         prices[8]=prc225;
         pricen[8]="2.25";  
         prices[9]=prc25;
         pricen[9]="2.5";   
         prices[10]=prc275;
         pricen[10]="2.75";  
         prices[11]=prc30;
         pricen[11]="3.0"; 
       prices[12]=prc3236;
         pricen[12]="3.236"; 
       prices[13]=prc35;
         pricen[13]="3.5";  
       prices[14]=prc3618;
         pricen[14]="3.618";
       prices[15]=prc40;
         pricen[15]="4.0"; 
       prices[16]=prc4236;
         pricen[16]="4.236"; 
       prices[17]=prc45;
         pricen[17]="4.45";  
       prices[18]=prc4736;
         pricen[18]="4.736";  
       prices[19]=prc50;
         pricen[19]="5.0";
      prices[20]=prc5236;
         pricen[20]="5.236";
      prices[21]=prc55;
         pricen[21]="5.5";    
      prices[22]=prc60;
         pricen[22]="6.0"; 
      prices[23]=prc70;
         pricen[23]="7.0"; 
      prices[24]=prc80;
         pricen[24]="8.0"; 
      prices[25]=prc110;
         pricen[25]="11.0"; 


for (int p=0;p<=24;p++) {
Print(p,"/",pricen[p],"/",prices[p]);
}
/*

   double cprice_5=NormalizeDouble(prices[19],Digits);
   double cprice_8=NormalizeDouble(prices[24],Digits);
   double cprice_tp8=NormalizeDouble(prices[24],Digits);
   double cprice_tp11=NormalizeDouble(prices[25],Digits);
   
int cevapc=MessageBox(Symbol(),"Casper İşlem Açmak 5 Seviye",3); //  / Spread:"+Spread_Yuzde+"%"    

if ( cevapc == 6 ) {   
   for (int c=1;c<=3;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_SELLLIMIT,LOTSELL,cprice_5,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_BUYSTOP,LOTS,cprice_5,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_BUYSTOP,LOTS,cprice_5,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_BUYSTOP,LOTS,cprice_5,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
}
      
      
 cevapc=MessageBox(Symbol(),"Casper İşlem Açmak 8 Seviye",3); //  / Spread:"+Spread_Yuzde+"%"    

if ( cevapc == 6 ) {   
   for (int c=1;c<=1;c++) {
   int ticket_buy=OrderSend(Symbol(),OP_SELLLIMIT,LOTSELL,cprice_8,0,0,0,"CasperBuy",magic,0,clrNONE);   
   string cmt="CasperSell"+ticket_buy;
   if ( c==1 ) int ticket_sell=OrderSend(Symbol(),OP_BUYSTOP,LOTS,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
   //if ( c==2 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp8,cmt,magic,0,clrNONE);
   //if ( c==3 ) int ticket_sell=OrderSend(Symbol(),OP_SELLSTOP,LOTSELL,cprice_8,0,0,cprice_tp11,cmt,magic,0,clrNONE);
      }
}
   
   */
   


int cevap=MessageBox(Symbol(),"İşlem Açmak Yes=SELLLIMIT No=BUYSTOP",3); //  / Spread:"+Spread_Yuzde+"%"    

string selllimit_list="[4.736],[5.0],[5.5],[6.0],[7.0],[8.0],[11.0]";

if ( cevap == 6 ) {
for (int p=0;p<=25;p++) {
//Print(p,"/",pricen[p],"/",prices[p]);

if ( StringFind(selllimit_list,"["+pricen[p]+"]",0) != -1 ) {
if ( OrderCommetbs(pricen[p],Symbol()) == 0 && OrderCommetssType(pricen[p],Symbol(),OP_SELL) == 0 )  int tickets = OrderSend(Symbol(),OP_SELLLIMIT,LOTS,prices[p],0,0,0,pricen[p],magic,0,clrAliceBlue);    
}

}
    
}

string buystop_list="[61.8],[100],[1.309],[1.618],[2.0],[2.5],[2.75],[3.0],[3.236],[3.618],[4.0]";

if ( cevap == 7 ) {
for (int p=0;p<=25;p++) {
//Print(p,"/",pricen[p],"/",prices[p]);

if ( StringFind(buystop_list,"["+pricen[p]+"]",0) != -1 ) {

if ( OrderCommetbs(pricen[p],Symbol()) == 0 && OrderCommetssType(pricen[p],Symbol(),OP_BUY) == 0 ) int tickets = OrderSend(Symbol(),OP_BUYSTOP,LOTS,prices[p],0,0,0,pricen[p],magic,0,clrAliceBlue);    

}

}
}

}


        
        
        
        
        
        
        }
        
        }
        

}

//////////////////////////////////////////////////////////////////////////////////////////////

void AlertOrder() {

     double margin_buylot = 0;
    double margin_selllot = 0;
  double margin_buyprofit = 0;
 double margin_sellprofit = 0;
        double margin_lot = 0;
   bool margin_seviyeonay = false;   
   double MarjinSeviyesi = 0;
   double lot_maliyeti=MarketInfo(Symbol(),MODE_MARGINREQUIRED);
   double lot_margin_fiyati=0;
   double kalan_margin_fiyati=0;
   double onepipsprice = 0;
   double Pips_Price_valued;
   double kalan_para_pips;
   //double minumum_pip = 1;
   
   
   

               if (AccountMargin() > 0) { 
   if ( AccountEquity() != AccountMargin() ) {
    MarjinSeviyesi = NormalizeDouble((AccountEquity()/AccountMargin())*100,2);
    margin_seviyeonay=true;    
    }
    } else {
    //Alım Yapılmamış ( Burda Lot Maliyeti Kontrol Edilebilir )
    margin_seviyeonay=true;
    }
    
       
   if ( MarjinSeviyesi != 0 ) {
   

       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol()) {
           

        if ( OrderType() == OP_BUY ) {
        
           margin_buylot = margin_buylot + OrderLots();
           //onepipsprice=OrderProfit()/(MathAbs(OrderOpenPrice()-OrderClosePrice())/Point);
        
        }
        
        if ( OrderType() == OP_SELL ) {
        
           margin_selllot = margin_selllot + OrderLots();
           //onepipsprice=OrderProfit()/(MathAbs(OrderOpenPrice()-OrderClosePrice())/Point);
        }           
           
           }
           }
           }   
   

    double margin_toplam_lot;    

margin_selllot = NormalizeDouble(margin_selllot,2);
 margin_buylot = NormalizeDouble(margin_buylot,2);
   
if ( margin_selllot == margin_buylot ) { margin_toplam_lot=margin_selllot; Print("Lotlar Eşit Seviyede"); }


if ( margin_selllot != 0 &&  margin_buylot != 0  ) { 

   if ( margin_selllot != margin_buylot ) { Print("Lotlar Farklı Seviyede");
   
   margin_toplam_lot=MathAbs(margin_buylot-margin_selllot);
   if ( margin_buylot > margin_selllot ) margin_toplam_lot = margin_buylot-margin_selllot;
   
   
/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/
   
         //Pips_Price_valued = PipPrice(Symbol(),0,1,margin_toplam_lot);
         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         //if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = DivZero(AccountFreeMargin(),Pips_Price_valued)*minumum_pip;
         
         int stoplevelpip=DivZero(DivZero(AccountEquity(),MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()),Pips_Price_valued);
         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Bid+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH5",OBJ_HLINE,0,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Bid+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Bid+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH5",0,Time[1],Bid+stoplevelpip*Point);
         }
         

   if ( margin_selllot > margin_buylot ) margin_toplam_lot = margin_selllot-margin_buylot;
   
   
/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/
   
         ///Pips_Price_valued = PipPrice(Symbol(),0,1,margin_toplam_lot);
         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         ///if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = DivZero(AccountFreeMargin(),Pips_Price_valued)*minumum_pip;         
         
         //stoplevelpip=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;

         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);         
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid-stoplevelpip*Point);
         }         
            
   
   
   
   
    }
 
   }
//margin_toplam_lot = NormalizeDouble((AccountEquity()/lot_maliyeti)/4,2); // 100 // 4 25 lot buy 25 lot sell




/////////////////// ONLY SELL
if ( margin_selllot != 0 &&  margin_buylot == 0  ) { 
margin_toplam_lot=margin_selllot;

/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/

         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         
         if ( Pips_Price_valued == 0 ) Pips_Price_valued=1;
         
         //if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         //Print(AccountFreeMargin(),"/",Pips_Price_valued,"/",margin_toplam_lot,"/min_pip",minumum_pip);
         kalan_para_pips = (AccountFreeMargin()/Pips_Price_valued)*minumum_pip;
         
         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Ask,Time[1],Ask+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Ask+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Ask);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Ask+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Ask+kalan_para_pips*Point);
         }
         
         int stoplevelpip=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;
         int stoplevelpip50=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-50))/Pips_Price_valued;
         
         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_COLOR,clrBlack);
         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid+stoplevelpip50*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_COLOR,clrDarkBlue);         
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid+stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid+stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid+stoplevelpip50*Point);
         }    
         
         
                  
         
    }   


/////////////////// ONLY BUY
if ( margin_selllot == 0 &&  margin_buylot != 0  ) { 
margin_toplam_lot=margin_buylot;

string lot_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
lot_margin_fiyati = StringToDouble(lot_marginfiyati);

string kalan_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
kalan_margin_fiyati = StringToDouble(kalan_marginfiyati);


/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/

         ///Pips_Price_valued = PipPrice(Symbol(),0,1,margin_toplam_lot);
         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         ///if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         
         //Alert(Pips_Price_valued,"/",margin_toplam_lot,"/",minumum_pip);
         
         if ( Pips_Price_valued > 0 ) {
         kalan_para_pips = (AccountFreeMargin()/Pips_Price_valued)*minumum_pip;
         } else {
         kalan_para_pips = 1;
         Pips_Price_valued = 1;
         }
         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Bid-kalan_para_pips*Point);
         }
         
         
         
         int stoplevelpip=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;
         int stoplevelpip50=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-50))/Pips_Price_valued;
         
         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_COLOR,clrBlack);

         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid-stoplevelpip50*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_COLOR,clrDarkBlue);
         
                  
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid-stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid-stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid-stoplevelpip50*Point);
         }    

         
         
                  
         
         
    }   
    

      //((AccountEquity()/MarjinSeviyesi)*AccountStopoutLevel())/Pips_Price_valued
      
      
      
/*
Comment("Yeni Order",MarjinSeviyesi,
"\nBuy Lot:",margin_buylot,
"\nSELL Lot",margin_selllot,
"\nAccount Profit:",AccountProfit(),
"\nmargin_toplam_lot",margin_toplam_lot,
"\nmargin_buylot",margin_buylot,
"\nmargin_selllot",margin_selllot,
"\nlot_margin_fiyati",lot_margin_fiyati,
"\nkalan_margin_fiyati",kalan_margin_fiyati,
"\nStopOut Level",AccountStopoutLevel(),
"\nPips_Price_valued",Pips_Price_valued,
//"\nonepipsprice",onepipsprice,
"\nkalan_para_pips",kalan_para_pips//
//"\nSonra Hesap Patlar $",((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued //(AccountEquity()-(((AccountEquity()/MarjinSeviyesi)/Pips_Price_valued)*AccountStopoutLevel()))
);*/

/*
equity/margin_level = %1 parasal

margin_level - stop_out level = 80-10 = 70

( 70 * %1 parasal ) / pip_price = kaç pip olduğu çıkıyor
*/






}

if ( margin_selllot == 0 &&  margin_buylot == 0  ) { 
if ( ObjectFind(ChartID(),"FinishMoney") != -1 ) {
ObjectDelete(ChartID(),"FinishMoney");
ObjectDelete(ChartID(),"FinishMoneyH");
ObjectDelete(ChartID(),"FinishMoneyH5");
ObjectDelete(ChartID(),"FinishMoneyX");
ObjectDelete(ChartID(),"FinishMoneyHX");
ObjectDelete(ChartID(),"FinishMoneyHX5");
}
}   

}

int Spread_Yuzde = 0 ; 
string bs_comment_info = "";  

////////////////////////////////////////////////////////////////////// 
// BUY SELL PRICE
//////////////////////////////////////////////////////////////////////
string BuySellPrice(string sym,double bs_lot,bool bs_comment,string bs_result) {

return "";

if ( MarketInfo(sym,MODE_SPREAD) == 0 ) return 0;


if ( MarketInfo(sym,MODE_MINLOT) > bs_lot ) bs_lot = MarketInfo(sym,MODE_MINLOT); 
if ( MarketInfo(sym,MODE_MAXLOT) < bs_lot ) bs_lot = MarketInfo(sym,MODE_MAXLOT); 

////////////////////////////////////////////////////
/*string bad_word = "pro";   
int indexbw=StringFind(sym, bad_word, 0); 
if ( indexbw != -1 ) return "100";*/
////////////////////////////////////////////////////



//Print("OrderTotals():",OrdersTotal());

//if ( OrdersTotal() > 0 ) Print("Büyük");

//return "ozh";

/*
      string pairs[];
      int length = getAvailableCurrencyPairss(pairs);
      
      //Print("length:",length);
      
      for(int i=0; i <= length-1; i++)
      {
         
         
 string pair = pairs[i];
 
 if ( //sym == pair &&
  MarketInfo(pair,MODE_TRADEALLOWED) ) {
 Print("Pair:",pair,"Time",OrderTimeSym("BuyTrendFind",pair),"/",OrderTimeSym("SellTrendFind",pair));
 
 if ( OrderTimeSym("BuyTrendFind",pair) >= 60 ) OrderClosedSym("BuyTrendFind",pair);
 if ( OrderTimeSym("SellTrendFind",pair) >= 60 ) OrderClosedSym("SellTrendFind",pair);
 
 } 
 
 if ( sym == pair && 
 !MarketInfo(pair,MODE_TRADEALLOWED) 
 
 ) {
 Print("Market Kapalı Pair:",pair,"Time",OrderTimeSym("BuyTrendFind",pair),"/",OrderTimeSym("SellTrendFind",pair),":",MarketInfo(pair,MODE_TRADEALLOWED));
 }
 
if ( sym == pair ){
    int trade_mode=(int)SymbolInfoInteger(pair,SYMBOL_TRADE_MODE);
   string str_trade_mode;
   switch(trade_mode)
     {
      case SYMBOL_TRADE_MODE_DISABLED: str_trade_mode="SYMBOL_TRADE_MODE_DISABLED (trade is disabled for the symbol)"; break;
      case SYMBOL_TRADE_MODE_LONGONLY: str_trade_mode="SYMBOL_TRADE_MODE_LONGONLY (only long positions are allowed)"; break;
      case SYMBOL_TRADE_MODE_SHORTONLY: str_trade_mode="SYMBOL_TRADE_MODE_SHORTONLY (only short positions are allowed)"; break;
      case SYMBOL_TRADE_MODE_CLOSEONLY: str_trade_mode="SYMBOL_TRADE_MODE_CLOSEONLY (only position close operations are allowed)"; break;
      case SYMBOL_TRADE_MODE_FULL: str_trade_mode="SYMBOL_TRADE_MODE_FULL (no trade restrictions)"; break;
     }
     
     Print("Trade Mode:",pair,str_trade_mode);
     }
 
 }
*/

//double buy_profit_takip = 5*TrendLot;
//       buy_profit_takip = buy_profit_takip*(MarketInfo(Symbol(),MODE_TICKVALUE)/MarketInfo(Symbol(),MODE_TICKSIZE));


///////////////
// Spread Farkı ( Ekle Çıkar Modeli veya TakeProfit Takip 3xSpread )
///////////////
//Print("Spread Değeri",(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/MarketInfo(Symbol(),MODE_POINT));
//Print("Spread Ekleme",(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))+MarketInfo(Symbol(),MODE_BID));
////////////////
//Print("Spread Değeri",MarketInfo(Symbol(),MODE_MARGINREQUIRED)*(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID)));
//      
       
          int BS_spread = MarketInfo(sym,MODE_SPREAD);   
          //int BS_spread = SymbolInfoInteger(sym,SYMBOL_SPREAD);//
          //int BS_spread = (MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);          
          //if ( BS_spread == 0 ) BS_spread = 100;

    double BS_tickvalue = MarketInfo(sym,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(sym,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(sym,MODE_MARGINREQUIRED)*BS_spread;
        //Print(sym,"BS_spread_price",BS_spread_price);
        BS_spread_price = (1/MarketInfo(sym,MODE_POINT))*(BS_spread*(MarketInfo(sym,MODE_TICKVALUE)*MarketInfo(sym,MODE_TICKSIZE)));
        //Print(sym,":BS_spread",BS_spread);
   //if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 0 ) BS_spread_price = (1/MarketInfo(sym,MODE_POINT))*BS_spread;
   //if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 1 ) BS_spread_price = (1/MarketInfo(sym,MODE_POINT))*(BS_spread*(MarketInfo(sym,MODE_TICKVALUE)*MarketInfo(sym,MODE_TICKSIZE)));
 
        
    int BS_spread_yuzde = BS_spread_price/(MarketInfo(sym,MODE_MARGINREQUIRED)/100);
        BS_spread_price = BS_spread_price;
        
        double BS_money = AccountFreeMargin();
    double BS_lot_price = MarketInfo(sym,MODE_MARGINREQUIRED);//BS_spread_price+
  double BS_max_buy_lot = BS_money/BS_lot_price;
  
  if ( MarketInfo(sym,MODE_LOTSTEP) < 0 ) BS_max_buy_lot = BS_max_buy_lot;
  if ( MarketInfo(sym,MODE_LOTSTEP) >= 1 ) BS_max_buy_lot = MathFloor(BS_max_buy_lot); // Aşağı Çekiyor  Round Nereye Yakınsa Oraya Çekiyor
  
  if ( BS_max_buy_lot < MarketInfo(sym,MODE_MINLOT) ) BS_max_buy_lot = 0;
  
  double BS_margin_level;
  
  
  if (AccountMargin() > 0) BS_margin_level = (AccountEquity()/(AccountMargin()+BS_lot_price))*100; // 1 Lot Alınca Margin Seviyesi
  if (AccountMargin() == 0) BS_margin_level = (AccountEquity()/BS_lot_price)*100;
  
  double BS_lot_order_price=0;
  double BS_order_margin_level=0;
  double BS_order_spread_price=0;
  
  if ( bs_lot < 1 || bs_lot >= 1 ) {
  BS_lot_order_price = BS_lot_price*bs_lot;
  
  BS_order_spread_price = BS_spread_price*bs_lot;
  
  if (AccountMargin() > 0) BS_order_margin_level = (AccountEquity()/(AccountMargin()+BS_lot_order_price))*100; // 1 Lot Alınca Margin Seviyesi
  if (AccountMargin() == 0) BS_order_margin_level = (AccountEquity()/BS_lot_order_price)*100;
  
  //BS_order_margin_level = NormalizeDouble(BS_order_margin_level/bs_lot,2);
  
  //AccountFreeMargin
  
  }
  
  
  
     ///////////////////////////////////////////////////////////////////////////
     // Saatlik Bar Volümü Spread Küçükse İşleme Girilmez.
     ///////////////////////////////////////////////////////////////////////////
     bool Mum_Hour_Volume = true;
     int per = PERIOD_H1;
     if ( MathAbs(iClose(sym,per,1)-iOpen(sym,per,1)) < (MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID)) 
     
     || MathAbs(iClose(sym,per,2)-iOpen(sym,per,2)) < (MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID)) 
     
     ) Mum_Hour_Volume = false;
     
     string Mum_Hour_Volume_Result = "";
     string Mum_Hour_Volume_Result_sm = "";
     
     if ( Mum_Hour_Volume  ) Mum_Hour_Volume_Result = "Good Spread > H1"; // Saatlik Bar Seviyesi Düşük
     if ( !Mum_Hour_Volume ) Mum_Hour_Volume_Result = "Bad Spread < H1"; // Saatlik Bar Seviyesi Düşük
     
     if ( Mum_Hour_Volume  ) Mum_Hour_Volume_Result_sm = "G"; // Saatlik Bar Seviyesi Düşük
     if ( !Mum_Hour_Volume ) Mum_Hour_Volume_Result_sm = "B"; // Saatlik Bar Seviyesi Düşük
     
     //if ( TVL_ortalama*MarketInfo(pairswl[iwl],MODE_POINT) < (MarketInfo(pairswl[iwl],MODE_ASK)-MarketInfo(pairswl[iwl],MODE_BID))*3 ) continue;
     /////////////////////////////////////////////////////////////////////////// 
     
  
  
  


  Spread_Yuzde=BS_spread_yuzde;
  
if ( bs_comment ) {
Comment("Buy Sell Price",
"\n Tick Value:",BS_tickvalue,
"\n Tick Size:",BS_ticksize,
"\n Point:",MarketInfo(sym,MODE_POINT),
"\n Digits:",MarketInfo(sym,MODE_DIGITS),
"\n 1 Lot Reqired:",MarketInfo(sym,MODE_MARGINREQUIRED),
"\n 1 Lot Margin Level",NormalizeDouble(BS_margin_level,2),"%",
"\n Max Lot Buy:",NormalizeDouble(BS_max_buy_lot,2),
"\n Lot Step:",MarketInfo(sym,MODE_LOTSTEP),
"\n ///////////////////////////////",
"\n Balance:",DoubleToString(AccountBalance(),2),
"\n Equity:",DoubleToString(AccountEquity(),2),
"\n Margin:",DoubleToString(AccountMargin(),2),
"\n Free Margin:",DoubleToString(AccountInfoDouble(ACCOUNT_FREEMARGIN),2),"$",
"\n Margin Level:",DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2),"%",
"\n ///////////////////////////////",
"\n Spread:",BS_spread,
"\n Spread Price:",NormalizeDouble(BS_spread_price,2),
"\n Spread Percent: %",BS_spread_yuzde,
"\n Bar Status:",Mum_Hour_Volume_Result,
"\n ///////////////////////////////",
"\n Order Lot:",DoubleToString(bs_lot,2),
"\n Order Price:",DoubleToString(BS_lot_order_price,2),
"\n Order Spread:",DoubleToString(BS_order_spread_price,2),
"\n Order Next Margin:",DoubleToString(BS_order_margin_level,2),"%"
);
}

if ( !bs_comment ) {
bs_comment_info = StringConcatenate("Buy Sell Price",
"\n Tick Value:",BS_tickvalue,
"\n Tick Size:",BS_ticksize,
"\n Point:",MarketInfo(sym,MODE_POINT),
"\n Digits:",MarketInfo(sym,MODE_DIGITS),
"\n 1 Lot Price:",MarketInfo(sym,MODE_MARGINREQUIRED),
"\n 1 Lot Margin Level",NormalizeDouble(BS_margin_level,2),"%",
"\n Max Lot Buy:",NormalizeDouble(BS_max_buy_lot,2),
"\n Lot Step:",MarketInfo(sym,MODE_LOTSTEP),
"\n ///////////////////////////////",
"\n Balance:",DoubleToString(AccountBalance(),2),
"\n Eqity:",DoubleToString(AccountEquity(),2),
"\n Margin:",DoubleToString(AccountMargin(),2),
"\n Free Margin:",DoubleToString(AccountInfoDouble(ACCOUNT_FREEMARGIN),2),"$",
"\n Margin Level:",DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL),2),"%",
"\n ///////////////////////////////",
"\n Spread:",BS_spread,
"\n Spread Price:",NormalizeDouble(BS_spread_price,2),
"\n Spread Percent: %",BS_spread_yuzde,
"\n Bar Status:",Mum_Hour_Volume_Result,
"\n ///////////////////////////////",
"\n Order Lot:",DoubleToString(bs_lot,2),
"\n Order Price:",DoubleToString(BS_lot_order_price,2),
"\n Order Spread:",DoubleToString(BS_order_spread_price,2),
"\n Order Next Margin:",DoubleToString(BS_order_margin_level,2),"%"
);
}

string bs_bilgi = StringConcatenate(
"Lot:", DoubleToString(bs_lot,2),
",Price:" , DoubleToString(BS_lot_order_price,2) , 
",Spread:" , DoubleToString(BS_order_spread_price,2),
",Margin:",DoubleToString(BS_order_margin_level,2),"%",
",Spread Percent: %",BS_spread_yuzde,
",Bar Status:",Mum_Hour_Volume_Result
);

string bs_bilgi_sm = StringConcatenate(
"L:", DoubleToString(bs_lot,2),
",F:" , DoubleToString(BS_lot_order_price,2) , 
",S:" , DoubleToString(BS_order_spread_price,2),":",BS_spread_yuzde,
",M:",DoubleToString(BS_order_margin_level,0),"%",
",B:",Mum_Hour_Volume_Result_sm
);

//Alert(bs_result);

bs_bilgi = bs_bilgi;

bs_bilgi = bs_bilgi + " / 100 Pip:" + DoubleToString(PipPrice(sym,0,100,bs_lot),2) + "$";

if ( bs_result == "" ) {
bs_bilgi = bs_bilgi_sm;

bs_bilgi = bs_bilgi_sm + ",P:" + DoubleToString(PipPrice(sym,0,100,bs_lot),2) + "$";

}


//if ( bs_result == "SPREADYUZDE" ) bs_bilgi = DoubleToString(BS_spread_yuzde,2); 
//if ( bs_result == "MARGIN" ) bs_bilgi = DoubleToString(BS_order_margin_level,2); 

if ( bs_result == "SPREADYUZDE" ) bs_bilgi = BS_spread_yuzde; 
if ( bs_result == "MARGIN" ) bs_bilgi = BS_order_margin_level; 
if ( bs_result == "FIYAT" ) bs_bilgi = BS_lot_order_price; 

return bs_bilgi;

}
//////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}




void StopLevelFinder(double margin_buylot,double margin_selllot) {

bool freemargin_entry = false;
double account_equity=AccountEquity();
double account_freemargin = AccountFreeMargin();

     BALANCE=ObjectGetString(ChartID(),"LotSizeSell",OBJPROP_TEXT,0);
   double as_double_balance = (double) ObjectGetString(0,"Balance",OBJPROP_TEXT);
    if(as_double_balance !=0 && MathIsValidNumber(as_double_balance)){
    account_equity= as_double_balance;
    account_freemargin = as_double_balance;
    freemargin_entry = true;
    }

     //double margin_buylot = 0;
    //double margin_selllot = 0;
  double margin_buyprofit = 0;
 double margin_sellprofit = 0;
        double margin_lot = 0;
   bool margin_seviyeonay = false;   
   double MarjinSeviyesi = 0;
   double lot_maliyeti=MarketInfo(Symbol(),MODE_MARGINREQUIRED);
   double lot_margin_fiyati=0;
   double kalan_margin_fiyati=0;
   double onepipsprice = 0;
   double Pips_Price_valued;
   double kalan_para_pips;
   //double minumum_pip = 1;
 
   
             double  Fibo_Spread_Ask = MarketInfo(Symbol(),MODE_ASK);
            double Fibo_Spread_Bid = MarketInfo(Symbol(),MODE_BID);
            double Fibo_Spread=Fibo_Spread_Ask-Fibo_Spread_Bid;

    double margin_toplam_lot;    

margin_selllot = NormalizeDouble(margin_selllot,2);
 margin_buylot = NormalizeDouble(margin_buylot,2);
 margin_toplam_lot = MathAbs(margin_buylot-margin_selllot);
 double account_margin = margin_toplam_lot*lot_maliyeti;
 
 if ( margin_toplam_lot == 0 ) return;
 
 MarjinSeviyesi = NormalizeDouble((account_equity/account_margin)*100,2);
   
if ( margin_selllot == margin_buylot ) { margin_toplam_lot=margin_selllot; Print("Lotlar Eşit Seviyede"); }


if ( margin_selllot != 0 &&  margin_buylot != 0  ) { 

//Alert("Evet");


   if ( margin_selllot != margin_buylot ) { Print("Lotlar Farklı Seviyede");
   
   margin_toplam_lot=MathAbs(margin_buylot-margin_selllot);
   
   if (margin_toplam_lot < MarketInfo(Symbol(),MODE_MINLOT)) margin_toplam_lot = MarketInfo(Symbol(),MODE_MINLOT);
   
   if ( margin_buylot > margin_selllot ) margin_toplam_lot = margin_buylot-margin_selllot;

string lot_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
lot_margin_fiyati = StringToDouble(lot_marginfiyati);

if ( freemargin_entry ) account_freemargin=account_equity-lot_margin_fiyati;
   /*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}   */
   
         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         //if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = (account_freemargin/Pips_Price_valued)*minumum_pip;
         
         kalan_para_pips=kalan_para_pips-(Fibo_Spread/Point);
         
         int stoplevelpip=((account_equity/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;
         
         stoplevelpip=stoplevelpip-(Fibo_Spread/Point);
         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Bid+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH5",OBJ_HLINE,0,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Bid+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Bid+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH5",0,Time[1],Bid+stoplevelpip*Point);
         }
         

   if ( margin_selllot > margin_buylot ) margin_toplam_lot = margin_selllot-margin_buylot;
   

lot_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
lot_margin_fiyati = StringToDouble(lot_marginfiyati);

if ( freemargin_entry ) account_freemargin=account_equity-lot_margin_fiyati;   
/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}  */ 
   
         ///Pips_Price_valued = PipPrice(Symbol(),0,1,margin_toplam_lot);
         ///if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = (account_freemargin/Pips_Price_valued)*minumum_pip;    
         
         kalan_para_pips=kalan_para_pips-(Fibo_Spread/Point);     
         
         //stoplevelpip=((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;

         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);         
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid-stoplevelpip*Point);
         }         
            
   
   
   
   
    }
 
   }
//margin_toplam_lot = NormalizeDouble((AccountEquity()/lot_maliyeti)/4,2); // 100 // 4 25 lot buy 25 lot sell




/////////////////// ONLY SELL
if ( margin_selllot != 0 &&  margin_buylot == 0  ) { 
margin_toplam_lot=margin_selllot;


if (margin_toplam_lot < MarketInfo(Symbol(),MODE_MINLOT)) margin_toplam_lot = MarketInfo(Symbol(),MODE_MINLOT);

/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/
////////////////////////////////////////////////////
string lot_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
lot_margin_fiyati = StringToDouble(lot_marginfiyati);

if ( freemargin_entry ) account_freemargin=account_equity-lot_margin_fiyati;
/////////////////////////////////////////////

         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         ///if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = (account_freemargin/Pips_Price_valued)*minumum_pip;
         

            
            //Print(Fibo_Spread_Ask-Fibo_Spread_Bid);
            
            kalan_para_pips=kalan_para_pips-(Fibo_Spread/Point);
         
         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Ask+kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Ask);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Ask+kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Ask+kalan_para_pips*Point);
         }
         
         int stoplevelpip=((account_equity/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;
         int stoplevelpip50=((account_equity/MarjinSeviyesi)*(MarjinSeviyesi-50))/Pips_Price_valued;
         
         stoplevelpip=stoplevelpip-(Fibo_Spread/Point);
         stoplevelpip50=stoplevelpip50-(Fibo_Spread/Point);
         
         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid+stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_COLOR,clrBlack);
         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid+stoplevelpip50*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_COLOR,clrDarkBlue);         
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid+stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid+stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid+stoplevelpip50*Point);
         }    
         
         
                  
         
    }   


/////////////////// ONLY BUY
if ( margin_selllot == 0 &&  margin_buylot != 0  ) { 
margin_toplam_lot=margin_buylot;

if (margin_toplam_lot < MarketInfo(Symbol(),MODE_MINLOT)) margin_toplam_lot = MarketInfo(Symbol(),MODE_MINLOT);

string lot_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
lot_margin_fiyati = StringToDouble(lot_marginfiyati);

string kalan_marginfiyati = BuySellPrice(Symbol(),margin_toplam_lot,false,"FIYAT");
kalan_margin_fiyati = StringToDouble(kalan_marginfiyati);


if ( freemargin_entry ) account_freemargin=account_equity-lot_margin_fiyati;
/*
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,margin_toplam_lot);
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
}*/


         ///Pips_Price_valued = PipPrice(Symbol(),0,1,margin_toplam_lot);
         Pips_Price_valued = PipPrice(Symbol(),0,minumum_pip,margin_toplam_lot);
         ///if ( Pips_Price_valued == 0 ) Pips_Price_valued = PipPrice(Symbol(),0,2,margin_toplam_lot);
         //string Pips_Price_value = DoubleToString(Pips_Price_valued,2) + "$";
         
         kalan_para_pips = (account_freemargin/Pips_Price_valued)*minumum_pip;
         
         kalan_para_pips=kalan_para_pips-(Fibo_Spread/Point);

         
         if ( ObjectFind(ChartID(),"FinishMoney") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoney",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoney",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyH",OBJ_HLINE,0,Time[1],Bid-kalan_para_pips*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyH",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         } else {
         
         ObjectMove(ChartID(),"FinishMoney",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoney",1,Time[1],Bid-kalan_para_pips*Point);
         ObjectMove(ChartID(),"FinishMoneyH",0,Time[1],Bid-kalan_para_pips*Point);
         }
         
         
         
         int stoplevelpip=((account_equity/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued;
         int stoplevelpip50=((account_equity/MarjinSeviyesi)*(MarjinSeviyesi-50))/Pips_Price_valued;
         
         stoplevelpip=stoplevelpip-(Fibo_Spread/Point);
         stoplevelpip50=stoplevelpip50-(Fibo_Spread/Point);
         
         if ( ObjectFind(ChartID(),"FinishMoneyX") == -1 ) {
         
         ObjectCreate(ChartID(),"FinishMoneyX",OBJ_TRENDBYANGLE,0,Time[1],Bid,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_RAY,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectCreate(ChartID(),"FinishMoneyHX",OBJ_HLINE,0,Time[1],Bid-stoplevelpip*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX",OBJPROP_COLOR,clrBlack);

         ObjectCreate(ChartID(),"FinishMoneyHX5",OBJ_HLINE,0,Time[1],Bid-stoplevelpip50*Point);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_BACK,true);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTABLE,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_SELECTED,false);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(ChartID(),"FinishMoneyHX5",OBJPROP_COLOR,clrDarkBlue);
         
                  
         } else {
         
         ObjectMove(ChartID(),"FinishMoneyX",0,Time[1],Bid);
         ObjectMove(ChartID(),"FinishMoneyX",1,Time[1],Bid-stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX",0,Time[1],Bid-stoplevelpip*Point);
         ObjectMove(ChartID(),"FinishMoneyHX5",0,Time[1],Bid-stoplevelpip50*Point);
         }    

         
         
                  
         
         
    }   
    

      //((AccountEquity()/MarjinSeviyesi)*AccountStopoutLevel())/Pips_Price_valued
      
      
      
/*
Comment("Yeni Order",MarjinSeviyesi,
"\nBuy Lot:",margin_buylot,
"\nSELL Lot",margin_selllot,
"\nAccount Profit:",AccountProfit(),
"\nmargin_toplam_lot",margin_toplam_lot,
"\nmargin_buylot",margin_buylot,
"\nmargin_selllot",margin_selllot,
"\nlot_margin_fiyati",lot_margin_fiyati,
"\nkalan_margin_fiyati",kalan_margin_fiyati,
"\nStopOut Level",AccountStopoutLevel(),
"\nPips_Price_valued",Pips_Price_valued,
//"\nonepipsprice",onepipsprice,
"\nkalan_para_pips",kalan_para_pips//
//"\nSonra Hesap Patlar $",((AccountEquity()/MarjinSeviyesi)*(MarjinSeviyesi-AccountStopoutLevel()))/Pips_Price_valued //(AccountEquity()-(((AccountEquity()/MarjinSeviyesi)/Pips_Price_valued)*AccountStopoutLevel()))
);*/

/*
equity/margin_level = %1 parasal

margin_level - stop_out level = 80-10 = 70

( 70 * %1 parasal ) / pip_price = kaç pip olduğu çıkıyor
*/








if ( margin_selllot == 0 &&  margin_buylot == 0  ) { 
if ( ObjectFind(ChartID(),"FinishMoney") != -1 ) {
ObjectDelete(ChartID(),"FinishMoney");
ObjectDelete(ChartID(),"FinishMoneyH");
ObjectDelete(ChartID(),"FinishMoneyH5");
ObjectDelete(ChartID(),"FinishMoneyX");
ObjectDelete(ChartID(),"FinishMoneyHX");
ObjectDelete(ChartID(),"FinishMoneyHX5");
}
}   

}





string symbolfind(string sym) {

Print(sym,":",MarketInfo(sym,MODE_PROFITCALCMODE));

string sembol="";
string sym_periyod = "";
bool symbol_find = false; 

      string pairs[];
      ///int length = getAvailableCurrencyPairss(pairs);
      int length = market_watch_list(pairs);
      
      //Print("length:",length);
      
      for(int i=0; i <= length-1; i++)
      {
         
         

 string pair = pairs[i];
int replaced = StringReplace(pair,".","");
    replaced+= StringReplace(pair,"+",""); 
    
    
     
     
   if ( sym_periyod == "" ) {  
   string sep="-";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sym,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   sym = results[0];
   sym_periyod = results[1];   
   }
   }
       
    
      
///////////////////////////////////////////////////
//// coklu Kurlarda Diger Kuru cikaracak Kelimeler
//// eurusd,eurusdpro
///////////////////////////////////////////////////    
string bad_word = "pro";   
int indexbw=StringFind(pair, bad_word, 0); 
            
int index=StringFind(pair, sym, 0);
//int index=StringFind(sym,pair, 0);

indexbw = -1;

// // Bu olunca Bulamadi WTI de MODE_TRADEALLOWED gormuyor sonuc olumsuz
//if( (index!=-1 && MarketInfo(pairs[i],MODE_TRADEALLOWED)) || (index!=-1 && MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 1 )){
if( indexbw == -1 && index!=-1 && ( MarketInfo(pairs[i],MODE_TRADEALLOWED) || MarketInfo(pairs[i],MODE_PROFITCALCMODE) == 1 )){
symbol_find = true;
sembol = pairs[i];
if ( sym_periyod != "" ) sembol = sembol + "-" + sym_periyod;
//Print("pair  ",pair,"=",sym," sym");
//Print("Db Sembol",symboldbfind(sym));
//break;
}

//int indexx=StringFind(pair, sym, 0);        
//if ( indexx != -1 && sym == "WTI" ) Alert("Pair #", i+1, ": ", pairs[i]," Paid Rep:",pair,"WTI:",indexx," / Sym:",sym);         
   
     
         
      }
      
/*      
if (sym=="US30") { sembol = "US30"; };      
if (sym=="WTI") { sembol = "WTI"; };
if (sym=="OIL.WTI+") { sembol = "WTI"; };
if (sym=="US.30+") { sembol = "US.30+"; };           
*/
     
if (symbol_find==false) {
sembol="XXX";
//Print("Not Find Sym:",sym);
};

      //Print(sembol,":",sym_periyod);
return sembol;   

}


int getAvailableCurrencyPairss(string& availableCurrencyPairs[])
{
//---   
   bool selected = false;
   const int symbolsCount = SymbolsTotal(selected);
   int currencypairsCount;
   ArrayResize(availableCurrencyPairs, symbolsCount);
   int idxCurrencyPair = 0;
   for(int idxSymbol = 0; idxSymbol < symbolsCount; idxSymbol++)
     {      
         string symbol = SymbolName(idxSymbol, selected);
         
         //if ( MarketInfo(symbol,MODE_BID) > 0) {
         //if ( MarketInfo(symbol,MODE_PROFITCALCMODE) == 0 ) {
         //Print(idxSymbol,") symbol = ",symbol);
         //}
         //}
         //if(IsTradeAllowed()) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         //Print(symbol,"=",MarketInfo(symbol,MODE_TRADEALLOWED));
         //if( MarketInfo(symbol,MODE_TRADEALLOWED) ) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         
         
         //string firstChar = StringSubstr(symbol, 0, 1);
         //if(firstChar != "#" && StringLen(symbol) == 6)
         availableCurrencyPairs[idxCurrencyPair++] = symbol; 
     
     }
     currencypairsCount = idxCurrencyPair-1;
     
     //Print(idxCurrencyPair); 
     ArrayResize(availableCurrencyPairs, currencypairsCount);
     return currencypairsCount;
}

// Market Watch List - Piyasa Gozlem Kur Listesi
int market_watch_list(string& availableCurrencyPairs[])
{
   int idxCurrencyPair = 0;
   int HowManySymbols=SymbolsTotal(true);
   ArrayResize(availableCurrencyPairs, HowManySymbols);
   string ListSymbols=" ";
   for(int i=0;i<HowManySymbols;i++)
     {
      ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),"\n");
      //Print("SymbolName(i,true)",SymbolName(i,true));
      string symbol = SymbolName(i,true);
      
      availableCurrencyPairs[idxCurrencyPair++] = symbol;

      
     }
     
     HowManySymbols=idxCurrencyPair-1;

     //Print("HowManySymbols",HowManySymbols);
    
return HowManySymbols;
    
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


string MouseState(uint state)
  {
   string res;
   res+="\nML: "   +(((state& 1)== 1)?"DN":"UP");   // mouse left
   res+="\nMR: "   +(((state& 2)== 2)?"DN":"UP");   // mouse right 
   res+="\nMM: "   +(((state&16)==16)?"DN":"UP");   // mouse middle
   res+="\nMX: "   +(((state&32)==32)?"DN":"UP");   // mouse first X key
   res+="\nMY: "   +(((state&64)==64)?"DN":"UP");   // mouse second X key
   res+="\nSHIFT: "+(((state& 4)== 4)?"DN":"UP");   // shift key
   res+="\nCTRL: " +(((state& 8)== 8)?"DN":"UP");   // control key
   return(res);
  }
  
  
  


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// TOPLAM KAZANc BUGuN AcILAN isLEMLER - OrderHistoryTotalProfits
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double OrderHistoryTotalProfits(string cmt){

if ( OrdersHistoryTotal() == 0 ) return 0;

double commis=0;
int islem_say = 0;

//secilen comments tipinin ne kadar kazandigida ogrenilebilir

           double profitx = 0;
   for(int cnt=0; cnt<OrdersHistoryTotal(); cnt++)
   {
         OrderSelect(cnt,SELECT_BY_POS, MODE_HISTORY);
         
         //Print(TimeToStr(TimeCurrent(),TIME_DATE));
         //Print(TimeToStr(OrderCloseTime(),TIME_DATE));
         //Print(TimeToStr(OrderOpenTime(),TIME_DATE));
         
         //if ( TimeToStr(TimeCurrent(),TIME_DATE) == TimeToStr(OrderCloseTime(),TIME_DATE) )
         
         // Acilis ve Kapanisi Bugun Olan islemlerRobotZamanOnaylama(OrderOpenTime()) == true &&
         //if ( OrderType() < 2 && TimeToStr(TimeCurrent(),TIME_DATE) == TimeToStr(OrderCloseTime(),TIME_DATE) && TimeToStr(TimeCurrent(),TIME_DATE) == TimeToStr(OrderOpenTime(),TIME_DATE)  )
         if ( OrderType() < 2 && TimeToStr(TimeCurrent(),TIME_DATE) == TimeToStr(OrderCloseTime(),TIME_DATE) )
         {
         ///////////////////////////////////////////////////////////////////////////////////////
         /*RobotZamanOnay = false;         
         if ( RobotBaslamaZamaniKontrol == true && OrderOpenTime() >= RobotBaslamaZamani ) { RobotZamanOnay = true; }         
         if ( RobotBaslamaZamaniKontrol == false ) { RobotZamanOnay = true; }
         && RobotZamanOnay == true*/
         ///////////////////////////////////////////////////////////////////////////////////////
            
            //Alert(OrderComment()+OrderProfit());
            //Yorum Yani Order Profit Bos Degilse
            
            /*
            if(OrderComment()==cmt){
            profitx = profitx + OrderProfit();
            };*/
            
           
            
            /*if ( cmt != "" ) {
            
            if(OrderComment()==cmt){
            if ( OrderSymbol() == Symbol() && OrderProfit() > 0  ) profitx = profitx + OrderProfit();
            if ( OrderSymbol() == Symbol() && OrderProfit() < 0  ) profitx = profitx - OrderProfit();
            };*/
            
            
            /*
            int indexp=StringFind(OrderComment(), cmt, 0);

if(indexp!=-1){
//Sadece Secilen Toplami
profitx = profitx + OrderProfit();
};*/
            
            
            //} else {
            //Genel Gecmis Toplami
            
            
            
            //if ( OrderSymbol() == Symbol()) 
            profitx = profitx + OrderProfit();
            //if ( OrderProfit() > 0  ) profitx = profitx + OrderProfit();
            //if ( OrderProfit() < 0  ) profitx = profitx - OrderProfit();
            islem_say=islem_say+1;
            commis = commis+OrderCommission();
            //Print(islem_say+"/"+OrderTicket(),"/",OrderProfit());
            //};
            
            
            
         };
   };
   
   //Alert(commis+"/"+islem_say+"/"+profitx+"/"+commis);
   
   profitx=profitx-MathAbs(commis);
   
   
  
return profitx;
};

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 


//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
int OrderCommetssType(string cmt,string sym,int typ){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderType() == typ || typ==-1) {

/*if ( OrderSymbol() == sym ) {
Print("Sym",sym,"/",OrderSymbol(),"Comment",cmt,"/",OrderComment(),"Index:",index);
com++;
}*/

if(index!=-1 && (OrderSymbol() == sym || sym == "*")){com++;}; // Hatali Calisiyor
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && (OrderSymbol() == sym || sym == "*") ){com++;};
}
}



return com;
};
  
  
void CloseAllPenOrders(string sym)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() > 1 && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}

void CloseAllPenOrdersTyp(string sym,int ord_typ)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == ord_typ && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}


void CloseOrders(string cmt,int ord_type)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( (( cmt !="" && StringFind(OrderComment(),cmt,0) != -1 ) || cmt == "" ) &&   OrderType() == ord_type && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magicbuy
         )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}



void CloseAllBuyOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
         }
      }
   }
}

void CloseAllOrders()
{
   CloseAllBuyOrders();
   CloseAllSellOrders();
}  


//////////////////////////////////////////////////////

void AlertOrders() {

/////////////////////////////////////////////////////////////
   for (int bbb = ObjectsTotal() - 1; bbb >= 0; --bbb)
   {
      const string objName = ObjectName(0,bbb);
   
      //if (StringFind(objName,"autotrade") > -1)
      if (StringFind(objName,"OrderClose") > -1)
      {
         ObjectDelete(0,objName);
      }
   }
////////////////////////////////////////////////////////////   
   
int t=0;

//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderSymbol() != Symbol() ) continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
///if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
//if ( OrderSymbol() == sym && OrderType() == typ && OrderMagicNumber() == magic ) {
//com++;

int shift=iBarShift(Symbol(),Period(),OrderOpenTime());

t=t+1;

   string name="OrderClose"+OrderTicket();  
   ObjectDelete(ChartID(),name);      
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,OrderOpenTime(),OrderOpenPrice(),OrderOpenTime()+10*PeriodSeconds(),OrderOpenPrice());
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,OrderOpenTime()+t*PeriodSeconds(),High[shift],OrderOpenTime()+(t+1)*PeriodSeconds(),Low[shift]);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,OrderOpenTime()+t*PeriodSeconds(),OrderOpenPrice(),OrderOpenTime()+((t+1)*PeriodSeconds()),OrderOpenPrice());
   ObjectCreate(ChartID(),name,OBJ_TREND,0,OrderOpenTime(),OrderOpenPrice(),OrderOpenTime()+PeriodSeconds(),OrderOpenPrice());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   if ( StringFind(OrderComment(),"CasperSell",0) != -1 ) ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,OrderComment());
   if ( StringFind(OrderComment(),"CasperSell",0) != -1 ) ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   

///}
}


}


void LiveOrderClose(int OrdTicket) {


OrderDelete(OrdTicket,clrNONE);
string name="OrderClose"+OrderTicket();  
ObjectDelete(ChartID(),name);

for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderTicket() == OrdTicket ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);

   string name="OrderClose"+OrderTicket();  
   ObjectDelete(ChartID(),name);

}

}
}
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Casper Level Order
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void CasperClose(string cmt) {


//string cmt="CasperSell";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1  &&   OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         int replace=StringReplace(ordcmt,"CasperSell","");
         
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    

int ordticket=StringToInteger(ordcmt);

//Alert(ordticket);
    
    
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderTicket() == ordticket &&  OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         //string ordcmt=OrderComment();
         //int replace=StringReplace(ordcmt,cmt,"");
         
         
         Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    


}