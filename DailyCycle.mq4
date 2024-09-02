//+------------------------------------------------------------------+
//|                                                   DailyCycle.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);


   string name="TokyoSession";
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
       
  
int tday=TimeDay(TimeCurrent());
for(int t=tday-1;t>0;t--) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);


   string name="TokyoSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
 
 }  
   
   
        
   
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

if ( sparam == 45 ) {DailyCycle();}
   
  }
//+------------------------------------------------------------------+


void DailyCycle() {

   ObjectsDeleteAll();

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);


   string name="TokyoSession";
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
       
  
int tday=TimeDay(TimeCurrent());
for(int t=tday-1;t>0;t--) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);

   string name="TokyoSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);




  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 15:25";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 17:00";
  some_time = StringToTime(yenitarih);
  
  ty_work_start_time=some_time;
  ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 17:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 18:00";
  some_time = StringToTime(yenitarih);
  ty_work_end_time=some_time;
  ty_work_end_shift=iBarShift(sym,per,some_time);

   name="LondonSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   
   

  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 02:00";
  some_time = StringToTime(yenitarih);
  
  ty_work_start_time=some_time;
  ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 03:00";
  some_time = StringToTime(yenitarih);
  ty_work_end_time=some_time;
  ty_work_end_shift=iBarShift(sym,per,some_time);

   name="NewyorkSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,False);
   
   
      
    
 }  
   
   
   
   }