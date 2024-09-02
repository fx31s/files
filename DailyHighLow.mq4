//+------------------------------------------------------------------+
//|                                                 DailyHighLow.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
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
   
   int day=TimeDay(TimeCurrent());
   
   Print(day);
   
   for(int i=1;i<5000;i++) {
   
   if ( day != TimeDay(Time[i]) ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   day=TimeDay(Time[i]);
   
   
   }
   
   
   }
   
   
   for(int i=5000;i>1;i--) {
   
   if ( day != TimeDay(Time[i]) ) {
   
   ObjectCreate(ChartID(),"N"+i,OBJ_VLINE,0,Time[i],Ask);
   day=TimeDay(Time[i]);
   
   
   }
   
   
   }
   
   
   
   
   
   
   
   
   
   return 0;
   
   
  string saat="23";
  string dakika="54";

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-1)+" "+saat+":"+dakika;
  datetime some_time = StringToTime(yenitarih);
  
   int shift=iBarShift(sym,PERIOD_M1,some_time);
   
   ObjectCreate(ChartID(),"VLINE",OBJ_VLINE,0,Time[shift],Ask);
   
   
  saat="01";
  dakika="00";

  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-1)+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);
  
   shift=iBarShift(sym,PERIOD_M1,some_time);
   
   ObjectCreate(ChartID(),"VLINEE",OBJ_VLINE,0,Time[shift],Ask);
   
   
   
   
   
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
