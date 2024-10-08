//+------------------------------------------------------------------+
//|                                                          Efe.mq4 |
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


string last_select_object;
int last_select_len;
string last_object;
bool system=true;
bool flag_mode = false; 

int ObjTotal = ObjectsTotal(ChartID(),-1,-1);


ENUM_TIMEFRAMES select_per=Period();

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   string symi=Symbol();
   ENUM_TIMEFRAMES peri=Period();   
   

double Openi(int shifti) {
return iOpen(symi,peri,shifti);
}

double Closei(int shifti) {
return iClose(symi,peri,shifti);
}

double Highi(int shifti) {
return iHigh(symi,peri,shifti);
}

double Lowi(int shifti) {
return iLow(symi,peri,shifti);
}

double Timei(int shifti) {
return iTime(symi,peri,shifti);
}

double Ortalama;

string error_line_name="";

bool pattern50=true;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---


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
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 105);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 20);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 103);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 20); 
     
         
     } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     //}  
     

if ( system == false ) {
Comment("Sistem Kapalı, S harine basıp açabilirsin");

}

//Alert("System:",system);

//Pat();

   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+





void OnTick()
  {
//---
   
   if ( OrdersTotal() > 0 ) {
   
   ObjectsDeleteAll(ChartID(),-1,OBJ_TEXT);
   OrderRiskReward();
   ChartRedraw();
   
   }
   
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



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Trendx",0) != -1 ) {
      
string select_object=sparam;
string select_object_y=sparam;
string select_object_l=sparam;
string select_object_q=sparam;
int rplc=StringReplace(select_object_y,"Trendx","Trendy");
int rplcl=StringReplace(select_object_l,"Trendx","Trendl");
int rplcq=StringReplace(select_object_q,"Trendx","Trendq");

          
          datetime obj_time1 = ObjectGetInteger(ChartID(),select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),select_object,OBJPROP_TIME,1);
          double obj_prc1 = ObjectGetDouble(ChartID(),select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),select_object,OBJPROP_PRICE,1);

          datetime obj_time1_y = ObjectGetInteger(ChartID(),select_object_y,OBJPROP_TIME,0);
          datetime obj_time2_y = ObjectGetInteger(ChartID(),select_object_y,OBJPROP_TIME,1);
          double obj_prc1_y = ObjectGetDouble(ChartID(),select_object_y,OBJPROP_PRICE,0);
          double obj_prc2_y = ObjectGetDouble(ChartID(),select_object_y,OBJPROP_PRICE,1);

          datetime obj_time1_l = ObjectGetInteger(ChartID(),select_object_l,OBJPROP_TIME,0);
          datetime obj_time2_l = ObjectGetInteger(ChartID(),select_object_l,OBJPROP_TIME,1);
          double obj_prc1_l = ObjectGetDouble(ChartID(),select_object_l,OBJPROP_PRICE,0);
          double obj_prc2_l = ObjectGetDouble(ChartID(),select_object_l,OBJPROP_PRICE,1);

          datetime obj_time1_q = ObjectGetInteger(ChartID(),select_object_q,OBJPROP_TIME,0);
          datetime obj_time2_q = ObjectGetInteger(ChartID(),select_object_q,OBJPROP_TIME,1);
          double obj_prc1_q = ObjectGetDouble(ChartID(),select_object_q,OBJPROP_PRICE,0);
          double obj_prc2_q = ObjectGetDouble(ChartID(),select_object_q,OBJPROP_PRICE,1);





Print(select_object);


double high_price;
double low_price;



if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam");

/*
int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,High[shift]);
high_price=High[shift];
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,Low[shift]);
low_price=Low[shift];*/


int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,High[shift]);
high_price=High[shift];
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,Low[shift]);
low_price=Low[shift];


ObjectMove(ChartID(),select_object_y,0,obj_time2,Low[shift]);
ObjectMove(ChartID(),select_object_y,1,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));


ObjectMove(ChartID(),select_object_l,0,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));
ObjectMove(ChartID(),select_object_l,1,obj_time2+((obj_time2_y-obj_time1_y)*9),Low[shift]+(obj_prc2_y-obj_prc1_y));


ObjectMove(ChartID(),select_object_q,0,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));
ObjectMove(ChartID(),select_object_q,1,(obj_time2+((obj_time2_y-obj_time1_y))+(obj_time2-obj_time1)),(Low[shift]+(obj_prc2_y-obj_prc1_y))-(high_price-low_price));





//datetime ty_start_time=obj_time1;
//datetime ty_end_time=obj_time1+300*PeriodSeconds();

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0;    
   
   double level;
   string levels;
   string name=last_select_object+"Pattern5 ";
    
   
  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);   
      
       
       }
          


/////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc2 > obj_prc1 ) {
/*
int shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,High[shift]);
high_price=High[shift];
shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,Low[shift]);
low_price=Low[shift];*/

int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,Low[shift]);
low_price=Low[shift];
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,High[shift]);
high_price=High[shift];



ObjectMove(ChartID(),select_object_y,0,obj_time2,High[shift]);
ObjectMove(ChartID(),select_object_y,1,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));

ObjectMove(ChartID(),select_object_l,0,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));
ObjectMove(ChartID(),select_object_l,1,obj_time2+((obj_time2_y-obj_time1_y)*9),High[shift]-(obj_prc1_y-obj_prc2_y));


ObjectMove(ChartID(),select_object_q,0,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));
ObjectMove(ChartID(),select_object_q,1,(obj_time2+((obj_time2_y-obj_time1_y))+(obj_time2-obj_time1)),(High[shift]-(obj_prc1_y-obj_prc2_y))+(high_price-low_price));




//datetime ty_start_time=obj_time1;
//datetime ty_end_time=obj_time1+300*PeriodSeconds();

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=high_price-yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=high_price-yuzde*70; // 50
   double level79=high_price-yuzde*79; // 50
   double level21=high_price-yuzde*21; // 50
   double level30=high_price-yuzde*30; // 50
   double level50=high_price-yuzde*50; // 50
   double level786=high_price-yuzde*78.6; // 50
   double level618s=high_price-yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0;    
   
   double level;
   string levels;
   string name=last_select_object+"Pattern5 ";
    
   
  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level100;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price-level,ty_end_time,high_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);   
      
       
       }











ChartRedraw(ChartID());

}



//if ( pattern50 == true ) Pattern5(sparam);

if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TEXT ) {

string OrderTickets=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
string sparams=sparam;
int Rep=StringReplace(sparams,"Order","");
Rep+=StringReplace(sparams,"SL","");
Rep+=StringReplace(sparams,"TP","");


Print("OrderTicket",int(sparams),"/",sparam);

  if(OrderSelect(int(sparams), SELECT_BY_TICKET)==true)
    {
     Print("order #12470 open price is ", OrderOpenPrice());
     Print("order #12470 close price is ", OrderClosePrice());
     
     
     
     long ticket=OrderClose(int(sparams),NormalizeDouble(OrderLots()/2,2),OrderClosePrice(),0,clrNONE);
     //Sleep(100);
     //OrderModify(ticket,OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),-1,clrNONE);
     
     ObjectsDeleteAll(ChartID(),-1,OBJ_TEXT);
     
    }
  else
    Print("OrderSelect returned the error of ",GetLastError());
    
    

//Print(sparams);


}


//Print(sparam);

          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE),MarketInfo(Symbol(),MODE_DIGITS));
          CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment("Fiyat Hafızası:",HLinePrice);
          }
          
          

if ( sparam == 19 ) { // r

select_per=Period();
OnInit();

}


          
////////////////////////////////////////////////////////////////////////////////////////
// TRADE LEVEL
///////////////////////////////////////////////////////////////////////////////////////
  if ( sparam == 20 ) { // t
  if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == true ) {  
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,false);
  } else { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,true);
  }
  
  ObjectsDeleteAll(ChartID(),-1,OBJ_TEXT);

  }    
  
  
  

    if ( ObjTotal!=ObjectsTotal(ChartID()) ) AlertObject();
 ObjTotal = ObjectsTotal(ChartID());


if ( sparam == 33 ) {


if ( flag_mode == true ) {flag_mode=false;



} else {flag_mode=true;


}

Comment("Flag Mode:",flag_mode);


}



if ( sparam == 38 ) { //l

last_select_object="";
Comment("Obje:",last_select_object);
}

if ( sparam == 31 ) { //s


if ( system == true ) { system=false; } else { system=true;}

Comment("System:",system);


}

if ( sparam == 45 ) {ObjectsDeleteAll(ChartID(),-1,-1);

last_select_object="";

}


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND //&& last_select_object==""  
&& system==true && flag_mode ==true ) {

last_select_object=sparam;
last_select_len=StringLen(sparam);


//Alert("Selam");


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

/////////////////////////////////////////////////////////////////////////////////////
// Up Down
/////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc1 > obj_prc2 ) {

ObjectMove(ChartID(),sparam,0,obj_time1,High[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,Low[shift2]);

obj_prc1=High[shift1];
obj_prc2=Low[shift2];

int high_shift_time=shift1;

  if ( flag_mode == true ) double flag5=FlagUpDown(High[shift1],Low[shift2],sparam,high_shift_time,"","Left");  



}


///////////////////////////////////////////////
// Down Up
///////////////////////////////////////////////
if ( obj_prc2 > obj_prc1 ) {







ObjectMove(ChartID(),sparam,0,obj_time1,Low[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,High[shift2]);

obj_prc1=Low[shift1];
obj_prc2=High[shift2];


int low_shift_time=shift1;

if ( flag_mode == true ) double flag5=FlagDownUp(High[shift2],Low[shift1],sparam,low_shift_time,"","Left");



}


}

////////////////////////////////////////////////////////////////////
int slen=StringLen(sparam);
int sof = StringFind(sparam,last_select_object, 0);
int oof = StringFind(sparam,"#", 0);
bool obj_lines=false;

if ( sof != -1 && slen > last_select_len ) obj_lines=true;

string obj_text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);  
string obj_tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);      

///////////////////////////////////////////////////////////////////

//&& StringFind(sparam,"VeryHLPrice",0) != -1
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND //&& last_select_object==""  
&& system==true && flag_mode == false && obj_lines == false && obj_text=="" && oof == -1  && obj_tooltip == "" ) {

last_select_object=sparam;
last_select_len=StringLen(sparam);


//Alert("Selam");

if ( pattern50 == true ) Pattern5(sparam);


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


if ( obj_prc1 > obj_prc2 ) {

if ( Open[shift2] > Close[shift2] && Close[shift2-1] > Open[shift2-1] && Close[shift2-2] > Open[shift2-2] ) {

} else {
//Alert("Hatalı Seçim2");

int cevap=0;
 if ( error_line_name != sparam ) cevap=MessageBox("Hatalı seçim yaptınız, düzeltilsin mi ? ","Düzeltme",4); //  / Spread:"+Spread_Yuzde+"%"
 if ( cevap == 6 ) {
bool find=false;
for (int i=shift2-1;i>=shift1;i--) {
if ( Open[i] > Close[i] && Close[i-1] > Open[i-1] && Close[i-2] > Open[i-2] && find == false ) {
find=true;
shift2=i;
obj_time2=Time[shift2];
ObjectDelete(ChartID(),"VS");
//ObjectCreate(ChartID(),"VS",OBJ_VLINE,0,Time[i],Ask);
}

}
} else {
error_line_name=sparam;
}




}




ObjectMove(ChartID(),sparam,0,obj_time1,High[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,Low[shift2]);

obj_prc1=High[shift1];
obj_prc2=Low[shift2];

double fark=((obj_prc1-obj_prc2)/60);
double farks=((obj_prc1-obj_prc2)/30);

double prc100=Low[shift2]-(fark*100);
double prc130=Low[shift2]-(farks*100);

double prc_farks=DivZero((prc100-prc130),100);

Comment("Fark:",(obj_prc1-obj_prc2)/Point,"/ Kazanç:",fark/Point);


//Alert("Selam");


double low_price=Low[shift1];
int low_shift=shift1;
bool find=false;
int high_say=0;

for(int i=shift1-1;i>0;i--) {
if ( find == false ) {
if ( Low[i] < low_price ) {
low_price=Low[i];
low_shift=i;
high_say=0;
}
else {
high_say=high_say+1;
if ( high_say == 20 ) find=true;
}
}


/*
if ( low_price <= prc100 ) {
find=true;
}*/


}


//Alert(high_say,"/",low_shift,"/",low_price);




if ( low_price <= prc100 && low_price >= prc130 &&

find==true

 ) {

//Alert("Selam",high_price,"/",high_shift);

string name=sparam+"-SwingLow";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[low_shift],low_price,Time[low_shift]+10*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingLows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[low_shift]+10*PeriodSeconds(),low_price,Time[low_shift]+30*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingLowss";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],Low[shift2],Time[low_shift],low_price);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-LowHighsEq";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[low_shift]+30*PeriodSeconds(),Low[shift2],Time[low_shift]+50*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/2));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingLowsTarget";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[low_shift]+50*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/2),Time[low_shift]+70*PeriodSeconds(),Low[shift2]+((Low[shift2]-low_price)/2));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-SwingLowsRect";
ObjectDelete(ChartID(),name);
//ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[low_shift]+50*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/2),Time[low_shift]+5*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/1.5));
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[low_shift]+45*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/2),Time[low_shift]+55*PeriodSeconds(),Low[shift2]-((Low[shift2]-low_price)/1.5));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);


}
















string name=sparam+"-LowTp";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,Low[shift2],obj_time1,prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-LowRec";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,obj_time1,prc130+prc_farks*45,obj_time1+500*PeriodSeconds(),prc130+prc_farks*55);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sparam+"-LowRecSS";//clrSteelBlue
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,obj_time2,High[shift2+1],obj_time1+500*PeriodSeconds(),Low[shift2+1]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);



name=sparam+"-LowTpT";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc100,obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-LowTp30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc100,obj_time1,prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-LowTpT30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130,obj_time1+100*PeriodSeconds(),prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-LowTpTEnd";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130-(prc100-prc130),obj_time1+100*PeriodSeconds(),prc130-(prc100-prc130));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);





name=sparam+"-LowTpT30100";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130,obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);

name=sparam+"-LowTpT301000";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1+100*PeriodSeconds(),prc130,obj_time1+200*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);

name=sparam+"-LowTpT3010000";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1+100*PeriodSeconds(),prc100,obj_time1+200*PeriodSeconds(),prc100+(prc100-prc130));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);



name=sparam+"-Low";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,Low[shift2],obj_time1,Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-Lows";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,Low[shift2],obj_time2+300*PeriodSeconds(),Low[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);



name=sparam+"-High";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,High[shift1],obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-High30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,High[shift1],obj_time1+100*PeriodSeconds(),prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

}




if ( obj_prc2  > obj_prc1) {

if ( Close[shift2] > Open[shift2] && Open[shift2-1] > Close[shift2-1] && Open[shift2-2] > Close[shift2-2] ) {

} else {
//Alert("Hatalı Seçim");

int cevap=0;
 if ( error_line_name != sparam )  cevap=MessageBox("Hatalı seçim yaptınız, düzeltilsin mi ? ","Düzeltme",4); //  / Spread:"+Spread_Yuzde+"%"
 if ( cevap == 6 ) {
/////////////////////////////////////////////////////////////////////////////////////////////////
bool find=false;
for (int i=shift2-1;i>=shift1;i--) {
if ( Close[i] > Open[i] && Open[i-1] > Close[i-1] && Open[i-2] > Close[i-2] && find == false ) {
find=true;
shift2=i;
obj_time2=Time[shift2];
//ObjectDelete(ChartID(),"VS");
//ObjectCreate(ChartID(),"VS",OBJ_VLINE,0,Time[i],Ask);
}
}
//////////////////////////////////////////////////////////////////////////////////////////////////
} else {
error_line_name=sparam;
}




}


ObjectMove(ChartID(),sparam,0,obj_time1,Low[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,High[shift2]);

obj_prc1=Low[shift1];
obj_prc2=High[shift2];

double fark=((obj_prc2-obj_prc1)/60);
double farks=((obj_prc2-obj_prc1)/30);

double prc100=High[shift2]+(fark*100);
double prc130=High[shift2]+(farks*100);

double prc_farks=DivZero((prc130-prc100),100);


Comment("Fark:",(obj_prc2-obj_prc1)/Point,"/ Kazanç:",fark/Point);





double high_price=High[shift1];
int high_shift=shift1;
bool find=false;
int low_say=0;
for(int i=shift1-1;i>0;i--) {

//if ( find == true ) continue;
if ( find == false ) {
if ( High[i] > high_price  ) {
high_price=High[i];
high_shift=i;
low_say=0;
} else {
low_say=low_say+1;
if ( low_say == 20 ) find=true;
}
}

/*
if ( high_price >= prc100 ) {
find=true;
}*/


}

//Alert(low_say,"/",high_shift,"/",high_price);




if ( high_price >= prc100 && high_price <= prc130 &&

find==true

 ) {

//Alert("Selam",high_price,"/",high_shift);

string name=sparam+"-SwingHigh";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[high_shift],high_price,Time[high_shift]+10*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingHighs";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[high_shift]+10*PeriodSeconds(),high_price,Time[high_shift]+30*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingHighss";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift2],High[shift2],Time[high_shift],high_price);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingHighsEq";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[high_shift]+30*PeriodSeconds(),High[shift2],Time[high_shift]+50*PeriodSeconds(),High[shift2]+((high_price-High[shift2])/2));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-SwingHighsTarget";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[high_shift]+50*PeriodSeconds(),High[shift2]+((high_price-High[shift2])/2),Time[high_shift]+70*PeriodSeconds(),High[shift2]-((high_price-High[shift2])/2));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-SwingHighsRect";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[high_shift]+50*PeriodSeconds(),High[shift2]+((high_price-High[shift2])/2),Time[high_shift]+5*PeriodSeconds(),High[shift2]+((high_price-High[shift2])/1.5));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);


}




string name=sparam+"-HighTp";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,High[shift2],obj_time1,prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-HighRec";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,obj_time1,prc130-prc_farks*45,obj_time1+500*PeriodSeconds(),prc130-prc_farks*55);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sparam+"-HighRecSS";//clrSteelBlue
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,obj_time2,High[shift2+1],obj_time1+500*PeriodSeconds(),Low[shift2+1]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);

name=sparam+"-HighTpT";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc100,obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-HighTp30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc100,obj_time1,prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-HighTpT30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130,obj_time1+100*PeriodSeconds(),prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-HighTpTEnd";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130+(prc130-prc100),obj_time1+100*PeriodSeconds(),prc130+(prc130-prc100));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);



name=sparam+"-HighTpT30100";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,prc130,obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);


name=sparam+"-HighTpT301000";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1+100*PeriodSeconds(),prc130,obj_time1+200*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);

name=sparam+"-HighTpT3010000";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1+100*PeriodSeconds(),prc100,obj_time1+200*PeriodSeconds(),prc100+(prc100-prc130));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);



name=sparam+"-High";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,High[shift2],obj_time1,High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-Highs";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,High[shift2],obj_time2+300*PeriodSeconds(),High[shift2]);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_SOLID);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);



name=sparam+"-Low";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,Low[shift1],obj_time1+100*PeriodSeconds(),prc100);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-Low30";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,Low[shift1],obj_time1+100*PeriodSeconds(),prc130);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

}





  int obj_total=ObjectsTotal(ChartID(),-1,-1);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i,-1,-1);
     

     //int bindex = StringFind(name, "Haber", 0);
     
     //int len=StringLen(name);
     
     //string obj_num=StringSubstr(name,len-lens,lens);

      int sof = StringFind(name,last_select_object, 0);


     //if ( StringSubstr(name,0,1) == "F" && obj_num == num ) {
     
     if ( sof != -1 && last_select_object != name ) {
     
     string obj_text=ObjectGetString(ChartID(),name,OBJPROP_TEXT);
     datetime obj_time2=ObjectGetInteger(ChartID(),name,OBJPROP_TIME,1);
     ObjectSetString(ChartID(),name,OBJPROP_TEXT,last_select_object);    
     
     /*
     if ( obj_text == "" ) {     
     ObjectSetString(ChartID(),name,OBJPROP_TEXT,int(obj_time2));    
     ObjectSetInteger(ChartID(),name, OBJPROP_TIME,1, Time[0]+1000*PeriodSeconds()); 
     //ObjectSetInteger(ChartID(),name, OBJPROP_TIME,1, Time[0]+1000*PeriodSeconds()); 
     } else {
     ObjectSetString(ChartID(),name,OBJPROP_TEXT,"");    
     ObjectSetInteger(ChartID(),name, OBJPROP_TIME,1, int(obj_text));      
     }*/
     
     
     }
     
    }


return;

/////////////////////////////////////////////////////////////////////////////////////
// Up Down
/////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc1 > obj_prc2 ) {

ObjectMove(ChartID(),sparam,0,obj_time1,High[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,High[shift2]);

obj_prc1=High[shift1];
obj_prc2=High[shift2];

int high_shift_time=shift1;

  if ( flag_mode == true ) double flag5=FlagUpDown(High[shift1],Low[shift2],sparam,high_shift_time,"","Left");  



//Comment("Obje:",sparam);




//double fark=obj_prc1-obj_prc2;
double fark=((obj_prc1-obj_prc2)/100)*60;

Comment("Fark:",(obj_prc1-obj_prc2)/Point,"/ Kazanç:",fark/Point);

string name;


name=sparam+"-High";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time1,obj_prc1,obj_time1+15000*PeriodSeconds(),obj_prc1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-HighEQ";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc1-(obj_prc1-obj_prc2)/2,obj_time1+15000*PeriodSeconds(),obj_prc1-(obj_prc1-obj_prc2)/2);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-HighEQSL";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2+(((obj_prc1-obj_prc2)/100)*21),obj_time1+15000*PeriodSeconds(),obj_prc2+(((obj_prc1-obj_prc2)/100)*21));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);



for (int i=0;i<5;i++) {



name=sparam+"-Low-"+i;
ObjectDelete(ChartID(),name);
if ( i > 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2-(fark*i),obj_time1+15000*PeriodSeconds(),obj_prc2-(fark*i));
if ( i == 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2,obj_time1+15000*PeriodSeconds(),obj_prc2);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
if ( i > 0 ) ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

}



double farks=((obj_prc1-obj_prc2)/100)*30;

for (int i=0;i<5;i++) {

name=sparam+"-LowEq-"+i;
ObjectDelete(ChartID(),name);
if ( i > 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2-(fark*i)+farks,obj_time1+15000*PeriodSeconds(),obj_prc2-(fark*i)+farks);
if ( i == 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2-farks,obj_time1+15000*PeriodSeconds(),obj_prc2-farks);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

}





}
///////////////////////////////////////////////
// Down Up
///////////////////////////////////////////////
if ( obj_prc2 > obj_prc1 ) {



ObjectMove(ChartID(),sparam,0,obj_time1,Low[shift1]);
ObjectMove(ChartID(),sparam,1,obj_time2,Low[shift2]);

obj_prc1=Low[shift1];
obj_prc2=Low[shift2];


int low_shift_time=shift1;

if ( flag_mode == true ) double flag5=FlagDownUp(High[shift2],Low[shift1],sparam,low_shift_time,"","Left");



Comment("Obje:",sparam);

double fark=((obj_prc2-obj_prc1)/100)*60;


Comment("Fark:",(obj_prc2-obj_prc1)/Point,"/ Kazanç:",fark/Point);


string name;


name=sparam+"-Low";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc1,obj_time1+15000*PeriodSeconds(),obj_prc1);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

name=sparam+"-LowEQ";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc1+(obj_prc2-obj_prc1)/2,obj_time1+15000*PeriodSeconds(),obj_prc1+(obj_prc2-obj_prc1)/2);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


name=sparam+"-LowEQSL";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2-(((obj_prc2-obj_prc1)/100)*21),obj_time1+15000*PeriodSeconds(),obj_prc2-(((obj_prc2-obj_prc1)/100)*21));
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);






for (int i=0;i<5;i++) {

name=sparam+"-High-"+i;
ObjectDelete(ChartID(),name);
if ( i > 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2+(fark*i),obj_time1+15000*PeriodSeconds(),obj_prc2+(fark*i));
if ( i == 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2,obj_time1+15000*PeriodSeconds(),obj_prc2);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
if ( i > 0 ) ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

}

double farks=((obj_prc2-obj_prc1)/100)*30;

for (int i=0;i<5;i++) {

name=sparam+"-HighEq-"+i;
ObjectDelete(ChartID(),name);
if ( i > 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2+(fark*i)+farks,obj_time1+15000*PeriodSeconds(),obj_prc2+(fark*i)+farks);
if ( i == 0 ) ObjectCreate(ChartID(),name,OBJ_TREND,0,obj_time2,obj_prc2+farks,obj_time1+15000*PeriodSeconds(),obj_prc2+farks);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);

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



/*
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
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_WIDTH,2);*/
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
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);




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

/*
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
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_WIDTH,1); */




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
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   
   
   name = w+"Flag5Lows"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],high_price,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
        


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
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);



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


//////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
void OrderRiskReward(){


string rr_list = "";



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
if ( OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP )  {

if ( OrderStopLoss() !=  0 && OrderTakeProfit() != 0 && OrderSymbol() == Symbol() ) {

double rr=(OrderTakeProfit()-OrderOpenPrice())/(OrderOpenPrice()-OrderStopLoss());

rr_list = rr_list + "\n " + OrderTicket() + "-BUY: " + DoubleToString(rr,2);


         string name="Order"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderOpenPrice());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
         
         name="OrderSL"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderStopLoss());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
         
         name="OrderTP"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderTakeProfit());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
                  
         
                  
         



}

}

if ( OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP )  {




if ( OrderStopLoss() !=  0 && OrderTakeProfit() != 0 && OrderSymbol() == Symbol() ) {

double rr=(OrderTakeProfit()-OrderOpenPrice())/(OrderOpenPrice()-OrderStopLoss());
rr_list = rr_list + "\n " + OrderTicket() + "-SELL: "+ DoubleToString(rr,2);

         string name="Order"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderOpenPrice());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
         
         name="OrderSL"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderStopLoss());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);
         
         name="OrderTP"+OrderTicket();
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TEXT,0,Time[WindowFirstVisibleBar()-30],OrderTakeProfit());
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite); 
         //ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         ObjectSetString(0,name,OBJPROP_TEXT,OrderTicket()+" / "+DoubleToString(rr,2));
         //ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);  
         ObjectSetInteger(0,name,OBJPROP_FONTSIZE,7);




}
}



 }
 
 Comment(rr_list);
 
 
 //Print("Live:",coms);
 
};
    

    
    
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);
    

string GetStringPeriyod(string per) {

int TVL_time="";

        if ( per == "MN1" ) TVL_time=PERIOD_MN1;
        if ( per == "W1" ) TVL_time=PERIOD_W1;
        if ( per == "D1") TVL_time=PERIOD_D1;
        if ( per == "H4" ) TVL_time=PERIOD_H4;
        if ( per == "H1" ) TVL_time=PERIOD_H1;
        if ( per == "M30" ) TVL_time=PERIOD_M30;
        if ( per == "M15" ) TVL_time=PERIOD_M15;
        if ( per == "M5" ) TVL_time=PERIOD_M5;
        if ( per == "M1" ) TVL_time=PERIOD_M1;
        
        if ( per == "M2" ) TVL_time=PERIOD_M2;
        if ( per == "M3" ) TVL_time=PERIOD_M3;
        if ( per == "M4" ) TVL_time=PERIOD_M4;
        if ( per == "M6" ) TVL_time=PERIOD_M6;
        if ( per == "M10" ) TVL_time=PERIOD_M10;
        if ( per == "M12" ) TVL_time=PERIOD_M12;
        
        if ( per == "H2" ) TVL_time=PERIOD_H2;
        if ( per == "H3" ) TVL_time=PERIOD_H3;
        if ( per == "H4" ) TVL_time=PERIOD_H4;
        if ( per == "H6" ) TVL_time=PERIOD_H6;
        if ( per == "H8" ) TVL_time=PERIOD_H8; 
        if ( per == "H12" ) TVL_time=PERIOD_H12; 
         
              

return TVL_time;

}

//////////////////////////////////////////////////////////////////////
string TFtoStr(int period) {

string demo="";

if (IsDemo()) demo="MFF ";


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
  
     
      case 2: return(demo+"M2"); break;
      case 3: return(demo+"M3"); break;
      case 4: return(demo+"M4"); break;     
      case 6: return(demo+"M6"); break;
      case 10: return(demo+"M10");break;
      case 12: return(demo+"M12");break;
      case 16385: return(demo+"H1");break;
      case 16386: return(demo+"H2");break;
      case 16387: return(demo+"H3");break;
      case 16388: return(demo+"H4");break;
      case 16390: return(demo+"H6");break;
      case 16392: return(demo+"H8");break;
      case 16396: return(demo+"H12");break;
      case 16408: return(demo+"D1");break;
      case 32769: return(demo+"W1");break;
      case 49153: return(demo+"MN1");break;      
  
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}
        /*
bool IsDemo()
  {
   if(AccountInfoInteger(ACCOUNT_TRADE_MODE)==ACCOUNT_TRADE_MODE_DEMO)
      return(true);
   else
      return(false);
  }
              

int WindowFirstVisibleBar() {

int sonuc=0;

sonuc=ChartGetInteger(ChartID(),CHART_FIRST_VISIBLE_BAR,0);

return sonuc;
}

int WindowBarsPerChart() {

int sonuc=0;

sonuc=ChartGetInteger(ChartID(),CHART_VISIBLE_BARS,0);

return sonuc;
}
     */ 
      
      
int Pat() {


//--- create timer
   //EventSetTimer(60);
   
   //string sym=Symbol();
   //ENUM_TIMEFRAMES per=Period();
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   
   if ( select_per != per ) return(INIT_SUCCEEDED);
   
   symi=Symbol();
   peri=Period();
   
   
    
   
   //ObjectsDeleteAll(ChartID(),-1,-1);
   
   double bar_ortalama=BarOrtalama(1,300,sym,per);
   
   int b=Bars;
   



//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SHORT
//////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   for (int i=b;i>0;i--) {
   
   
   int inside_bar=0;
   int inside_shift=0;
   bool find=false;
   
   
   
   
   for (int r=i-1;r>i-15;r--) {
    
   if ( //Closei(i) > Openi(i) && 
   Highi(i) > Openi(r) &&  Highi(i) > Closei(r) && Lowi(i) < Openi(r) && Lowi(i) < Closei(r) && find==false) {
   inside_bar=inside_bar+1;
   inside_shift=r;
   } else {
   find=true;
   }
   
   }
   
   
   if ( inside_bar > 0 && Openi(inside_shift-1) > Closei(inside_shift-1) && Closei(inside_shift-1) < Lowi(i) && find == true ) {
   
   
   bool bar_find=false;
   int bar_down=0;
   for (int f=i+1;f<i+10;f++) {   
   
   if ( Openi(f) > Closei(f) && bar_find == false ) {
   bar_down=bar_down+1;
   } else{
   bar_find=true;
   }
   
   
   }
   
   
   if ( bar_down >= 3 ) {

   
   //int pips=(Lowi(i+(bar_down))-Highi(i))/MarketInfo(symi,MODE_POINT);
   int pips=(Highi(i+(bar_down))-Highi(i))/MarketInfo(symi,MODE_POINT);
   
   //double fark=(Lowi(i+(bar_down))-Highi(i));
   double fark=(Highi(i+(bar_down))-Highi(i));
   double yuzde=DivZero(fark,100);
   double yuzde30=yuzde*30;
   double yuzde60=yuzde*60;
   
   double ortalama_pips=DivZero((Highi(i+(bar_down))-Highi(i)),bar_ortalama);
   
   if ( ortalama_pips < 1 ) continue;
   
   string name="VLINEH"+i;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Timei(i),Highi(i),Timei(i-(inside_bar+1)),Lowi(i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   
   name="VLINEENTRY"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Highi(i),Timei(i+(bar_down)),Lowi(i+(bar_down)));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(inside_shift-1),Closei(inside_shift-1),Timei(inside_shift-1)+5*PeriodSeconds(),Closei(inside_shift-1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+ortalama_pips);   
   
   name="VLINET"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Highi(i),Timei(i+(bar_down)),Lowi(i+(bar_down)));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Highi(i),Timei(i+(bar_down)),Highi(i+(bar_down)));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+ortalama_pips);
   

   name="VLINED60"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-(inside_bar+1)),Lowi(i)-yuzde60);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-((inside_bar+1)+bar_down)),Lowi(i)-yuzde60);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i)+((inside_bar+1)+bar_down)*PeriodSeconds(),Lowi(i)-yuzde60);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips);
   
   name="VLINED30"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-(inside_bar+1)),Lowi(i)-yuzde60);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-((inside_bar+1)+bar_down)),Lowi(i)-yuzde60);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i)+((inside_bar+1)+bar_down)*PeriodSeconds(),Lowi(i)-yuzde30);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+bar_ortalama);
         

   
   }



   }
   
   
   }
////////////////////////////////////////////////////////////////////////////////////////////////////////////   
// LONG  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   for (int i=b;i>0;i--) {
   
   
   int inside_bar=0;
   int inside_shift=0;
   bool find=false;
   
   
   
   
   for (int r=i-1;r>i-15;r--) {
    
   if ( //Closei(i) > Openi(i) && 
   Highi(i) > Openi(r) &&  Highi(i) > Closei(r) && Lowi(i) < Openi(r) && Lowi(i) < Closei(r) && find==false) {
   inside_bar=inside_bar+1;
   inside_shift=r;
   } else {
   find=true;
   }
   
   }
   
   
   if ( inside_bar > 0 && Closei(inside_shift-1) > Openi(inside_shift-1) && Closei(inside_shift-1) > Highi(i) && find == true ) {
   
   
   bool bar_find=false;
   int bar_up=0;
   for (int f=i+1;f<i+10;f++) {   
   
   if ( Closei(f) > Openi(f) && bar_find == false ) {
   bar_up=bar_up+1;
   } else{
   bar_find=true;
   }
   
   
   }
   
   
   if ( bar_up >= 3 ) {

   
   //int pips=(Lowi(i+(bar_down))-Highi(i))/MarketInfo(symi,MODE_POINT);
   int pips=(Lowi(i)-Lowi(i+(bar_up)))/MarketInfo(symi,MODE_POINT);
   
   //double fark=(Lowi(i+(bar_down))-Highi(i));
   double fark=(Lowi(i+(bar_up))-Lowi(i));
   double yuzde=DivZero(fark,100);
   double yuzde30=yuzde*30;
   double yuzde60=yuzde*60;
   
   double ortalama_pips=DivZero((Lowi(i)-Lowi(i+(bar_up))),bar_ortalama);
   
   if ( ortalama_pips < 1 ) continue;
   
   string name="VLINEH"+i;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Timei(i),Highi(i),Timei(i-(inside_bar+1)),Lowi(i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   

 


   name="VLINEENTRY"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Highi(i),Timei(i+(bar_down)),Lowi(i+(bar_down)));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(inside_shift-1),Closei(inside_shift-1),Timei(inside_shift-1)+5*PeriodSeconds(),Closei(inside_shift-1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+ortalama_pips);
      
   
   name="VLINET"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Highi(i),Timei(i+(bar_down)),Lowi(i+(bar_down)));
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i),Lowi(i),Timei(i+(bar_up)),Lowi(i+(bar_up)));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+ortalama_pips);
   

   name="VLINED60"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-(inside_bar+1)),Lowi(i)-yuzde60);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-((inside_bar+1)+bar_down)),Lowi(i)-yuzde60);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Highi(i),Timei(i)+((inside_bar+1)+bar_up)*PeriodSeconds(),Highi(i)-yuzde60);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips);
   
   name="VLINED30"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-(inside_bar+1)),Lowi(i)-yuzde60);
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Lowi(i),Timei(i-((inside_bar+1)+bar_down)),Lowi(i)-yuzde60);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Timei(i-(inside_bar+1)),Highi(i),Timei(i)+((inside_bar+1)+bar_up)*PeriodSeconds(),Highi(i)-yuzde30);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,pips+"/"+bar_ortalama);
         

   
   }



   }
   
   
   }
////////////////////////////////////////////////////////////////////////////////////////////////////////////   

ChartRedraw();

return(INIT_SUCCEEDED);



}                  

 
   int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}  


///////////////////////////////////////////////////////////////////////////
/// Pattern 5.0
///////////////////////////////////////////////////////////////////////////


void Pattern5(string sparams) {


if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparams,"Trendx",0) == -1 && StringFind(sparams,"Level",0) == -1 ) {

Comment("Trend:",sparams);

last_select_object=sparams;

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

double high_price;
double low_price;

if ( obj_prc1 > obj_prc2 ) {



int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),last_select_object,0,obj_time1,High[shift]);
high_price=High[shift];
obj_prc1=high_price;
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),last_select_object,1,obj_time2,Low[shift]);
low_price=Low[shift];
obj_prc2=low_price;


   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0; 

string name=last_select_object+"Pattern5 ";

datetime ty_start_time=obj_time1;
datetime ty_end_time=obj_time1+300*PeriodSeconds();

double level;
string levels;

//if ( mode == false ) {

  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2,low_price-level,obj_time2+10*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  
  
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  double price=low_price-level;

  level=level1240;
  levels="d1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);



int z1=8;
int z2=16;
int z3=64;
///////////////////////////////////////////////////////
if ( (obj_time1-obj_time2)/PeriodSeconds() > 10 ) {
z1=4;
z2=8;
z3=12;
 }
 
 

  level=level1240;
  levels="df1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time1,high_price,obj_time2+((obj_time1-obj_time2)*z1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="df618";  
           double yuzdes = DivZero(high_price-(low_price-level1240), 100);   
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),low_price-level1240,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  level=level618;
  levels="dfabcd";  
           //double yuzdes = DivZero(high_price-(low_price-level1240), 100);   
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),low_price-level1240,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
  level=level618;
  levels="dff1240";  
           //double yuzdes = DivZero(high_price-(low_price-level1240), 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  //ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*16),(low_price-level1240)+yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*64),((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));
  if ( obj_time2+((obj_time1-obj_time2)*z3) < TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*z3),((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));
  if ( obj_time2+((obj_time1-obj_time2)*z3) > TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8,Time[0],((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
     

//}
       
shift=iBarShift(Symbol(),Period(),obj_time1);

ObjectDelete(ChartID(),"v");
ObjectCreate(ChartID(),"v",OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"v",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"v",OBJPROP_WIDTH,2);

int say=0;
bool first=false;
bool find=false;
int last_i=0;


datetime up_time=ty_start_time;
      
for (int i=shift;i>0;i--){

ObjectDelete(ChartID(),"v"+i);

if ( first==false && price > Low[i]) {
if ( low_price > Low[i] ) {
Print(low_price,"/",Low[i]);
//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
low_price=Low[i];
ty_start_time=Time[i];
ty_end_time=Time[i]+500*PeriodSeconds();
last_i=i;
//first=true;


/*
say=0;


for (int r=i;r>i-50;r--){

if ( r < 0 ) continue;

if ( low_price < Low[r] ) {
say=say+1;
if ( say == 20 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
} else {
say=0;
}


}
*/

}


if ( last_i-i > 10 ) {
first=true;
}

/*
if ( first == true ) {

if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;
Print(i);
} else {
say=say+1;
Print(i);
if ( say == 10 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}

}
*/


}



/*
if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;

Print(i);

} else {
say=say+1;
//Print(i);
if ( say == 10 ) find=true;

//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}
*/


}

  level=level618s;
  levels="Trendx";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);  
  
  levels="Trendy";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,low_price,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  //ObjectSetString(ChartID(),name+"LevelT"+levels,OBJPROP_TOOLTIP,"YY");
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
    

  levels="Trendl";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2),ty_start_time+((obj_time1-obj_time2)*9),low_price+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  //ObjectSetString(ChartID(),name+"LevelT"+levels,OBJPROP_TOOLTIP,"YY");
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  
    

  level=level618s;
  levels="Trendq";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2),ty_start_time+(((obj_time1-obj_time2))+((ty_start_time-obj_time1))),(low_price+(obj_prc1-obj_prc2))-(high_price-low_price));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGreen);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);
  
  
       
   yuzde = DivZero(high_price-low_price, 100);           
   level50=low_price+yuzde*50; // 50
   level786=low_price+yuzde*78.6; // 50
   level618s=low_price+yuzde*61.8; // 50

       
       
//if ( mode == true ) {

  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



//}         
         
            

}

/////////////////////////////////////////////////////////////////////////////////////////////////


if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam");


int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),last_select_object,0,obj_time1,Low[shift]);
low_price=Low[shift];
obj_prc1=low_price;
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),last_select_object,1,obj_time2,High[shift]);
high_price=High[shift];
obj_prc2=high_price;


   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
  
   
   double level0=0;
   double level100=0; 

string name=last_select_object+"Pattern5 ";

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

double level;
string levels;



//if ( mode == false ) {

  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2,low_price-level,obj_time2+10*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  
  
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  double price=high_price+level;

  level=level1240;
  levels="d1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


int z1=8;
int z2=16;
int z3=64;
///////////////////////////////////////////////////////
if ( (obj_time1-obj_time2)/PeriodSeconds() > 10 ) {
z1=4;
z2=8;
z3=12;
 }
 

  level=level1240;
  levels="df1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time1,low_price,obj_time2+((obj_time1-obj_time2)*z1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="df618";  
           double yuzdes = DivZero((high_price+level1240)-low_price, 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),high_price+level1240,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="dfabcd";  
           //double yuzdes = DivZero((high_price+level1240)-low_price, 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),high_price+level1240,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-+(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
  
  level=level618;
  levels="dff1240";  
           
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  if ( obj_time2+((obj_time1-obj_time2)*64) < TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*z3),(high_price+level1240)-yuzdes*61.8+((high_price+level1240)-low_price));
  if ( obj_time2+((obj_time1-obj_time2)*64) > TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8,Time[0],(high_price+level1240)-yuzdes*61.8+((high_price+level1240)-low_price));  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
     

//}

//return;


       
shift=iBarShift(Symbol(),Period(),obj_time1);

ObjectDelete(ChartID(),"v");
ObjectCreate(ChartID(),"v",OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"v",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"v",OBJPROP_WIDTH,2);

int say=0;
bool first=false;
bool find=false;
int last_i=0;


datetime up_time=ty_start_time;
      
for (int i=shift;i>0;i--){

ObjectDelete(ChartID(),"v"+i);

if ( first==false && price < High[i]) {
if ( high_price < High[i] ) {
Print(high_price,"/",High[i]);
//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
high_price=High[i];
ty_start_time=Time[i];
ty_end_time=Time[i]+500*PeriodSeconds();
last_i=i;
//first=true;


/*
say=0;


for (int r=i;r>i-50;r--){

if ( r < 0 ) continue;

if ( low_price < Low[r] ) {
say=say+1;
if ( say == 20 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
} else {
say=0;
}


}
*/

}


if ( last_i-i > 10 ) {
first=true;
}

/*
if ( first == true ) {

if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;
Print(i);
} else {
say=say+1;
Print(i);
if ( say == 10 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}

}
*/


}



/*
if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;

Print(i);

} else {
say=say+1;
//Print(i);
if ( say == 10 ) find=true;

//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}
*/


}

  level=level618s;
  levels="Trendx";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,obj_time1,low_price,ty_start_time,high_price);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);


  level=level618s;
  levels="Trendy";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  //return;
  

  level=level618s;
  levels="Trendl";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1),ty_start_time+((obj_time1-obj_time2)*9),high_price-(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  //return;
  

  level=level618s;
  levels="Trendq";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1),ty_start_time+(((obj_time1-obj_time2))+((ty_start_time-obj_time1))),(high_price-(obj_prc2-obj_prc1))+(high_price-low_price));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGreen);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);
      
  
  
       
   yuzde = DivZero(high_price-low_price, 100);           
   level50=high_price-yuzde*50; // 50
   level786=high_price-yuzde*78.6; // 50
   level618s=high_price-yuzde*61.8; // 50

       
       
//if ( mode == true ) {

  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price-level,ty_end_time,high_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



//}         
         
            

}

          
ChartRedraw(ChartID());          
          
}

}