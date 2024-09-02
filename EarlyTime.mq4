//+------------------------------------------------------------------+
//|                                                    EarlyTime.mq4 |
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
   
   for ( int i=0;i<10;i++) {
   
  string start_time="07:20"; // 8.20
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(int(TimeDay(TimeCurrent()))-i)+" "+start_time;
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_start_time=some_time;


  string end_time="10:25";// 11.25
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(int(TimeDay(TimeCurrent()))-i)+" "+end_time;
  some_time = StringToTime(yenitarih);
  
  datetime ty_end_time=some_time;
  
  
  ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,ty_start_time,Ask);
  ObjectCreate(ChartID(),"S"+i,OBJ_VLINE,0,ty_end_time,Ask);
  ObjectSetInteger(ChartID(),"S"+i,OBJPROP_COLOR,clrYellow);
  
  
  
  
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
   
  }
//+------------------------------------------------------------------+
