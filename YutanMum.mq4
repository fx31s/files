//+------------------------------------------------------------------+
//|                                                     YutanMum.mq4 |
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
   
   
   for (int i=3;i<Bars-100;i++) {
   
   
   if ( Open[i+1] > Close[i+1] && Close[i] > Open[i] && Close[i-1] > Open[i-1]  && High[i] > High[i+1] && Low[i] <= Low[i+1] ) {
   
   string name="YTH"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i+1],High[i],Time[i]+10*PeriodSeconds(),High[i]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   
   name="YTL"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i+1],Low[i],Time[i]+10*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   
   name="YTN"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i-1],High[i-1],Time[i]+10*PeriodSeconds(),High[i-1]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   
   
   }
   

   if ( Open[i+1] < Close[i+1] && Close[i] < Open[i] && Close[i-1] < Open[i-1] && High[i] >= High[i+1] && Low[i] < Low[i+1] ) {
   
   string name="YTH"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i+1],High[i],Time[i]+10*PeriodSeconds(),High[i]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   
   name="YTL"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i+1],Low[i],Time[i]+10*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   
   name="YTN"+Time[i];
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i-1],Low[i-1],Time[i]+10*PeriodSeconds(),Low[i-1]);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrange);
   
   }
   
   
   
   
   
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
