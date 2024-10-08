//+------------------------------------------------------------------+
//|                                                    SkyperXau.mq4 |
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

int day=-1;

int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   ObjectsDeleteAll();
   
   ChartSetInteger(ChartID(),CHART_SCALE,2);
   
   Comment(ChartGetInteger(ChartID(),CHART_SCALE));
   
   
   
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

if ( IsTesting() ) OnTimer();
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

Comment(int(TimeDay(TimeCurrent())));



double Lot=0.01;

   
   if ( int(TimeHour(TimeCurrent())) == 15 && int(TimeMinute(TimeCurrent())) == 25 && int(TimeDay(TimeCurrent())) != day ) {

   
   ObjectCreate(ChartID(),int(TimeMonth(TimeCurrent()))+"V"+int(TimeDay(TimeCurrent())),OBJ_VLINE,0,Time[1],Ask);
   
   day=int(TimeDay(TimeCurrent()));
   
   
          double yuzde=DivZero(WindowPriceMax()-WindowPriceMin(),100);
          
          double level_prc=DivZero(Bid-WindowPriceMin(),yuzde);
          
          if ( level_prc > 70 ) {
          
          OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,Bid-100*Point,"",0,0,clrNONE);
          //OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Ask+500*Point,Bid-100*Point,"",0,0,clrNONE);
          
          }
          
          if ( level_prc < 30 ) {
          
          //OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Bid-500*Point,Ask+100*Point,"",0,0,clrNONE);
          OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,Ask+100*Point,"",0,0,clrNONE);
          
          }          
     
   
   
   
   
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


if ( sparam == 45 ) {

   ChartSetInteger(ChartID(),CHART_SCALE,2);
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,True);
   ChartNavigate(ChartID(),CHART_END,3000);   
   
      //Comment(ChartGetInteger(ChartID(),CHART_SCALE));
}
   
  }
//+------------------------------------------------------------------+
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 