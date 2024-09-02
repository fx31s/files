//+------------------------------------------------------------------+
//|                                                    Wednesday.mq4 |
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
   
   
   //if ( Period() != PERIOD_D1 ) return(INIT_SUCCEEDED);
   
   
   ObjectsDeleteAll();
   
   
   for(int t=5;t<3000;t++) {
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 16 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 30 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,Time[t],High[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
      
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 17 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 00 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,Time[t],High[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightBlue);   
   
   }
      
   
   continue;
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_H1,t))) == 17 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_RECTANGLE,0,Time[t],High[t],Time[t-1],Low[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_H1,t))) == 15 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_RECTANGLE,0,Time[t],High[t],Time[t-1],Low[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightBlue);   
   
   }
      
   if ( int(TimeHour(iTime(Symbol(),PERIOD_H1,t))) == 11 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_RECTANGLE,0,Time[t],High[t],Time[t-1],Low[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightYellow);   
   
   }
   
   
         
   
   continue;
   
   
   
   if ( iHigh(Symbol(),PERIOD_D1,t+1) < iHigh(Symbol(),PERIOD_D1,t) && iHigh(Symbol(),PERIOD_D1,t-1) < iHigh(Symbol(),PERIOD_D1,t) ) {

   ObjectCreate(ChartID(),"RECi"+t,OBJ_TREND,0,Time[t],High[t],Time[t-4],High[t]);
   ObjectSetInteger(ChartID(),"RECi"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"RECi"+t,OBJPROP_COLOR,clrLightGray);   
   ObjectSetInteger(ChartID(),"RECi"+t,OBJPROP_RAY,False);
   }
   

   if ( iLow(Symbol(),PERIOD_D1,t+1) > iLow(Symbol(),PERIOD_D1,t) && iLow(Symbol(),PERIOD_D1,t-1) > iLow(Symbol(),PERIOD_D1,t) ) {

   ObjectCreate(ChartID(),"RECl"+t,OBJ_TREND,0,Time[t],Low[t],Time[t-4],Low[t]);
   ObjectSetInteger(ChartID(),"RECl"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"RECl"+t,OBJPROP_COLOR,clrLightGray);   
   ObjectSetInteger(ChartID(),"RECl"+t,OBJPROP_RAY,False);
   }
   
      
   
   int weekday=TimeDayOfWeek(iTime(Symbol(),PERIOD_D1,t));
   
   
   if ( weekday == 3 ) {
   
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_RECTANGLE,0,Time[t],High[t],Time[t-1],Low[t]);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);
   
   
   
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
